// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/player/player_service.dart';
import '/custom_code/player/player_ui.dart';
import 'full_player.dart';

/// Slim "now playing" bar for the bottom of a page. Hidden when nothing is loaded.
/// Tapping it runs [onTap] if given, otherwise opens the full player.
class MiniPlayerBar extends StatelessWidget {
  const MiniPlayerBar({
    super.key,
    this.width,
    this.height,
    this.onTap,
  });

  final double? width;
  final double? height;
  final Future Function()? onTap;

  void _openFullPlayer(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => const FullPlayer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = PlayerService.instance;
    final theme = FlutterFlowTheme.of(context);

    return ValueListenableBuilder<PlayerSnapshot>(
      valueListenable: service.snapshot,
      builder: (context, snap, _) {
        final item = snap.item;
        if (item == null) return const SizedBox.shrink();

        return Material(
          color: theme.secondaryBackground,
          elevation: 6,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => onTap != null ? onTap!() : _openFullPlayer(context),
            child: SizedBox(
              width: width,
              height: height ?? 68,
              child: Column(
                children: [
                  StreamBuilder<PlaybackPosition>(
                    stream: service.positionStream,
                    builder: (context, snapshot) {
                      final total = snapshot.data?.duration.inMilliseconds ?? 0;
                      final value = total <= 0
                          ? 0.0
                          : ((snapshot.data?.position.inMilliseconds ?? 0) / total).clamp(0.0, 1.0);
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: 2,
                        backgroundColor: theme.alternate,
                        color: theme.primary,
                      );
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          PlayerArtwork(url: item.artUrl, size: 44, radius: 10),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.bodyLarge.copyWith(
                                        color: theme.primaryText, fontWeight: FontWeight.w600)),
                                Text(
                                  PlayerStrings.errorText(snap.error) ??
                                      (item.subtitle.isEmpty ? PlayerStrings.nowPlaying : item.subtitle),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.bodySmall.copyWith(
                                      color: snap.error == PlayerErrorCode.none ? theme.secondaryText : theme.error),
                                ),
                              ],
                            ),
                          ),
                          if (snap.loading && !snap.playing)
                            const SizedBox(
                                width: 40, height: 40, child: Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator(strokeWidth: 2.5)))
                          else
                            IconButton(
                              icon: Icon(snap.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  color: theme.primaryText, size: 30),
                              onPressed: service.toggle,
                            ),
                          IconButton(
                            icon: Icon(Icons.skip_next_rounded, color: theme.primaryText, size: 28),
                            onPressed: service.next,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
