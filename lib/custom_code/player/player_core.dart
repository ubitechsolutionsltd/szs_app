// Pure Dart (no Flutter, no plugins) so it can be unit-tested: the play queue, auto-next, shuffle/repeat rules,
// signed-URL freshness, resume positions and playlists. The audio engine lives in player_service.dart.

import 'dart:math';

/// Repeat behaviour of the queue.
enum QueueRepeat { off, all, one }

/// One playable episode (or any audio file).
class PlayableItem {
  const PlayableItem({
    required this.id,
    required this.title,
    this.subtitle = '',
    this.artUrl = '',
    this.remoteUrl = '',
    this.contentId = 0,
    this.durationSeconds = 0,
    this.raw,
  });

  final int id;
  final int contentId;
  final String title;
  final String subtitle;
  final String artUrl;

  /// Link returned by the API (a gate link, usually signed). Empty when the episode is locked.
  final String remoteUrl;
  final int durationSeconds;

  /// The episode map this item was built from, kept so a locked episode can be bought automatically (when
  /// advancing playback, or resuming a failed download) without a second network round trip to re-fetch it.
  /// Transient: never persisted (not in [toJson]/[fromJson]), so a restored session simply has no auto-buy.
  final dynamic raw;

  bool get hasRemoteUrl => remoteUrl.isNotEmpty;

  /// Builds an item from an episode as the API (snake_case) or an EpisodeStruct map (camelCase) returns it.
  factory PlayableItem.fromEpisodeMap(Map<dynamic, dynamic> episode,
      {String subtitle = ''}) {
    int asInt(dynamic v) =>
        v is num ? v.toInt() : (int.tryParse(v?.toString() ?? '') ?? 0);
    String asString(dynamic v) => v?.toString() ?? '';
    dynamic pick(String snake, String camel) => episode[snake] ?? episode[camel];

    return PlayableItem(
      id: asInt(episode['id']),
      contentId: asInt(pick('content_id', 'contentId')),
      title: asString(episode['name']),
      subtitle: subtitle,
      artUrl: asString(episode['image']),
      remoteUrl: asString(episode['audio']),
      durationSeconds: asInt(pick('audio_duration', 'audioDuration')),
      raw: episode,
    );
  }

  PlayableItem copyWith({String? remoteUrl, String? subtitle}) => PlayableItem(
        id: id,
        title: title,
        subtitle: subtitle ?? this.subtitle,
        artUrl: artUrl,
        remoteUrl: remoteUrl ?? this.remoteUrl,
        contentId: contentId,
        durationSeconds: durationSeconds,
        raw: raw,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'content_id': contentId,
        'title': title,
        'subtitle': subtitle,
        'art_url': artUrl,
        'remote_url': remoteUrl,
        'duration': durationSeconds,
      };

  factory PlayableItem.fromJson(Map<dynamic, dynamic> json) => PlayableItem(
        id: (json['id'] as num?)?.toInt() ?? 0,
        contentId: (json['content_id'] as num?)?.toInt() ?? 0,
        title: json['title']?.toString() ?? '',
        subtitle: json['subtitle']?.toString() ?? '',
        artUrl: json['art_url']?.toString() ?? '',
        remoteUrl: json['remote_url']?.toString() ?? '',
        durationSeconds: (json['duration'] as num?)?.toInt() ?? 0,
      );

  @override
  bool operator ==(Object other) => other is PlayableItem && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// The play queue: current item, order (optionally shuffled), repeat, skipping unplayable (locked) items.
class PlayQueue {
  PlayQueue({Random? random, bool Function(PlayableItem item)? isPlayable})
      : _random = random ?? Random(),
        _isPlayable = isPlayable ?? ((item) => item.hasRemoteUrl);

  final Random _random;
  bool Function(PlayableItem item) _isPlayable;

  List<PlayableItem> _items = [];
  List<int> _order = []; // play order: indices into _items
  int _pos = -1; // position inside _order
  bool _shuffle = false;
  QueueRepeat repeat = QueueRepeat.off;

