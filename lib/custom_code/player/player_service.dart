// The app-wide audio engine. One instance for the whole app, so playback keeps going when screens change.
// Plays downloaded files first, otherwise streams (refreshing expired links), keeps a queue with auto-next,
// remembers where each episode stopped, and restores the last queue on the next launch.

import 'dart:async';
import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'download_manager.dart';
import 'media_access.dart';
import 'audio_handler.dart';
import 'notification_permission.dart';
import 'player_core.dart';

enum PlayerErrorCode { none, locked, nextLocked, offline, failed, loginRequired }

class PlaybackPosition {
  const PlaybackPosition(this.position, this.buffered, this.duration);
  final Duration position;
  final Duration buffered;
  final Duration duration;
}

class PlayerSnapshot {
  const PlayerSnapshot({
    this.item,
    this.queue = const [],
    this.index = -1,
    this.playing = false,
    this.loading = false,
    this.speed = 1.0,
    this.repeat = QueueRepeat.off,
    this.shuffle = false,
    this.error = PlayerErrorCode.none,
    this.sleepRemaining,
    this.sleepAfterEpisode = false,
  });

  final PlayableItem? item;
  final List<PlayableItem> queue;

  /// Index of [item] in [queue] (original order), or -1.
  final int index;
  final bool playing;

  /// Loading a new episode, or buffering.
  final bool loading;
  final double speed;
  final QueueRepeat repeat;
  final bool shuffle;
  final PlayerErrorCode error;
  final Duration? sleepRemaining;
  final bool sleepAfterEpisode;

  bool get hasItem => item != null;
  bool get sleepActive => sleepRemaining != null || sleepAfterEpisode;
}

class PlayerService {
  PlayerService._();
  static final PlayerService instance = PlayerService._();

  /// Tries to buy a locked episode with no dialog (set once at startup to [EpisodeUnlock.silentUnlock]).
  /// Used when advancing playback lands on a locked episode: if the balance already covers it, it is bought
  /// automatically and playback continues; otherwise nothing changes and the usual locked state is shown.
  static Future<bool> Function(dynamic rawEpisode)? autoUnlock;

  static const _sessionKey = 'szs.player.session';
  static const _resumePrefix = 'szs.resume.';

  final AudioPlayer player = AudioPlayer(handleInterruptions: false);
  bool _resumeAfterInterruption = false;
  final PlayQueue _queue = PlayQueue();
  final ValueNotifier<PlayerSnapshot> snapshot = ValueNotifier(const PlayerSnapshot());
  final StreamController<PlayableItem> _completions = StreamController.broadcast();

  SharedPreferences? _prefs;
  bool _initialised = false;
  int _loadSeq = 0;
  int _completedSeq = -1;
  int? _loadedItemId;
  bool _loading = false;
  PlayerErrorCode _error = PlayerErrorCode.none;
  double _speed = 1.0;
  Timer? _sleepTimer;
  Duration? _sleepRemaining;
  bool _sleepAfterEpisode = false;

  /// Fires when an episode finishes on its own (the queue has already moved on by then).
  Stream<PlayableItem> get completions => _completions.stream;

