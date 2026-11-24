// Bridges the player to the operating system: notification, lock screen, headset buttons, Bluetooth, Android Auto.
// If the native setup is missing (see the README note in the commit) AudioService.init throws and the app simply
// keeps playing in the foreground.

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'player_service.dart';

class SzsAudioHandler extends BaseAudioHandler with SeekHandler {
  SzsAudioHandler(this._service) {
    _service.player.playbackEventStream.listen((_) => _broadcast());
    _service.player.playerStateStream.listen((_) => _broadcast());
    _service.snapshot.addListener(_syncMediaItem);
    _syncMediaItem();
    _broadcast();
  }

  final PlayerService _service;
  int? _lastItemId;

  void _syncMediaItem() {
    final item = _service.snapshot.value.item;
    if (item?.id == _lastItemId) return;
    _lastItemId = item?.id;

    if (item == null) {
      mediaItem.add(null);
      return;
    }
    mediaItem.add(MediaItem(
      id: item.id.toString(),
      title: item.title,
      album: item.subtitle.isEmpty ? null : item.subtitle,
      artUri: item.artUrl.isEmpty ? null : Uri.tryParse(item.artUrl),
      duration: item.durationSeconds > 0 ? Duration(seconds: item.durationSeconds) : null,
    ));
  }

  void _broadcast() {
    final player = _service.player;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        MediaControl.rewind,
        if (player.playing && player.processingState != ProcessingState.completed) MediaControl.pause else MediaControl.play,
        MediaControl.fastForward,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 2, 4],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[player.processingState]!,
      playing: player.playing && player.processingState != ProcessingState.completed,
      updatePosition: player.position,
      bufferedPosition: player.bufferedPosition,
      speed: player.speed,
    ));
  }

  @override
  Future<void> play() => _service.play();

  @override
  Future<void> pause() => _service.pause();

  @override
  Future<void> stop() async {
    await _service.pause();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _service.seek(position);

  @override
  Future<void> skipToNext() => _service.next();

  @override
  Future<void> skipToPrevious() => _service.previous();

  @override
  Future<void> fastForward() => _service.seekRelative(const Duration(seconds: 15));

  @override
  Future<void> rewind() => _service.seekRelative(const Duration(seconds: -15));

  @override
  Future<void> setSpeed(double speed) => _service.setSpeed(speed);
}

class BackgroundAudio {
  static SzsAudioHandler? _handler;

  static bool get isActive => _handler != null;

  /// Why the notification / lock-screen integration could not start (null when it is running or not tried yet).
  static String? lastError;

  /// Starts the notification / lock-screen integration. Returns false if the native setup is missing.
  static Future<bool> start(PlayerService service) async {
    if (_handler != null) return true;
    try {
      _handler = await AudioService.init(
        builder: () => SzsAudioHandler(service),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.simulizi.ruhundwa.playback',
          androidNotificationChannelName: 'Simulizi za Sauti',
          androidNotificationOngoing: true,
          androidNotificationIcon: 'drawable/ic_stat_szs',
          androidStopForegroundOnPause: true,
          fastForwardInterval: Duration(seconds: 15),
          rewindInterval: Duration(seconds: 15),
        ),
      );
      lastError = null;
      return true;
    } catch (e) {
      lastError = '$e';
      debugPrint('Background playback is not available: $e');
      return false;
    }
  }
}
