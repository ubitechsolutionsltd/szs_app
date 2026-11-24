// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/player/download_manager.dart';
import '/custom_code/player/player_core.dart';
import '/custom_code/player/player_service.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/app_widgets.dart';

/// "Downloaded" screen content: episodes saved for offline listening, with progress, play and delete.
class DownloadsList extends StatelessWidget {
  const DownloadsList({super.key, this.width, this.height});

  final double? width;
  final double? height;

  static String _size(int bytes) {
    if (bytes >= 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(bytes >= 10 * 1024 * 1024 ? 0 : 1)} MB';
  }

  Future<void> _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Futa zote?'),
        content: const Text('Simulizi zote ulizopakua zitafutwa kwenye simu hii.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Ghairi')),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Futa zote')),
        ],
      ),
    );
    if (confirmed == true) await DownloadManager.instance.removeAll();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final manager = DownloadManager.instance;

    if (!manager.supported) {
      return const EmptyState(
        icon: Icons.cloud_off_rounded,
        title: 'Kupakua hakupatikani',
        message: 'Kupakua simulizi hakupatikani kwenye wavuti. Tumia app ya simu.',
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ValueListenableBuilder<Map<int, DownloadState>>(
        valueListenable: manager.states,
        builder: (context, _, __) {
          final done = manager.downloaded;
          final active = manager.activeDownloads;

          if (done.isEmpty && active.isEmpty) {
            return const EmptyState(
              icon: Icons.download_for_offline_outlined,
              title: 'Hujapakua simulizi bado',
              message: 'Gusa "Pakua" kwenye simulizi ili kusikiliza bila mtandao.',
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              if (done.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        '${done.length} zimepakuliwa · ${_size(manager.totalBytes)}',
                        style: theme.bodyMedium.override(
                            fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 14, letterSpacing: 0),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _confirmClear(context),
                      child: Text('Futa zote', style: TextStyle(color: palette.error, fontWeight: FontWeight.w700)),
                    ),
                  ]),
                ),
              for (final item in active) _ActiveRow(item: item),
              for (var i = 0; i < done.length; i++)
                _DownloadedRow(
                  episode: done[i],
                  onPlay: () => PlayerService.instance.playQueue(
                    [for (final d in done) d.item],
                    startIndex: i,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DownloadedRow extends StatelessWidget {
  const _DownloadedRow({required this.episode, required this.onPlay});

  final DownloadedEpisode episode;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final item = episode.item;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: palette.outline, width: 0.8),
        boxShadow: AppTokens.cardShadow(Theme.of(context).brightness == Brightness.dark),
      ),
      child: InkWell(
        onTap: onPlay,
        child: Row(children: [
          PlayerArtworkThumb(url: item.artUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: palette.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0)),
              const SizedBox(height: 3),
              Text(
                [if (item.subtitle.isNotEmpty) item.subtitle, DownloadsList._size(episode.bytes)].join(' · '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.bodySmall
                    .override(fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 13, letterSpacing: 0),
              ),
            ]),
          ),
          IconButton(
            tooltip: 'Cheza',
            icon: Icon(Icons.play_circle_fill_rounded, color: palette.accent, size: 34),
            onPressed: onPlay,
          ),
          IconButton(
            tooltip: 'Futa',
            icon: Icon(Icons.delete_outline_rounded, color: palette.muted),
            onPressed: () => DownloadManager.instance.remove(item.id),
          ),
        ]),
      ),
    );
  }
}

class _ActiveRow extends StatelessWidget {
  const _ActiveRow({required this.item});

  final PlayableItem item;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final manager = DownloadManager.instance;
    final state = manager.stateOf(item.id);
    final failed = state.status == DownloadStatus.failed;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: failed ? palette.error.withValues(alpha: 0.5) : palette.outline, width: 0.8),
        boxShadow: AppTokens.cardShadow(Theme.of(context).brightness == Brightness.dark),
      ),
      child: Row(children: [
        PlayerArtworkThumb(url: item.artUrl),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0)),
            const SizedBox(height: 8),
            if (failed)
              Text(state.locked ? 'Fungua kwanza ili upakue.' : 'Imeshindikana. Gusa kujaribu tena.',
                  style: theme.bodySmall
                      .override(fontFamily: 'SF Pro Display', color: palette.error, fontSize: 13, letterSpacing: 0))
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: state.fraction,
                  minHeight: 5,
                  backgroundColor: palette.outline,
                  color: palette.accent,
                ),
              ),
          ]),
        ),
        IconButton(
          tooltip: failed ? 'Jaribu tena' : 'Ghairi',
          icon: Icon(failed ? Icons.refresh_rounded : Icons.close_rounded, color: palette.muted),
          onPressed: () => failed ? manager.download(item) : manager.cancel(item.id),
        ),
      ]),
    );
  }
}

class PlayerArtworkThumb extends StatelessWidget {
  const PlayerArtworkThumb({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: url.isEmpty
          ? Container(
              width: 54,
              height: 54,
              color: palette.surfaceHigh,
              child: Icon(Icons.headphones_rounded, color: palette.muted),
            )
          : Image.network(
              url,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 54,
                height: 54,
                color: palette.surfaceHigh,
                child: Icon(Icons.headphones_rounded, color: palette.muted),
              ),
            ),
    );
  }
}