  Stream<PlaybackPosition> get positionStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PlaybackPosition>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, buffered, duration) => PlaybackPosition(
          position,
          buffered,
          _plausible(duration) ?? Duration(seconds: _queue.current?.durationSeconds ?? 0),
        ),
      );

  Future<void> init() async {
    if (_initialised) return;
    _initialised = true;

    _prefs = await SharedPreferences.getInstance();
    await DownloadManager.instance.init();
    _queue.isPlayable =
        (item) => item.hasRemoteUrl || DownloadManager.instance.isDownloaded(item.id);

    await _setupAudioSession();
    player.playerStateStream.listen(_onPlayerState);
    player.playbackEventStream.listen((_) {}, onError: (Object e, StackTrace s) {
      debugPrint('Playback error: $e');
      _fail(_looksOffline(e) ? PlayerErrorCode.offline : PlayerErrorCode.failed);
    });
    Timer.periodic(const Duration(seconds: 5), (_) => _savePosition());

    await _restoreSession();
    _publish();
  }

  /// Configures the system audio session for spoken audio and reacts to interruptions (another app's sound, a
  /// call, an alarm): pause when interrupted and resume by itself when the interruption is over. Short sounds
  /// (notifications) lower the volume instead of stopping the story. Headphones unplugged pauses.
  Future<void> _setupAudioSession() async {
    try {
      final session = await AudioSession.instance;
      // Spoken audio that does NOT mix with other apps: only then does iOS show the app on the lock screen and
      // in Control Center, and other apps' audio interrupts it (we resume afterwards, see below).
      await session.configure(const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.none,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.media,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ));

      session.interruptionEventStream.listen((event) {
        if (event.begin) {
          switch (event.type) {
            case AudioInterruptionType.duck:
              unawaited(player.setVolume(0.35));
            case AudioInterruptionType.pause:
            case AudioInterruptionType.unknown:
              if (player.playing) {
                _resumeAfterInterruption = true;
                unawaited(pause());
              }
          }
        } else {
          switch (event.type) {
            case AudioInterruptionType.duck:
              unawaited(player.setVolume(1.0));
            case AudioInterruptionType.pause:
            case AudioInterruptionType.unknown:
              unawaited(player.setVolume(1.0));
              if (_resumeAfterInterruption) {
                _resumeAfterInterruption = false;
                unawaited(play());
              }
          }
        }
      });

      session.becomingNoisyEventStream.listen((_) {
        _resumeAfterInterruption = false;
        if (player.playing) unawaited(pause());
      });
    } catch (e) {
      debugPrint('Audio session setup failed: $e');
    }
  }

  // ---- starting playback ----------------------------------------------------------------------------------

  Future<void> playQueue(List<PlayableItem> items, {int startIndex = 0}) async {
    await init();
    unawaited(NotificationPermission.ensure());
    if (!BackgroundAudio.isActive) unawaited(BackgroundAudio.start(this));
    _queue.setItems(items, startIndex: startIndex);
    await _loadCurrent();
  }

  /// Plays a list of episode maps (as the API returns them) from [startIndex].
  Future<void> playEpisodeMaps(List<dynamic> episodes,
      {int startIndex = 0, String subtitle = ''}) {
    final items = [
      for (final e in episodes)
        if (e is Map) PlayableItem.fromEpisodeMap(e, subtitle: subtitle)
    ];
    return playQueue(items, startIndex: startIndex);
  }

  /// Plays one episode map; with [within] it becomes the current item of that list so auto-next works.
  Future<void> playEpisodeMap(Map<dynamic, dynamic> episode,
      {List<dynamic>? within, String subtitle = ''}) {
    final item = PlayableItem.fromEpisodeMap(episode, subtitle: subtitle);
    final list = within == null
        ? <PlayableItem>[item]
        : [
            for (final e in within)
              if (e is Map) PlayableItem.fromEpisodeMap(e, subtitle: subtitle)
          ];
    var start = list.indexWhere((i) => i.id == item.id);
    if (start < 0) {
      list.add(item);
      start = list.length - 1;
    }
    return playQueue(list, startIndex: start);
  }

  int? get currentItemId => _queue.current?.id;

  // ---- transport ------------------------------------------------------------------------------------------

  Future<void> play() async {
    _resumeAfterInterruption = false; // the user (or the resume itself) is in control again
    await init();
    final current = _queue.current;
    if (current == null) return;
    if (_loadedItemId != current.id) {
      await _loadCurrent();
      return;
    }
    if (player.processingState == ProcessingState.completed) {
      await player.seek(Duration.zero);
    }
    unawaited(player.play());
  }

  Future<void> pause() async {
    await player.pause();
    await _savePosition();
  }

  Future<void> toggle() => player.playing ? pause() : play();

  Future<void> next() async {
    if (_queue.next() == null) return;
    await _loadCurrent();
  }

  Future<void> previous() async {
    final before = _queue.current;
    final target = _queue.previous(position: player.position);
    if (target == null) return;
    if (target == before) {
      await player.seek(Duration.zero);
      return;
    }
    await _loadCurrent();
  }

  Future<void> seek(Duration position) => player.seek(position);

  /// Some streams report a nonsense length (hundreds of hours) because the server does not send the real size.
  /// No story episode is that long, so such a value is treated as "unknown".
  static Duration? _plausible(Duration? d) => (d == null || d > const Duration(hours: 10)) ? null : d;

  Future<void> seekRelative(Duration delta) async {
    final duration = _plausible(player.duration) ?? Duration(seconds: _queue.current?.durationSeconds ?? 0);
    var target = player.position + delta;
    if (target < Duration.zero) target = Duration.zero;
    if (duration > Duration.zero && target > duration) target = duration;
    await player.seek(target);
  }

  Future<void> setSpeed(double speed) async {
    _speed = speed.clamp(0.5, 3.0).toDouble();
    await player.setSpeed(_speed);
    await _saveSession();
    _publish();
  }

  void setRepeat(QueueRepeat mode) {
    _queue.repeat = mode;
    unawaited(_saveSession());
    _publish();
  }

  void cycleRepeat() => setRepeat(
        QueueRepeat.values[(_queue.repeat.index + 1) % QueueRepeat.values.length],
      );

  void setShuffle(bool value) {
    _queue.shuffle = value;
    unawaited(_saveSession());
    _publish();
  }

  // ---- queue editing --------------------------------------------------------------------------------------

  Future<void> jumpTo(int index) async {
    if (_queue.jumpTo(index) == null) return;
    await _loadCurrent();
  }

  void addToQueue(PlayableItem item) {
    _queue.add(item);
    unawaited(_saveSession());
    _publish();
  }

  void playNext(PlayableItem item) {
    _queue.playNext(item);
    unawaited(_saveSession());
    _publish();
  }

  Future<void> removeFromQueue(int index) async {
    final wasCurrent = index == _queue.currentIndex;
    _queue.removeAt(index);
    if (_queue.isEmpty) {
      await stopAndClear();
      return;
    }
    if (wasCurrent) {
      await _loadCurrent(autoplay: player.playing);
    } else {
      unawaited(_saveSession());
      _publish();
    }
  }

  Future<void> stopAndClear() async {
    _loadSeq++;
    await player.stop();
    _queue.setItems(const []);
    _loadedItemId = null;
    _loading = false;
    _error = PlayerErrorCode.none;
    await _prefs?.remove(_sessionKey);
    _publish();
  }

  // ---- sleep timer ----------------------------------------------------------------------------------------

  void setSleepTimer(Duration duration) {
    cancelSleep();
    _sleepRemaining = duration;
    _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final left = (_sleepRemaining ?? Duration.zero) - const Duration(seconds: 1);
      if (left <= Duration.zero) {
        cancelSleep();
        unawaited(pause());
      } else {
        _sleepRemaining = left;
        _publish();
      }
    });
    _publish();
  }

  /// Stop when the current episode ends instead of moving on.
  void sleepAfterCurrentEpisode() {
    cancelSleep();
    _sleepAfterEpisode = true;
    _publish();
  }

  void cancelSleep() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
    _sleepRemaining = null;
    _sleepAfterEpisode = false;
    _publish();
  }

  // ---- loading and completion -----------------------------------------------------------------------------

  /// Loads the queue's current item. With [skipLocked] (used when moving on by itself) episodes the user has
  /// not unlocked are passed over instead of stopping the queue.
  Future<void> _loadCurrent({bool autoplay = true, bool skipLocked = false, int? fallbackIndex}) async {
    var item = _queue.current;
    if (item == null) return;

    final seq = ++_loadSeq;
    _loading = true;
    _error = PlayerErrorCode.none;
    _publish();

    try {
      final startIndex = _queue.currentIndex;
      AudioSource? source;
      for (var attempt = 0; attempt <= _queue.items.length; attempt++) {
        source = await _resolveSource(item!);
        if (seq != _loadSeq) return;
        if (source != null) break;

        if (skipLocked && _error == PlayerErrorCode.locked) {
          final next = _queue.next();
          if (next == null) break;
          item = next;
          _error = PlayerErrorCode.none;
          _publish();
          continue;
        }
        break;
      }

      if (source == null) {
        if (skipLocked && _error == PlayerErrorCode.locked) {
          // Everything after this episode is locked: stay on the episode that just finished.
          _queue.jumpTo(fallbackIndex ?? startIndex);
          _error = PlayerErrorCode.nextLocked;
          _loading = false;
          _publish();
          return;
        }
        _fail(_error == PlayerErrorCode.none ? PlayerErrorCode.failed : _error);
        return;
      }

      final resume = await _savedPosition(item!);
      await player.setAudioSource(source, initialPosition: resume);
      if (seq != _loadSeq) return;

      _loadedItemId = item.id;
      await player.setSpeed(_speed);
      if (autoplay) unawaited(player.play());
      unawaited(_saveSession());
    } catch (e) {
      debugPrint('Could not load the episode: $e');
      if (seq == _loadSeq) {
        _fail(_looksOffline(e) ? PlayerErrorCode.offline : PlayerErrorCode.failed);
      }
    } finally {
      if (seq == _loadSeq) {
        _loading = false;
        _publish();
      }
    }
  }

  Future<AudioSource?> _resolveSource(PlayableItem item) async {
    final local = await DownloadManager.instance.localFile(item.id);
    if (local != null) return AudioSource.file(local.path);

    var url = item.remoteUrl;
    if (url.isEmpty) {
      _error = PlayerErrorCode.locked;
      return null;
    }

    if (MediaUrlPolicy.isGateUrl(url)) {
      // Ask the server every time: it answers "locked" reliably and hands back a fresh signed link.
      var access = await MediaAccess.instance.refresh(url);
      if (access.locked) {
        // The balance might already cover it: buy it with no dialog and ask the server again before giving up.
        final buy = autoUnlock;
        if (buy != null && item.raw != null && await buy(item.raw)) {
          access = await MediaAccess.instance.refresh(url);
        }
      }
      if (access.locked) {
        _error = PlayerErrorCode.locked;
        return null;
      }
      if (access.loginRequired) {
        _error = PlayerErrorCode.loginRequired;
        return null;
      }
      if (access.url != null) {
        url = access.url!;
        _queue.updateRemoteUrl(item.id, url);
      }
    }

    return AudioSource.uri(Uri.parse(url), headers: MediaAccess.instance.headersFor(url));
  }

  void _onPlayerState(PlayerState state) {
    if (state.processingState == ProcessingState.completed &&
        !_loading &&
        _loadedItemId != null &&
        _completedSeq != _loadSeq) {
      _completedSeq = _loadSeq;
      _handleCompleted();
    }
    _publish();
  }

  void _handleCompleted() {
    final finished = _queue.current;
    if (finished != null) {
      unawaited(_prefs?.remove('$_resumePrefix${finished.id}'));
      _completions.add(finished);
    }

    if (_sleepAfterEpisode) {
      _sleepAfterEpisode = false;
      _publish();
      return;
    }

    final finishedIndex = _queue.currentIndex;
    if (_queue.advanceOnComplete() != null) {
      unawaited(_loadCurrent(skipLocked: true, fallbackIndex: finishedIndex));
    }
  }

  void _fail(PlayerErrorCode code) {
    _error = code;
    _loading = false;
    unawaited(player.pause());
    _publish();
  }

  bool _looksOffline(Object error) {
    final text = error.toString().toLowerCase();
    return text.contains('socket') ||
        text.contains('network') ||
        text.contains('connection') ||
        text.contains('host lookup') ||
        text.contains('timed out');
  }

  // ---- persistence ----------------------------------------------------------------------------------------

  Future<void> _savePosition() async {
    final item = _queue.current;
    final prefs = _prefs;
    if (item == null || prefs == null || _loadedItemId != item.id) return;
    final position = player.position.inMilliseconds;
    if (position > 0) await prefs.setInt('$_resumePrefix${item.id}', position);
  }

  Future<Duration?> _savedPosition(PlayableItem item) async {
    final saved = _prefs?.getInt('$_resumePrefix${item.id}');
    if (saved == null) return null;
    return resumePositionFor(savedMs: saved, durationMs: item.durationSeconds * 1000);
  }

  Future<void> _saveSession() async {
    final prefs = _prefs;
    if (prefs == null || _queue.isEmpty) return;
    await prefs.setString(
      _sessionKey,
      jsonEncode({
        'items': _queue.items.map((i) => i.toJson()).toList(),
        'index': _queue.currentIndex,
        'repeat': _queue.repeat.index,
        'shuffle': _queue.shuffle,
        'speed': _speed,
      }),
    );
  }

  /// Brings back the last queue, paused, so the mini player shows what was playing.
  Future<void> _restoreSession() async {
    try {
      final raw = _prefs?.getString(_sessionKey);
      if (raw == null) return;
      final data = jsonDecode(raw);
      if (data is! Map) return;

      final items = [
        for (final entry in (data['items'] as List? ?? const []))
          if (entry is Map) PlayableItem.fromJson(entry)
      ];
      if (items.isEmpty) return;

      _speed = ((data['speed'] as num?) ?? 1.0).toDouble();
      _queue.setItems(items, startIndex: (data['index'] as num?)?.toInt() ?? 0);
      _queue.repeat = QueueRepeat.values[((data['repeat'] as num?)?.toInt() ?? 0)
          .clamp(0, QueueRepeat.values.length - 1)];
      _queue.shuffle = data['shuffle'] == true;
    } catch (e) {
      debugPrint('Could not restore the last queue: $e');
    }
  }

  void _publish() {
    snapshot.value = PlayerSnapshot(
      item: _queue.current,
      queue: _queue.items,
      index: _queue.currentIndex,
      // just_audio keeps `playing` true after the last episode completes; to the user it has stopped.
      playing: player.playing && player.processingState != ProcessingState.completed,
      loading: _loading ||
          player.processingState == ProcessingState.loading ||
          player.processingState == ProcessingState.buffering,
      speed: _speed,
      repeat: _queue.repeat,
      shuffle: _queue.shuffle,
      error: _error,
      sleepRemaining: _sleepRemaining,
      sleepAfterEpisode: _sleepAfterEpisode,
    );
  }
}