  /// Lets the engine treat downloaded episodes as playable even without a link.
  set isPlayable(bool Function(PlayableItem item) value) => _isPlayable = value;

  List<PlayableItem> get items => List.unmodifiable(_items);
  List<PlayableItem> get playOrder =>
      List.unmodifiable(_order.map((i) => _items[i]));
  bool get isEmpty => _items.isEmpty;
  bool get shuffle => _shuffle;

  PlayableItem? get current =>
      (_pos >= 0 && _pos < _order.length) ? _items[_order[_pos]] : null;

  /// Index of the current item in the original (unshuffled) list, or -1.
  int get currentIndex =>
      (_pos >= 0 && _pos < _order.length) ? _order[_pos] : -1;

  void setItems(List<PlayableItem> items, {int startIndex = 0}) {
    _items = List.of(items);
    if (_items.isEmpty) {
      _order = [];
      _pos = -1;
      return;
    }
    final start = startIndex.clamp(0, _items.length - 1);
    _buildOrder(firstIndex: start);
  }

  set shuffle(bool value) {
    if (value == _shuffle) return;
    _shuffle = value;
    if (_items.isEmpty) return;
    _buildOrder(firstIndex: currentIndex < 0 ? 0 : currentIndex);
  }

  void _buildOrder({required int firstIndex}) {
    final indices = List<int>.generate(_items.length, (i) => i);
    if (_shuffle) {
      indices.remove(firstIndex);
      indices.shuffle(_random);
      _order = [firstIndex, ...indices];
      _pos = 0;
    } else {
      _order = indices;
      _pos = firstIndex;
    }
  }

  /// Item that plays after the current one finishes on its own (honours repeat-one and repeat-all).
  PlayableItem? advanceOnComplete() {
    if (current == null) return null;
    if (repeat == QueueRepeat.one && _isPlayable(current!)) return current;
    return _step(1, wrap: repeat == QueueRepeat.all);
  }

  /// Item for the "next" button: ignores repeat-one, wraps only with repeat-all.
  PlayableItem? next() => current == null ? null : _step(1, wrap: repeat == QueueRepeat.all);

  /// "Previous" button: restarts the current item when it has played for a while, else goes back one.
  /// Returns the same item for a restart; the caller seeks to zero when the result equals [current].
  PlayableItem? previous(
      {Duration position = Duration.zero,
      Duration restartThreshold = const Duration(seconds: 3)}) {
    final now = current;
    if (now == null) return null;
    if (position > restartThreshold) return now;
    return _step(-1, wrap: repeat == QueueRepeat.all) ?? now;
  }

  PlayableItem? _step(int direction, {required bool wrap}) {
    if (_order.isEmpty) return null;
    var pos = _pos;
    for (var tries = 0; tries < _order.length; tries++) {
      pos += direction;
      if (pos >= _order.length || pos < 0) {
        if (!wrap) return null;
        pos = (pos + _order.length) % _order.length;
      }
      final candidate = _items[_order[pos]];
      if (_isPlayable(candidate)) {
        _pos = pos;
        return candidate;
      }
    }
    return null;
  }

  /// Jump to an item by its index in the original list.
  PlayableItem? jumpTo(int index) {
    if (index < 0 || index >= _items.length) return null;
    final pos = _order.indexOf(index);
    if (pos < 0) return null;
    _pos = pos;
    return current;
  }

  void add(PlayableItem item) {
    _items.add(item);
    _order.add(_items.length - 1);
    if (_pos < 0) _pos = 0;
  }

  /// Insert right after the current item ("play next").
  void playNext(PlayableItem item) {
    if (_items.isEmpty) {
      add(item);
      return;
    }
    _items.add(item);
    _order.insert(_pos + 1, _items.length - 1);
  }

  void removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    final removedPos = _order.indexOf(index);
    _items.removeAt(index);
    _order = [
      for (final i in _order)
        if (i != index) i > index ? i - 1 : i
    ];
    if (_items.isEmpty) {
      _pos = -1;
    } else if (removedPos < _pos) {
      _pos -= 1;
    } else if (_pos >= _order.length) {
      _pos = _order.length - 1;
    }
  }

