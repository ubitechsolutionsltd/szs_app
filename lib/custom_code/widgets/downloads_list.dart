// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/downloads.dart' show resumeAllDownloads;
import '/custom_code/player/download_manager.dart';
import '/custom_code/player/player_core.dart';
import '/custom_code/player/player_service.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/app_widgets.dart';

/// [done], split into one list per story (in the order [DownloadManager.downloaded] already sorts them:
/// most recently downloaded story first, episodes in their own natural order inside each).
List<List<DownloadedEpisode>> _groupByStory(List<DownloadedEpisode> done) {
  final groups = <List<DownloadedEpisode>>[];
  for (final episode in done) {
    if (groups.isNotEmpty && groups.last.first.item.contentId == episode.item.contentId) {
      groups.last.add(episode);
    } else {
      groups.add([episode]);
    }
  }
  return groups;
}

/// The story title a group of downloaded episodes was tagged with, or a generic fallback for episodes
/// downloaded before this was tracked.
String _groupTitle(List<DownloadedEpisode> group) {
  final subtitle = group.first.item.subtitle;
  return subtitle.isNotEmpty ? subtitle : trs('episodes');
}

/// "Downloaded" screen content: episodes saved for offline listening, with progress, play and delete.
class DownloadsList extends StatelessWidget {
  DownloadsList({super.key, this.width, this.height});

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
        title: Text(trs('delete_all_q')),
        content: Text(trs('delete_all_msg')),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(trs('cancel'))),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(trs('delete_all'))),
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
      return EmptyState(
        icon: Icons.cloud_off_rounded,
        title: trs('dl_unavail'),
        message: trs('dl_web2'),
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
          final hasFailed = active.any((item) => manager.stateOf(item.id).status == DownloadStatus.failed);
          final groups = _groupByStory(done);

          if (done.isEmpty && active.isEmpty) {
            return EmptyState(
              icon: Icons.download_for_offline_outlined,
              title: trs('no_downloads'),
              message: trs('dl_hint'),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              if (done.isNotEmpty || hasFailed)
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        done.isEmpty
                            ? ''
                            : '${done.length} zimepakuliwa · ${_size(manager.totalBytes)}',
                        style: theme.bodyMedium.override(
                            fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 14, letterSpacing: 0),
                      ),
                    ),
                    if (hasFailed)
                      TextButton(
                        onPressed: () => resumeAllDownloads(),
                        child: Text(trs('resume_all_downloads'),
                            style: TextStyle(color: palette.accent, fontWeight: FontWeight.w700)),
                      ),
                    if (done.isNotEmpty)
                      TextButton(
                        onPressed: () => _confirmClear(context),
                        child: Text(trs('delete_all'), style: TextStyle(color: palette.error, fontWeight: FontWeight.w700)),
                      ),
                  ]),
                ),
              for (final item in active) _ActiveRow(item: item),
              for (final group in groups) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
                  child: Text(
                    _groupTitle(group),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyMedium.override(
                        fontFamily: 'SF Pro Display', color: palette.text, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 0),
                  ),
                ),
                for (var i = 0; i < group.length; i++)
                  _DownloadedRow(
                    episode: group[i],
                    onPlay: () => PlayerService.instance.playQueue(
                      [for (final d in group) d.item],
                      startIndex: i,
                    ),
                  ),
              ],
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
                // The story title is already the group header above this row, so just the file size here.
                DownloadsList._size(episode.bytes),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.bodySmall
                    .override(fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 13, letterSpacing: 0),
              ),
            ]),
          ),
          IconButton(
            tooltip: trs('play'),
            icon: Icon(Icons.play_circle_fill_rounded, color: palette.accent, size: 34),
            onPressed: onPlay,
          ),
          IconButton(
            tooltip: trs('delete'),
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
              Text(state.locked ? 'Fungua kwanza ili upakue.' : trs('dl_failed_tap'),
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
          tooltip: failed ? 'Jaribu tena' : trs('cancel'),
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
