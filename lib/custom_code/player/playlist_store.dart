// Local playlists, saved on the device. (Server sync can be added later without changing the screens.)

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'player_core.dart';

class PlaylistStore {
  PlaylistStore._();
  static final PlaylistStore instance = PlaylistStore._();

  static const _key = 'szs.playlists';

  final ValueNotifier<List<Playlist>> playlists = ValueNotifier(const []);
  bool _ready = false;

  Future<void> init() async {
    if (_ready) return;
    _ready = true;
    try {
      final raw = (await SharedPreferences.getInstance()).getString(_key);
      if (raw != null) {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          playlists.value = [
            for (final entry in decoded)
              if (entry is Map) Playlist.fromJson(entry)
          ];
        }
      }
    } catch (e) {
      debugPrint('PlaylistStore.init: $e');
    }
  }

  Playlist? byId(String id) {
    for (final p in playlists.value) {
      if (p.id == id) return p;
    }
    return null;
  }

  int get _now => DateTime.now().millisecondsSinceEpoch;

  Future<Playlist> create(String name) async {
    final playlist = Playlist(
      id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
      name: name.trim().isEmpty ? 'Orodha mpya' : name.trim(),
      updatedAtMs: _now,
    );
    await _commit([...playlists.value, playlist]);
    return playlist;
  }

  Future<void> rename(String id, String name) =>
      _update(id, (p) => p.renamed(name, _now));

  Future<void> addItem(String id, PlayableItem item) =>
      _update(id, (p) => p.withItem(item, _now));

  Future<void> removeItem(String id, int itemId) =>
      _update(id, (p) => p.withoutItem(itemId, _now));

  Future<void> reorder(String id, int oldIndex, int newIndex) =>
      _update(id, (p) => p.reordered(oldIndex, newIndex, _now));

  Future<void> delete(String id) =>
      _commit(playlists.value.where((p) => p.id != id).toList());

  Future<void> _update(String id, Playlist Function(Playlist) change) =>
      _commit([for (final p in playlists.value) p.id == id ? change(p) : p]);

  Future<void> _commit(List<Playlist> next) async {
    playlists.value = next;
    try {
      await (await SharedPreferences.getInstance())
          .setString(_key, jsonEncode(next.map((p) => p.toJson()).toList()));
    } catch (e) {
      debugPrint('PlaylistStore._commit: $e');
    }
  }
}