  void updateRemoteUrl(int itemId, String url) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id == itemId) {
        _items[i] = _items[i].copyWith(remoteUrl: url);
      }
    }
  }

  /// Marks the queue as reordered externally: the original list order is kept, play order resets.
  void restore(List<PlayableItem> items, int index) =>
      setItems(items, startIndex: index);
}

/// Rules about the signed media links the backend hands out (`expires` + `signature` query parameters).
class MediaUrlPolicy {
  static DateTime? expiresAt(String url) {
    final seconds = int.tryParse(Uri.tryParse(url)?.queryParameters['expires'] ?? '');
    return seconds == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true);
  }

  static bool isSigned(String url) =>
      Uri.tryParse(url)?.queryParameters.containsKey('signature') ?? false;

  /// True when the link points at the media gate (needs a signature or a bearer token).
  static bool isGateUrl(String url) =>
      (Uri.tryParse(url)?.path ?? '').contains('/media/');

  /// A signed link that is expired, or about to expire, must be refreshed before it is used.
  static bool needsRefresh(String url,
      {DateTime? now, Duration margin = const Duration(minutes: 5)}) {
    final expiry = expiresAt(url);
    if (expiry == null) return false;
    return expiry.isBefore((now ?? DateTime.now().toUtc()).add(margin));
  }
}

/// Where to continue an episode that was played before.
Duration? resumePositionFor({required int savedMs, required int durationMs}) {
  if (savedMs < 5000) return null;
  if (durationMs > 0 && savedMs > durationMs - 10000) return null;
  return Duration(milliseconds: savedMs);
}

/// File extension for a downloaded file, from the Content-Type the server sent.
String extensionForContentType(String? contentType) {
  switch ((contentType ?? '').split(';').first.trim().toLowerCase()) {
    case 'audio/mp4':
    case 'audio/x-m4a':
    case 'audio/m4a':
      return 'm4a';
    case 'audio/aac':
      return 'aac';
    case 'audio/wav':
    case 'audio/x-wav':
      return 'wav';
    case 'audio/ogg':
      return 'ogg';
    case 'audio/flac':
      return 'flac';
    case 'audio/webm':
      return 'webm';
    default:
      return 'mp3';
  }
}

/// A user playlist (saved locally; the items carry what is needed to play them again).
class Playlist {
  const Playlist({
    required this.id,
    required this.name,
    this.items = const [],
    this.updatedAtMs = 0,
  });

  final String id;
  final String name;
  final List<PlayableItem> items;
  final int updatedAtMs;

  Playlist renamed(String newName, int nowMs) =>
      Playlist(id: id, name: newName.trim(), items: items, updatedAtMs: nowMs);

  /// Adds the item at the end; an item already in the playlist is not added twice.
  Playlist withItem(PlayableItem item, int nowMs) => items.contains(item)
      ? this
      : Playlist(id: id, name: name, items: [...items, item], updatedAtMs: nowMs);

  Playlist withoutItem(int itemId, int nowMs) => Playlist(
        id: id,
        name: name,
        items: items.where((i) => i.id != itemId).toList(),
        updatedAtMs: nowMs,
      );

  Playlist reordered(int oldIndex, int newIndex, int nowMs) {
    if (oldIndex < 0 || oldIndex >= items.length) return this;
    final list = List.of(items);
    final moved = list.removeAt(oldIndex);
    list.insert(newIndex.clamp(0, list.length), moved);
    return Playlist(id: id, name: name, items: list, updatedAtMs: nowMs);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'updated_at': updatedAtMs,
        'items': items.map((i) => i.toJson()).toList(),
      };

  factory Playlist.fromJson(Map<dynamic, dynamic> json) => Playlist(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        updatedAtMs: (json['updated_at'] as num?)?.toInt() ?? 0,
        items: [
          for (final raw in (json['items'] as List? ?? const []))
            if (raw is Map) PlayableItem.fromJson(raw)
        ],
      );
}
