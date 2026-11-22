// Shared building blocks for the player widgets: texts (Swahili), seek bar, sheets for queue / sleep timer /
// playlists, and the download button. All colours come from the FlutterFlow theme.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide RepeatMode;

import '/flutter_flow/flutter_flow_theme.dart';
import '/custom_code/ui/app_palette.dart';
import 'download_manager.dart';
import 'player_core.dart';
import 'player_service.dart';
import 'playlist_store.dart';

class PlayerStrings {
  static const nowPlaying = 'Inacheza sasa';
  static const queue = 'Foleni';
  static const queueEmpty = 'Foleni ni tupu';
  static const speed = 'Kasi';
  static const sleepTimer = 'Kipima muda';
  static const endOfEpisode = 'Mwisho wa kipindi';
  static const turnOff = 'Zima';
  static const download = 'Pakua';
  static const downloaded = 'Imepakuliwa';
  static const downloading = 'Inapakua';
  static const retry = 'Jaribu tena';
  static const addToPlaylist = 'Ongeza kwenye orodha';
  static const newPlaylist = 'Orodha mpya';
  static const playlistName = 'Jina la orodha';
  static const create = 'Unda';
  static const cancel = 'Ghairi';
  static const remove = 'Ondoa';
  static const added = 'Imeongezwa kwenye orodha';
  static const nothingPlaying = 'Hakuna kinachochezwa';
  static const locked = 'Simulizi hii imefungwa. Ifungue kwanza ili kuisikiliza.';
  static const nextLocked = 'Sehemu zinazofuata zimefungwa. Zifungue ili kuendelea.';
  static const offline = 'Hakuna mtandao. Pakua simulizi ili kusikiliza bila mtandao.';
  static const failed = 'Imeshindikana kucheza. Jaribu tena.';
  static String minutes(int m) => 'Dakika $m';

  static String? errorText(PlayerErrorCode code) {
    switch (code) {
      case PlayerErrorCode.locked:
        return locked;
      case PlayerErrorCode.nextLocked:
        return nextLocked;
      case PlayerErrorCode.offline:
        return offline;
      case PlayerErrorCode.failed:
        return failed;
      case PlayerErrorCode.none:
        return null;
    }
  }
}

String formatDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
}

class PlayerArtwork extends StatelessWidget {
  const PlayerArtwork({super.key, required this.url, required this.size, this.radius = 16});

  final String url;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);
    final placeholder = Container(
      width: size,
      height: size,
      color: pal.outline,
      child: Icon(Icons.headphones_rounded, color: pal.muted, size: size * 0.4),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: url.isEmpty
          ? placeholder
          : CachedNetworkImage(
              imageUrl: url,
              width: size,
              height: size,
              fit: BoxFit.cover,
              placeholder: (_, __) => placeholder,
              errorWidget: (_, __, ___) => placeholder,
            ),
    );
  }
}

/// Seek bar with buffered progress and a drag that only seeks when released.
class SeekBar extends StatefulWidget {
  const SeekBar({super.key, required this.service});

