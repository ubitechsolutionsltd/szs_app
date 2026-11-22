// Offline downloads: one at a time, resumable (HTTP Range), stored in the app's private folder.
// Not available on web.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'media_access.dart';
import 'player_core.dart';

enum DownloadStatus { none, waiting, downloading, completed, failed }

class DownloadState {
  const DownloadState(this.status,
      {this.receivedBytes = 0, this.totalBytes = 0, this.locked = false});

  final DownloadStatus status;
  final int receivedBytes;
  final int totalBytes;

  /// Failed because the episode is not unlocked (as opposed to a network problem).
  final bool locked;

  double? get fraction =>
      totalBytes > 0 ? (receivedBytes / totalBytes).clamp(0.0, 1.0) : null;
}

class DownloadedEpisode {
  const DownloadedEpisode(
      {required this.item,
      required this.path,
      required this.bytes,
      required this.downloadedAtMs});

  final PlayableItem item;
  final String path;
  final int bytes;
  final int downloadedAtMs;

  Map<String, dynamic> toJson() => {
        'item': item.toJson(),
        'path': path,
        'bytes': bytes,
        'at': downloadedAtMs,
      };

  factory DownloadedEpisode.fromJson(Map<dynamic, dynamic> json) =>
      DownloadedEpisode(
        item: PlayableItem.fromJson(json['item'] as Map),
        path: json['path']?.toString() ?? '',
        bytes: (json['bytes'] as num?)?.toInt() ?? 0,
        downloadedAtMs: (json['at'] as num?)?.toInt() ?? 0,
      );
}

class DownloadManager {
  DownloadManager._();
  static final DownloadManager instance = DownloadManager._();

  /// Per-episode state, for progress bars and "downloaded" badges.
  final ValueNotifier<Map<int, DownloadState>> states = ValueNotifier({});

  final Map<int, DownloadedEpisode> _index = {};
  final List<PlayableItem> _queue = [];
  final Set<int> _cancelled = {};
  Directory? _directory;
  bool _ready = false;
  bool _working = false;
  DateTime _lastProgressUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  bool get supported => !kIsWeb;

  List<DownloadedEpisode> get downloaded => _index.values.toList()
    ..sort((a, b) => b.downloadedAtMs.compareTo(a.downloadedAtMs));

  int get totalBytes => _index.values.fold(0, (sum, e) => sum + e.bytes);

  bool isDownloaded(int id) => _index.containsKey(id);

  DownloadState stateOf(int id) =>
      states.value[id] ?? const DownloadState(DownloadStatus.none);

