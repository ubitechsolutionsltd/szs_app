// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import '/custom_code/player/player_service.dart';
import '/custom_code/player/player_ui.dart';

/// Compatibility widget for pages built around `episode` / `command` / `onFinished`.
///
/// It no longer owns an audio player: it drives the app-wide [PlayerService], so playback keeps going in the
/// background when the page is closed, the queue advances on its own, and returning to the page does not restart
/// the episode. Pass [episodes] (the full list) so next / previous / auto-next know the queue.
class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({
    super.key,
    this.width,
    this.height,
    this.episode,
    this.episodes,
    this.command,
    this.onFinished,
  });

  final double? width;
  final double? height;

  /// Episode to play.
  final Map<String, dynamic>? episode;

  /// All episodes of the story, for the queue (optional).
  final List<dynamic>? episodes;

  /// Command from outside: play, pause, toggle, next, prev.
  final String? command;

  /// Called when an episode finishes (kept so existing pages can update what they show).
  final Future<void> Function(Map<String, dynamic>)? onFinished;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final PlayerService _service = PlayerService.instance;
  StreamSubscription<dynamic>? _completionSub;

  int? _idOf(Map<dynamic, dynamic>? episode) {
    final raw = episode?['id'];
    return raw is num ? raw.toInt() : int.tryParse(raw?.toString() ?? '');
  }

  @override
  void initState() {
    super.initState();
    _completionSub = _service.completions.listen((item) async {
      final episode = widget.episode;
      if (episode != null && _idOf(episode) == item.id && widget.onFinished != null) {
        try {
          await widget.onFinished!(episode);
        } catch (e) {
          debugPrint('onFinished threw: $e');
        }
      }
    });
    _startIfNeeded();
  }

  Future<void> _startIfNeeded() async {
    await _service.init();
    final episode = widget.episode;
    if (episode == null) return;
    // Already the current item (for example coming back to the page): keep playing, do not restart.
    if (_service.currentItemId == _idOf(episode)) return;
    await _service.playEpisodeMap(episode, within: widget.episodes);
  }

  void _handleCommand(String? command) {
    switch (command) {
      case 'play':
        _service.play();
      case 'pause':
        _service.pause();
      case 'toggle':
        _service.toggle();
      case 'next':
        _service.next();
      case 'prev':
        _service.previous();
    }
  }

  @override
  void didUpdateWidget(covariant AudioPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_idOf(widget.episode) != _idOf(oldWidget.episode)) {
      _startIfNeeded();
    }
    if (widget.command != oldWidget.command) {
      _handleCommand(widget.command);
    }
  }

  @override
  void dispose() {
    // The player is intentionally NOT stopped: it belongs to the app, not to this page.
    _completionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return ValueListenableBuilder<PlayerSnapshot>(
      valueListenable: _service.snapshot,
      builder: (context, snap, _) {
        final title = snap.item?.title ?? widget.episode?['name']?.toString() ?? '...';
        final errorText = PlayerStrings.errorText(snap.error);

        return Container(
          width: widget.width ?? double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.titleMedium.copyWith(color: theme.primaryText, fontWeight: FontWeight.w700)),
              if (errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(errorText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: theme.bodySmall.copyWith(color: theme.error)),
                ),
              SeekBar(service: _service),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous_rounded, color: theme.primaryText),
                    onPressed: _service.previous,
                  ),
                  snap.loading && !snap.playing
                      ? const SizedBox(width: 48, height: 48, child: Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2.5)))
                      : IconButton(
                          iconSize: 40,
                          icon: Icon(snap.playing ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                              color: theme.primary),
                          onPressed: _service.toggle,
                        ),
                  IconButton(
                    icon: Icon(Icons.skip_next_rounded, color: theme.primaryText),
                    onPressed: _service.next,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