  final PlayerService service;

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragMs;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);

    return StreamBuilder<PlaybackPosition>(
      stream: widget.service.positionStream,
      builder: (context, snap) {
        final position = snap.data?.position ?? Duration.zero;
        final duration = snap.data?.duration ?? Duration.zero;
        final buffered = snap.data?.buffered ?? Duration.zero;
        final maxMs = duration.inMilliseconds <= 0 ? 1.0 : duration.inMilliseconds.toDouble();
        final valueMs = (_dragMs ?? position.inMilliseconds.toDouble()).clamp(0.0, maxMs);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                activeTrackColor: pal.accent,
                inactiveTrackColor: pal.outline,
                thumbColor: pal.accent,
                secondaryActiveTrackColor: pal.accent.withValues(alpha: 0.3),
              ),
              child: Slider(
                value: valueMs,
                min: 0,
                max: maxMs,
                secondaryTrackValue: buffered.inMilliseconds.toDouble().clamp(0.0, maxMs),
                onChanged: duration == Duration.zero ? null : (v) => setState(() => _dragMs = v),
                onChangeEnd: (v) {
                  widget.service.seek(Duration(milliseconds: v.toInt()));
                  setState(() => _dragMs = null);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(Duration(milliseconds: valueMs.toInt())),
                      style: theme.labelSmall.copyWith(color: pal.muted)),
                  Text(formatDuration(duration),
                      style: theme.labelSmall.copyWith(color: pal.muted)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Download / progress / downloaded / retry button for one episode.
class DownloadChip extends StatelessWidget {
  const DownloadChip({super.key, required this.item});

  final PlayableItem item;

  @override
  Widget build(BuildContext context) {
    final manager = DownloadManager.instance;
    if (!manager.supported) return const SizedBox.shrink();
    final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);

    return ValueListenableBuilder<Map<int, DownloadState>>(
      valueListenable: manager.states,
      builder: (context, _, __) {
        final state = manager.stateOf(item.id);
        late final IconData icon;
        late final String label;
        late final VoidCallback onTap;
        Widget? leading;

        switch (state.status) {
          case DownloadStatus.completed:
            icon = Icons.download_done_rounded;
            label = PlayerStrings.downloaded;
            onTap = () => manager.remove(item.id);
          case DownloadStatus.waiting:
          case DownloadStatus.downloading:
            icon = Icons.close_rounded;
            label = PlayerStrings.downloading;
            leading = SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, value: state.fraction, color: pal.accent),
            );
            onTap = () => manager.cancel(item.id);
          case DownloadStatus.failed:
            icon = Icons.refresh_rounded;
            label = state.locked ? PlayerStrings.locked : PlayerStrings.retry;
            onTap = () => manager.download(item);
          case DownloadStatus.none:
            icon = Icons.download_rounded;
            label = PlayerStrings.download;
            onTap = () => manager.download(item);
        }

        return ActionChip(
          avatar: leading ?? Icon(icon, size: 18, color: pal.text),
          label: Text(label, style: theme.labelMedium.copyWith(color: pal.text)),
          backgroundColor: pal.surface,
          side: BorderSide(color: pal.outline),
          onPressed: onTap,
        );
      },
    );
  }
}