  Future<void> init() async {
    if (_ready || !supported) return;
    _ready = true;
    try {
      final base = await getApplicationSupportDirectory();
      _directory = Directory('${base.path}/downloads');
      await _directory!.create(recursive: true);

      final indexFile = File('${_directory!.path}/index.json');
      if (await indexFile.exists()) {
        final raw = jsonDecode(await indexFile.readAsString());
        if (raw is List) {
          for (final entry in raw) {
            if (entry is Map) {
              final episode = DownloadedEpisode.fromJson(entry);
              if (episode.path.isNotEmpty && await File(episode.path).exists()) {
                _index[episode.item.id] = episode;
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('DownloadManager.init: $e');
    }
    _emit({for (final id in _index.keys) id: const DownloadState(DownloadStatus.completed)});
  }

  /// The downloaded file for an episode, or null.
  Future<File?> localFile(int id) async {
    final entry = _index[id];
    if (entry == null) return null;
    final file = File(entry.path);
    if (await file.exists()) return file;
    _index.remove(id);
    await _saveIndex();
    _setState(id, const DownloadState(DownloadStatus.none));
    return null;
  }

  void download(PlayableItem item) {
    if (!supported || isDownloaded(item.id)) return;
    final current = stateOf(item.id).status;
    if (current == DownloadStatus.waiting || current == DownloadStatus.downloading) return;
    _cancelled.remove(item.id);
    _queue.add(item);
    _setState(item.id, const DownloadState(DownloadStatus.waiting));
    unawaited(_pump());
  }

  Future<void> cancel(int id) async {
    _cancelled.add(id);
    _queue.removeWhere((i) => i.id == id);
    if (stateOf(id).status == DownloadStatus.waiting) {
      _setState(id, const DownloadState(DownloadStatus.none));
    }
  }

  Future<void> remove(int id) async {
    await cancel(id);
    final entry = _index.remove(id);
    if (entry != null) {
      try {
        await File(entry.path).delete();
      } catch (_) {}
      await _saveIndex();
    }
    await _deletePartial(id);
    _setState(id, const DownloadState(DownloadStatus.none));
  }

  Future<void> removeAll() async {
    for (final id in _index.keys.toList()) {
      await remove(id);
    }
  }

  Future<void> _pump() async {
    if (_working) return;
    _working = true;
    try {
      while (_queue.isNotEmpty) {
        final item = _queue.removeAt(0);
        if (_cancelled.contains(item.id)) continue;
        await _downloadOne(item);
      }
    } finally {
      _working = false;
    }
  }

  Future<void> _downloadOne(PlayableItem item) async {
    final directory = _directory;
    if (directory == null) {
      _setState(item.id, const DownloadState(DownloadStatus.failed));
      return;
    }

    _setState(item.id, const DownloadState(DownloadStatus.downloading));

    var url = item.remoteUrl;
    if (url.isEmpty) {
      _setState(item.id, const DownloadState(DownloadStatus.failed, locked: true));
      return;
    }
    final access = await MediaAccess.instance.refresh(url);
    if (access.locked) {
      _setState(item.id, const DownloadState(DownloadStatus.failed, locked: true));
      return;
    }
    url = access.url ?? url;

    final partial = File('${directory.path}/${item.id}.part');
    final client = http.Client();
    try {
      var existing = await partial.exists() ? await partial.length() : 0;

      final request = http.Request('GET', Uri.parse(url))
        ..headers.addAll(MediaAccess.instance.headersFor(url));
      if (existing > 0) request.headers['Range'] = 'bytes=$existing-';

      final response = await client.send(request).timeout(const Duration(seconds: 30));

      if (response.statusCode == 416) {
        // The partial file does not match the server's: start over next time.
        await _deletePartial(item.id);
        _setState(item.id, const DownloadState(DownloadStatus.failed));
        return;
      }
      if (response.statusCode != 200 && response.statusCode != 206) {
        _setState(
          item.id,
          DownloadState(DownloadStatus.failed, locked: response.statusCode == 403),
        );
        return;
      }

      final resuming = response.statusCode == 206 && existing > 0;
      if (!resuming) existing = 0;
      final expected = response.contentLength;
      final total = expected == null ? 0 : existing + expected;
      var received = existing;

      final sink = partial.openWrite(mode: resuming ? FileMode.append : FileMode.write);
      try {
        await for (final chunk in response.stream) {
          if (_cancelled.contains(item.id)) {
            _setState(item.id, const DownloadState(DownloadStatus.none));
            return;
          }
          sink.add(chunk);
          received += chunk.length;
          _reportProgress(item.id, received, total);
        }
        await sink.flush();
      } finally {
        await sink.close();
      }

      if (expected != null && received != total) {
        // Connection dropped early: keep the partial file so the next attempt resumes.
        _setState(item.id, DownloadState(DownloadStatus.failed, receivedBytes: received, totalBytes: total));
        return;
      }

      final extension = extensionForContentType(response.headers['content-type']);
      final finalPath = '${directory.path}/${item.id}.$extension';
      await partial.rename(finalPath);

      _index[item.id] = DownloadedEpisode(
        item: item,
        path: finalPath,
        bytes: received,
        downloadedAtMs: DateTime.now().millisecondsSinceEpoch,
      );
      await _saveIndex();
      _setState(item.id, DownloadState(DownloadStatus.completed, receivedBytes: received, totalBytes: received));
    } catch (e) {
      debugPrint('Download ${item.id} failed: $e');
      _setState(item.id, const DownloadState(DownloadStatus.failed));
    } finally {
      client.close();
    }
  }

  Future<void> _deletePartial(int id) async {
    final directory = _directory;
    if (directory == null) return;
    try {
      final partial = File('${directory.path}/$id.part');
      if (await partial.exists()) await partial.delete();
    } catch (_) {}
  }

  Future<void> _saveIndex() async {
    final directory = _directory;
    if (directory == null) return;
    try {
      await File('${directory.path}/index.json').writeAsString(
        jsonEncode(_index.values.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      debugPrint('DownloadManager._saveIndex: $e');
    }
  }

  void _reportProgress(int id, int received, int total) {
    final now = DateTime.now();
    if (now.difference(_lastProgressUpdate) < const Duration(milliseconds: 300)) return;
    _lastProgressUpdate = now;
    _setState(id, DownloadState(DownloadStatus.downloading, receivedBytes: received, totalBytes: total));
  }

  void _setState(int id, DownloadState state) =>
      _emit({...states.value, id: state});

  void _emit(Map<int, DownloadState> next) => states.value = next;
}
