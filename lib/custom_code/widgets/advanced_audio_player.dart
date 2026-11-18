// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AdvancedAudioPlayer extends StatefulWidget {
  const AdvancedAudioPlayer({
    super.key,
    this.width,
    this.height,
    required this.urls,
    required this.titles,
  });

  final double? width;
  final double? height;
  final List<String> urls;
  final List<String> titles;

  @override
  State<AdvancedAudioPlayer> createState() => _AdvancedAudioPlayerState();
}

class _AdvancedAudioPlayerState extends State<AdvancedAudioPlayer> {
  late final AudioPlayer _player;

  Stream<_PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, _PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (pos, buff, dur) => _PositionData(pos, buff, dur ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setAudioSource(
      ConcatenatingAudioSource(
        children:
            widget.urls.map((u) => AudioSource.uri(Uri.parse(u))).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Track Title
            StreamBuilder<SequenceState?>(
              stream: _player.sequenceStateStream,
              builder: (context, snap) {
                final idx = snap.data?.currentIndex ?? 0;
                final title = (idx < widget.titles.length)
                    ? widget.titles[idx]
                    : 'Track ${idx + 1}';
                return Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(height: 12),

            // Progress bar
            StreamBuilder<_PositionData>(
              stream: _positionDataStream,
              builder: (context, snap) {
                final pos = snap.data?.position ?? Duration.zero;
                final dur = snap.data?.duration ?? Duration.zero;
                final maxMs = dur.inMilliseconds > 0
                    ? dur.inMilliseconds.toDouble()
                    : 1.0;
                final valMs =
                    pos.inMilliseconds.clamp(0, dur.inMilliseconds).toDouble();
                return Column(
                  children: [
                    Slider(
                      activeColor: Colors.blueAccent,
                      inactiveColor: Colors.grey,
                      min: 0,
                      max: maxMs,
                      value: valMs,
                      onChanged: (v) =>
                          _player.seek(Duration(milliseconds: v.toInt())),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _fmt(pos),
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          _fmt(dur),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, color: Colors.white),
                  iconSize: 36,
                  onPressed: _player.hasPrevious
                      ? () => _player.seekToPrevious()
                      : null,
                ),
                StreamBuilder<PlayerState>(
                  stream: _player.playerStateStream,
                  builder: (context, snap) {
                    final playing = snap.data?.playing ?? false;
                    final buffering = snap.data?.processingState ==
                            ProcessingState.loading ||
                        snap.data?.processingState == ProcessingState.buffering;
                    if (buffering) {
                      return const SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    return IconButton(
                      icon: Icon(
                        playing ? Icons.pause_circle : Icons.play_circle,
                        color: Colors.white,
                      ),
                      iconSize: 48,
                      onPressed: () =>
                          playing ? _player.pause() : _player.play(),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                  iconSize: 36,
                  onPressed:
                      _player.hasNext ? () => _player.seekToNext() : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PositionData {
  final Duration position;
  final Duration buffered;
  final Duration duration;
  _PositionData(this.position, this.buffered, this.duration);
}