class PlayerSheets {
  static const speeds = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  static Future<void> queue(BuildContext context, PlayerService service) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppPalette.of(context).solid,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.92,
        builder: (context, controller) => ValueListenableBuilder<PlayerSnapshot>(
          valueListenable: service.snapshot,
          builder: (context, snap, _) {
            final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);
            if (snap.queue.isEmpty) {
              return Center(child: Text(PlayerStrings.queueEmpty, style: theme.bodyLarge));
            }
            return ListView.builder(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
              itemCount: snap.queue.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(PlayerStrings.queue, style: theme.titleLarge),
                  );
                }
                final index = i - 1;
                final item = snap.queue[index];
                final current = index == snap.index;
                final available = item.hasRemoteUrl || DownloadManager.instance.isDownloaded(item.id);
                return ListTile(
                  leading: PlayerArtwork(url: item.artUrl, size: 44, radius: 8),
                  title: Text(item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.bodyLarge.copyWith(
                          color: current ? pal.accent : pal.text,
                          fontWeight: current ? FontWeight.w700 : FontWeight.w500)),
                  subtitle: item.subtitle.isEmpty ? null : Text(item.subtitle, maxLines: 1),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    if (!available) Icon(Icons.lock_outline_rounded, color: pal.muted, size: 20),
                    if (current && snap.playing) Icon(Icons.graphic_eq_rounded, color: pal.accent),
                    IconButton(
                      tooltip: PlayerStrings.remove,
                      icon: Icon(Icons.close_rounded, color: pal.muted),
                      onPressed: () => service.removeFromQueue(index),
                    ),
                  ]),
                  onTap: available ? () => service.jumpTo(index) : null,
                );
              },
            );
          },
        ),
      ),
    );
  }

  static Future<void> sleepTimer(BuildContext context, PlayerService service) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppPalette.of(context).solid,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);
        Widget option(String text, VoidCallback action, {IconData? icon}) => ListTile(
              leading: icon == null ? null : Icon(icon, color: pal.text),
              title: Text(text, style: theme.bodyLarge),
              onTap: () {
                action();
                Navigator.of(context).pop();
              },
            );
        return SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Align(alignment: Alignment.centerLeft, child: Text(PlayerStrings.sleepTimer, style: theme.titleLarge)),
            ),
            for (final minutes in const [15, 30, 45, 60])
              option(PlayerStrings.minutes(minutes), () => service.setSleepTimer(Duration(minutes: minutes)),
                  icon: Icons.bedtime_outlined),
            option(PlayerStrings.endOfEpisode, service.sleepAfterCurrentEpisode, icon: Icons.stop_circle_outlined),
            if (service.snapshot.value.sleepActive)
              option(PlayerStrings.turnOff, service.cancelSleep, icon: Icons.timer_off_outlined),
            const SizedBox(height: 8),
          ]),
        );
      },
    );
  }

  static Future<void> speed(BuildContext context, PlayerService service) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppPalette.of(context).solid,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        final theme = FlutterFlowTheme.of(context);
    final pal = AppPalette.of(context);
        return SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Align(alignment: Alignment.centerLeft, child: Text(PlayerStrings.speed, style: theme.titleLarge)),
            ),
            for (final value in speeds)
              ListTile(
                title: Text('${value}x', style: theme.bodyLarge),
                trailing: service.snapshot.value.speed == value ? Icon(Icons.check_rounded, color: pal.accent) : null,
                onTap: () {
                  service.setSpeed(value);
                  Navigator.of(context).pop();
                },
              ),
            const SizedBox(height: 8),
          ]),
        );
      },
    );
  }

  /// Pick a playlist (or create one) and add [item] to it.
  static Future<void> addToPlaylist(BuildContext context, PlayableItem item) {
    final store = PlaylistStore.instance;
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppPalette.of(context).solid,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) {
        final theme = FlutterFlowTheme.of(sheetContext);
    final pal = AppPalette.of(sheetContext);

        Future<void> add(String playlistId) async {
          await store.addItem(playlistId, item);
          if (sheetContext.mounted) {
            Navigator.of(sheetContext).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(PlayerStrings.added)));
          }
        }

        Future<void> createAndAdd() async {
          final controller = TextEditingController();
          final name = await showDialog<String>(
            context: sheetContext,
            builder: (dialogContext) => AlertDialog(
              title: const Text(PlayerStrings.newPlaylist),
              content: TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(hintText: PlayerStrings.playlistName),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text(PlayerStrings.cancel)),
                TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(controller.text),
                    child: const Text(PlayerStrings.create)),
              ],
            ),
          );
          if (name == null) return;
          final playlist = await store.create(name);
          await add(playlist.id);
        }

        return SafeArea(
          child: ValueListenableBuilder<List<Playlist>>(
            valueListenable: store.playlists,
            builder: (context, lists, _) => ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Text(PlayerStrings.addToPlaylist, style: theme.titleLarge),
                ),
                ListTile(
                  leading: Icon(Icons.add_rounded, color: pal.accent),
                  title: Text(PlayerStrings.newPlaylist, style: theme.bodyLarge.copyWith(color: pal.accent)),
                  onTap: createAndAdd,
                ),
                for (final list in lists)
                  ListTile(
                    leading: Icon(Icons.queue_music_rounded, color: pal.text),
                    title: Text(list.name, style: theme.bodyLarge),
                    subtitle: Text('${list.items.length}'),
                    onTap: () => add(list.id),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
