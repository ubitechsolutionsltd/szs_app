// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async'; // <-- Add this
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
// DO NOT REMOVE OR MODIFY ABOVE

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerWidget extends StatefulWidget {
  final double? width;
  final double? height;

  /// Episode to load & play
  final Map<String, dynamic>? episode;

  /// Command from outside (play/pause/next/prev/toggle)
  final String? command;

  /// Callback when audio finishes
  final Future<void> Function(Map<String, dynamic>)? onFinished;

  const AudioPlayerWidget({
    super.key,
    this.width,
    this.height,
    this.episode,
    this.command,
    this.onFinished,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _player;

  bool _isPlaying = false;

  /// Ensure onFinished fires once
  bool _didComplete = false;

  /// Track the actual audio currently loaded (exact string from setUrl)
  String? _currentUrl;

  /// True while we are actively loading a URL to avoid spurious events
  bool _isLoading = false;

  /// Subscription flags for the fallback checker
  late final StreamSubscription<_PositionData> _positionSub;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    // Primary: listen to playerStateStream (processingState)
    _player.playerStateStream.listen((state) async {
      if (!mounted) return;

      setState(() => _isPlaying = state.playing);

      final processing = state.processingState;
      final playingUrl = _getPlayingUrlDebug();

      debugPrint(
          '[AudioPlayerWidget] playerStateStream: processing=$processing, playing=${state.playing}, playingUrl=$playingUrl, currentUrl=$_currentUrl, didComplete=$_didComplete, isLoading=$_isLoading');

      // Primary detection: ProcessingState.completed + matching URL + not loading
      if (processing == ProcessingState.completed &&
          !_didComplete &&
          !_isLoading &&
          _currentUrl != null &&
          playingUrl == _currentUrl &&
          widget.episode != null) {
        _didComplete = true;
        debugPrint(
            '[AudioPlayerWidget] DETECTED completed (processingState) for $_currentUrl — firing onFinished');
        await _safeFireFinished();
      }
    });

    // Fallback: position vs duration checker (fires once when pos >= dur - epsilon)
    _positionSub = _positionStream.listen((pd) async {
      if (!mounted) return;
      final pos = pd.position;
      final dur = pd.duration;

      // Only consider when duration is valid (>0) and not loading
      if (dur > Duration.zero && !_didComplete && !_isLoading) {
        final diff = dur - pos;
        // if within 600ms of end, treat as finished
        if (diff.inMilliseconds <= 600) {
          final playingUrl = _getPlayingUrlDebug();
          debugPrint(
              '[AudioPlayerWidget] position-fallback: pos=${pos.inMilliseconds}ms dur=${dur.inMilliseconds}ms diff=${diff.inMilliseconds}ms playingUrl=$playingUrl currentUrl=$_currentUrl');
          if (_currentUrl != null && playingUrl == _currentUrl) {
            _didComplete = true;
            debugPrint(
                '[AudioPlayerWidget] DETECTED completed (position fallback) for $_currentUrl — firing onFinished');
            await _safeFireFinished();
          } else {
            debugPrint(
                '[AudioPlayerWidget] position-fallback: url mismatch or currentUrl null — not firing');
          }
        }
      }
    });

    // Load initial episode if present
    if (widget.episode != null) {
      _loadEpisode(widget.episode!);
    }
  }

  /// Helper to safely call onFinished and guard exceptions
  Future<void> _safeFireFinished() async {
    try {
      if (widget.onFinished != null && widget.episode != null) {
        await widget.onFinished!(widget.episode!);
      } else {
        debugPrint(
            '[AudioPlayerWidget] _safeFireFinished: onFinished or episode is null');
      }
    } catch (err) {
      debugPrint('[AudioPlayerWidget] onFinished threw: $err');
    }
  }

  /// Try to extract the actual playing URL from audioSource for debugging/compare
  String? _getPlayingUrlDebug() {
    try {
      final src = _player.audioSource;
      if (src == null) return null;

      // many AudioSource implementations expose uri or toString with the URL
      // we try both
      final uriField = (src as dynamic).uri;
      if (uriField != null) return uriField.toString();

      final asString = src.toString();
      return asString;
    } catch (e) {
      // fallback to toString
      try {
        return _player.audioSource?.toString();
      } catch (_) {
        return null;
      }
    }
  }

  /// LOAD NEW EPISODE
  Future<void> _loadEpisode(Map<String, dynamic> e) async {
    final url = e['audio']?.toString() ?? '';
    if (url.isEmpty) {
      debugPrint('[AudioPlayerWidget] _loadEpisode: url empty, returning');
      return;
    }

    debugPrint('[AudioPlayerWidget] _loadEpisode: requested url=$url');

    _didComplete = false; // reset guard
    _currentUrl = url; // track url
    _isLoading = true;

    try {
      // Stop previous playback but avoid awaiting long operations that re-emit completed for previous URL
      await _player.stop();
      debugPrint('[AudioPlayerWidget] stopped previous player');

      // setUrl will replace audioSource
      await _player.setUrl(url);
      debugPrint(
          '[AudioPlayerWidget] setUrl completed, player.audioSource=${_player.audioSource}');

      // small delay to allow just_audio to settle (helps on some Android/iOS devices)
      await Future.delayed(const Duration(milliseconds: 60));

      // Play
      await _player.play();
      debugPrint('[AudioPlayerWidget] started playing $url');
    } catch (err) {
      debugPrint('[AudioPlayerWidget] _loadEpisode error: $err');
    } finally {
      // done loading regardless of success
      _isLoading = false;
      debugPrint(
          '[AudioPlayerWidget] _loadEpisode finished: currentUrl=$_currentUrl, isLoading=$_isLoading');
    }
  }

  /// HANDLE EXTERNAL COMMANDS
  void _handleCommand(String? cmd) {
    if (cmd == null) return;

    debugPrint('[AudioPlayerWidget] _handleCommand: $cmd');

    switch (cmd) {
      case "play":
        _player.play();
        break;

      case "pause":
        _player.pause();
        break;

      case "toggle":
        _player.playing ? _player.pause() : _player.play();
        break;

      case "next":
      case "prev":
        // handled externally
        break;
    }
  }

  @override
  void didUpdateWidget(covariant AudioPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // EPISODE CHANGE
    if (widget.episode?['id'] != oldWidget.episode?['id']) {
      debugPrint(
          '[AudioPlayerWidget] didUpdateWidget: episode changed from ${oldWidget.episode?['id']} to ${widget.episode?['id']}');
      if (widget.episode != null) {
        _didComplete = false;
        _loadEpisode(widget.episode!);
      }
    }

    // COMMAND CHANGE
    if (widget.command != oldWidget.command) {
      debugPrint(
          '[AudioPlayerWidget] didUpdateWidget: command changed from ${oldWidget.command} to ${widget.command}');
      _handleCommand(widget.command);
    }
  }

  @override
  void dispose() {
    _positionSub.cancel();
    _player.dispose();
    super.dispose();
  }

  /// Combine position + duration into one Stream
  Stream<_PositionData> get _positionStream =>
      Rx.combineLatest2<Duration, Duration?, _PositionData>(
        _player.positionStream,
        _player.durationStream,
        (pos, dur) => _PositionData(
          pos,
          dur ?? Duration.zero,
        ),
      );

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.episode?['name'] ?? "Loading...";

    return Container(
      width: widget.width ?? double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// TITLE
          Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          /// PROGRESS BAR + TIMES
          StreamBuilder<_PositionData>(
            stream: _positionStream,
            builder: (context, snap) {
              final pos = snap.data?.position ?? Duration.zero;
              final dur = snap.data?.duration ?? Duration.zero;

              return Column(
                children: [
                  Slider(
                    value: pos.inMilliseconds
                        .clamp(0, dur.inMilliseconds)
                        .toDouble(),
                    min: 0,
                    max: dur.inMilliseconds == 0
                        ? 1
                        : dur.inMilliseconds.toDouble(),
                    onChanged: (v) {
                      _player.seek(Duration(milliseconds: v.toInt()));
                    },
                    activeColor: Colors.green,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_format(pos),
                          style: const TextStyle(color: Colors.white70)),
                      Text(_format(dur),
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PositionData {
  final Duration position;
  final Duration duration;
  _PositionData(this.position, this.duration);
}
