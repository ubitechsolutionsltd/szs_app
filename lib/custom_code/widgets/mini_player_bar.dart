// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_tokens.dart';
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
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => const FullPlayer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = PlayerService.instance;
    final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);

    return ValueListenableBuilder<PlayerSnapshot>(
      valueListenable: service.snapshot,
      builder: (context, snap, _) {
        final item = snap.item;
        if (item == null) return const SizedBox.shrink();

        final hasError = snap.error != PlayerErrorCode.none;
        return Semantics(
          container: true,
          label: 'Kinachocheza sasa: ${item.title}',
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF0B2C57), AppTokens.brandDeep, AppTokens.brandPrimary],
              ),
              boxShadow: [BoxShadow(color: AppTokens.brandPrimary.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Material(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(22),
              child: InkWell(
                onTap: () => onTap != null ? onTap!() : _openFullPlayer(context),
                child: SizedBox(
                  width: width,
                  height: height ?? 68,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 4, 0),
                          child: Row(
                            children: [
                              PlayerArtwork(url: item.artUrl, size: 46, radius: 12),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: AppTokens.fontFamily,
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 2),
                                    Text(
                                      PlayerStrings.errorText(snap.error) ??
                                          (item.subtitle.isEmpty ? PlayerStrings.nowPlaying : item.subtitle),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: AppTokens.fontFamily,
                                          color: hasError ? const Color(0xFFFFC2C2) : Colors.white70,
                                          fontSize: 12.5),
                                    ),
                                  ],
                                ),
                              ),
                              if (snap.loading && !snap.playing)
                                const SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Padding(padding: EdgeInsets.all(13), child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white)))
                              else
                                IconButton(
                                  tooltip: snap.playing ? 'Simamisha' : 'Cheza',
                                  constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                                  icon: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                    child: Icon(snap.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                        color: AppTokens.brandDeep, size: 26),
                                  ),
                                  onPressed: service.toggle,
                                ),
                              IconButton(
                                tooltip: 'Inayofuata',
                                constraints: const BoxConstraints(minWidth: 44, minHeight: 48),
                                icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 28),
                                onPressed: service.next,
                              ),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder<PlaybackPosition>(
                        stream: service.positionStream,
                        builder: (context, snapshot) {
                          final total = snapshot.data?.duration.inMilliseconds ?? 0;
                          final value = total <= 0
                              ? 0.0
                              : ((snapshot.data?.position.inMilliseconds ?? 0) / total).clamp(0.0, 1.0);
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 3,
                            backgroundColor: Colors.white24,
                            color: Colors.white,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
