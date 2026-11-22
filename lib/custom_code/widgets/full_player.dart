// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/glass.dart';
import '/custom_code/ui/artwork_color.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/player/player_core.dart';
import '/custom_code/player/player_service.dart';
import '/custom_code/player/player_ui.dart';

/// The full-screen player: artwork, seek bar, transport, speed, sleep timer, download, playlist and queue.
class FullPlayer extends StatelessWidget {
  const FullPlayer({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final service = PlayerService.instance;
    final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);

    return Glass(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      blur: 30,
      strong: true,
      shadow: false,
      child: SizedBox(
      width: width,
      height: height,
      child: ValueListenableBuilder<PlayerSnapshot>(
        valueListenable: service.snapshot,
        builder: (context, snap, _) {
          final item = snap.item;
          if (item == null) {
            return Center(child: Text(PlayerStrings.nothingPlaying, style: theme.bodyLarge));
          }

          final errorText = PlayerStrings.errorText(snap.error);
          final artSize = (MediaQuery.sizeOf(context).width * 0.72).clamp(160.0, 340.0);

          return ArtworkBackdrop(
            imageUrl: item.artUrl,
            height: 560,
            child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(PlayerStrings.nowPlaying.toUpperCase(),
                    style: theme.labelSmall.copyWith(color: pal.muted, letterSpacing: 1.4)),
                const SizedBox(height: 16),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 24, offset: const Offset(0, 12))],
                  ),
                  child: PlayerArtwork(url: item.artUrl, size: artSize, radius: 24),
                ),
                const SizedBox(height: 24),
                Text(item.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.headlineSmall.copyWith(color: pal.text, fontWeight: FontWeight.w700)),
                if (item.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(item.subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.bodyMedium.copyWith(color: pal.muted)),
                ],
                if (errorText != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: pal.error.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      Icon(Icons.info_outline_rounded, color: pal.error, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(errorText, style: theme.bodySmall.copyWith(color: pal.error))),
                    ]),
                  ),
                ],
                const SizedBox(height: 16),
                SeekBar(service: service),
                const SizedBox(height: 8),
                _Transport(snap: snap, service: service),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      avatar: Icon(Icons.speed_rounded, size: 18, color: pal.text),
                      label: Text('${snap.speed}x', style: theme.labelMedium.copyWith(color: pal.text)),
                      backgroundColor: pal.surface,
                      side: BorderSide(color: pal.outline),
                      onPressed: () => PlayerSheets.speed(context, service),
                    ),
                    ActionChip(
                      avatar: Icon(Icons.bedtime_outlined,
                          size: 18, color: snap.sleepActive ? pal.accent : pal.text),
                      label: Text(
                        snap.sleepRemaining != null
                            ? formatDuration(snap.sleepRemaining!)
                            : snap.sleepAfterEpisode
                                ? PlayerStrings.endOfEpisode
                                : PlayerStrings.sleepTimer,
                        style: theme.labelMedium.copyWith(color: snap.sleepActive ? pal.accent : pal.text),
                      ),
                      backgroundColor: pal.surface,
                      side: BorderSide(color: snap.sleepActive ? pal.accent : pal.outline),
                      onPressed: () => PlayerSheets.sleepTimer(context, service),
                    ),
                    DownloadChip(item: item),
                    ActionChip(
                      avatar: Icon(Icons.playlist_add_rounded, size: 18, color: pal.text),
                      label: Text(PlayerStrings.addToPlaylist, style: theme.labelMedium.copyWith(color: pal.text)),
                      backgroundColor: pal.surface,
                      side: BorderSide(color: pal.outline),
                      onPressed: () => PlayerSheets.addToPlaylist(context, item),
                    ),
                    ActionChip(
                      avatar: Icon(Icons.queue_music_rounded, size: 18, color: pal.text),
                      label: Text('${PlayerStrings.queue} (${snap.queue.length})',
                          style: theme.labelMedium.copyWith(color: pal.text)),
                      backgroundColor: pal.surface,
                      side: BorderSide(color: pal.outline),
                      onPressed: () => PlayerSheets.queue(context, service),
                    ),
                  ],
                ),
              ],
            ),
          ),
          );
        },
      ),
      ),
    );
  }
}

class _Transport extends StatelessWidget {
  const _Transport({required this.snap, required this.service});

  final PlayerSnapshot snap;
  final PlayerService service;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);

    IconData repeatIcon() =>
        snap.repeat == QueueRepeat.one ? Icons.repeat_one_rounded : Icons.repeat_rounded;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          tooltip: 'Changanya',
          icon: Icon(Icons.shuffle_rounded, color: snap.shuffle ? pal.accent : pal.muted),
          onPressed: () => service.setShuffle(!snap.shuffle),
        ),
        IconButton(
          iconSize: 34,
          tooltip: 'Iliyopita',
          icon: Icon(Icons.skip_previous_rounded, color: pal.text),
          onPressed: service.previous,
        ),
        IconButton(
          iconSize: 30,
          tooltip: 'Rudi sekunde 15',
          icon: Icon(Icons.replay_10_rounded, color: pal.text),
          onPressed: () => service.seekRelative(const Duration(seconds: -15)),
        ),
        SizedBox(
          width: 68,
          height: 68,
          child: snap.loading && !snap.playing
              ? Center(child: CircularProgressIndicator(color: pal.accent))
              : Material(
                  color: pal.accent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: service.toggle,
                    child: Icon(snap.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        size: 40, color: pal.onAccent),
                  ),
                ),
        ),
        IconButton(
          iconSize: 30,
          tooltip: 'Songa sekunde 30',
          icon: Icon(Icons.forward_30_rounded, color: pal.text),
          onPressed: () => service.seekRelative(const Duration(seconds: 30)),
        ),
        IconButton(
          iconSize: 34,
          tooltip: 'Inayofuata',
          icon: Icon(Icons.skip_next_rounded, color: pal.text),
          onPressed: service.next,
        ),
        IconButton(
          tooltip: 'Rudia',
          icon: Icon(repeatIcon(), color: snap.repeat == QueueRepeat.off ? pal.muted : pal.accent),
          onPressed: service.cycleRepeat,
        ),
      ],
    );
  }
}
