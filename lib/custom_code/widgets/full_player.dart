// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/wave_background.dart';
import '/custom_code/player/download_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'dart:ui' show ImageFilter;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/index.dart';
import '/custom_code/player/player_core.dart';
import '/custom_code/player/player_service.dart';
import '/custom_code/player/player_ui.dart';

/// The full-screen player: a dark, cover-tinted screen with large artwork, seek bar, ±15s skip, play/pause,
/// speed, queue, sleep timer and download. Loading, buffering, error and empty states are all handled.
class FullPlayer extends StatelessWidget {
  const FullPlayer({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  static const _bg = Color(0xFF081327);
  static const _glow = Color(0xFF3FB4FF);

  @override
  Widget build(BuildContext context) {
    final service = PlayerService.instance;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: ColoredBox(
        color: _bg,
        child: SizedBox(
          width: width,
          height: height ?? double.infinity,
          child: ValueListenableBuilder<PlayerSnapshot>(
            valueListenable: service.snapshot,
            builder: (context, snap, _) {
              final item = snap.item;
              return Stack(fit: StackFit.expand, children: [
                if (item != null && item.artUrl.isNotEmpty) _blurredCover(item.artUrl),
                // Navy wash so text stays readable whatever the cover looks like.
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x99081327), Color(0xE6081327), _bg],
                      stops: [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
                const Align(alignment: Alignment.bottomCenter, child: FooterWave(height: 150)),
                SafeArea(
                  child: item == null ? _empty(context) : _content(context, service, snap, item),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }

  Widget _blurredCover(String url) {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 38, sigmaY: 38),
        child: Transform.scale(
          scale: 1.5,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => const SizedBox.shrink(),
            placeholder: (_, __) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context, PlayerService service, PlayerSnapshot snap, {bool showTools = true}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(children: [
        IconButton(
          tooltip: trs('close'),
          iconSize: 30,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        Expanded(
          child: Text(
            PlayerStrings.nowPlaying.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: AppTokens.fontFamily, color: Colors.white70, fontSize: 12, letterSpacing: 1.6, fontWeight: FontWeight.w700),
          ),
        ),
        if (showTools) ...[
          IconButton(
            tooltip: trs('shuffle'),
            constraints: const BoxConstraints(minWidth: 44, minHeight: 48),
            icon: Icon(Icons.shuffle_rounded, color: snap.shuffle ? _glow : Colors.white70),
            onPressed: () => service.setShuffle(!snap.shuffle),
          ),
          IconButton(
            tooltip: trs('repeat'),
            constraints: const BoxConstraints(minWidth: 44, minHeight: 48),
            icon: Icon(snap.repeat == QueueRepeat.one ? Icons.repeat_one_rounded : Icons.repeat_rounded,
                color: snap.repeat == QueueRepeat.off ? Colors.white70 : _glow),
            onPressed: service.cycleRepeat,
          ),
        ] else
          const SizedBox(width: 48),
      ]),
    );
  }

  Widget _empty(BuildContext context) {
    return Column(children: [
      _topBar(context, PlayerService.instance, const PlayerSnapshot(), showTools: false),
      Expanded(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.headphones_rounded, color: Colors.white54, size: 64),
              SizedBox(height: 16),
              Text(PlayerStrings.nothingPlaying,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white70, fontSize: 17)),
            ]),
          ),
        ),
      ),
    ]);
  }

  Widget _content(BuildContext context, PlayerService service, PlayerSnapshot snap, PlayableItem item) {
    final errorText = PlayerStrings.errorText(snap.error);
    final size = MediaQuery.sizeOf(context);
    // Artwork scales with the screen but never crowds the controls on short phones.
    final artWidth = (size.width * 0.66).clamp(150.0, size.height * 0.34).clamp(150.0, 320.0).toDouble();

    return Column(children: [
      _topBar(context, service, snap),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
          child: Column(children: [
            PlayerArtwork(url: item.artUrl, size: artWidth, aspect: 1.18, radius: 24, playing: snap.playing),
            const SizedBox(height: 26),
            Text(item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, height: 1.15)),
            if (item.subtitle.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(item.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white70, fontSize: 16)),
            ],
            if (errorText != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B6B).withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(children: [
                  const Icon(Icons.info_outline_rounded, color: Color(0xFFFF9B9B), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(errorText,
                        style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Color(0xFFFFC2C2), fontSize: 13, height: 1.35)),
                  ),
                  if (snap.error == PlayerErrorCode.loginRequired)
                    TextButton(
                      onPressed: () {
                        final router = context;
                        Navigator.of(context).pop();
                        router.pushNamed(LoginPageWidget.routeName);
                      },
                      child: Text(trs('gdn2b1x7'),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                ]),
              ),
            ],
            const SizedBox(height: 20),
            SeekBar(service: service, onDark: true),
            const SizedBox(height: 10),
            _Transport(snap: snap, service: service),
            const SizedBox(height: 24),
            _ActionRow(snap: snap, service: service, item: item),
          ]),
        ),
      ),
    ]);
  }
}

class _Transport extends StatelessWidget {
  const _Transport({required this.snap, required this.service});

  final PlayerSnapshot snap;
  final PlayerService service;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          iconSize: 36,
          tooltip: trs('previous'),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 56),
          icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
          onPressed: service.previous,
        ),
        _SkipButton(forward: false, onTap: () => service.seekRelative(const Duration(seconds: -15))),
        SizedBox(
          width: 76,
          height: 76,
          child: _PlayButton(
            playing: snap.playing,
            loading: snap.loading && !snap.playing,
            onTap: service.toggle,
          ),
        ),
        _SkipButton(forward: true, onTap: () => service.seekRelative(const Duration(seconds: 15))),
        IconButton(
          iconSize: 36,
          tooltip: trs('next'),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 56),
          icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
          onPressed: service.next,
        ),
      ],
    );
  }
}

/// ±15 second skip: a circular arrow with "15" in the middle.
class _SkipButton extends StatelessWidget {
  const _SkipButton({required this.forward, required this.onTap});

  final bool forward;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: forward ? 'Ruka sekunde 15' : trs('back15'),
      child: InkResponse(
        radius: 30,
        onTap: onTap,
        child: SizedBox(
          width: 52,
          height: 56,
          child: Stack(alignment: Alignment.center, children: [
            Transform.flip(
              flipX: forward,
              child: const Icon(Icons.replay_rounded, color: Colors.white, size: 40),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text('15',
                  style: TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
            ),
          ]),
        ),
      ),
    );
  }
}

/// Labelled action under the transport (Kasi, Foleni, Muda, Pakua).
class _Action extends StatelessWidget {
  const _Action({required this.label, required this.onTap, this.icon, this.leading, this.active = false});

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? leading;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? FullPlayer._glow : Colors.white;
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(height: 30, child: Center(child: leading ?? Icon(icon, color: color, size: 28))),
              const SizedBox(height: 4),
              Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: AppTokens.fontFamily, color: color, fontSize: 12, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.snap, required this.service, required this.item});

  final PlayerSnapshot snap;
  final PlayerService service;
  final PlayableItem item;

  String _speedLabel() => snap.speed == snap.speed.roundToDouble() ? '${snap.speed.toInt()}.0x' : '${snap.speed}x';

  @override
  Widget build(BuildContext context) {
    final manager = DownloadManager.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Action(
          label: PlayerStrings.speed,
          leading: Text(_speedLabel(),
              style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
          onTap: () => PlayerSheets.speed(context, service),
        ),
        _Action(
          label: PlayerStrings.queue,
          icon: Icons.format_list_bulleted_rounded,
          onTap: () => PlayerSheets.queue(context, service),
        ),
        _Action(
          label: snap.sleepRemaining != null ? formatDuration(snap.sleepRemaining!) : trs('timer_short'),
          icon: Icons.timer_outlined,
          active: snap.sleepActive,
          onTap: () => PlayerSheets.sleepTimer(context, service),
        ),
        _Action(
          label: trs('playlist'),
          icon: Icons.playlist_add_rounded,
          onTap: () => PlayerSheets.addToPlaylist(context, item),
        ),
        if (manager.supported) _DownloadAction(item: item),
      ],
    );
  }
}

class _DownloadAction extends StatelessWidget {
  const _DownloadAction({required this.item});

  final PlayableItem item;

  @override
  Widget build(BuildContext context) {
    final manager = DownloadManager.instance;
    return ValueListenableBuilder<Map<int, DownloadState>>(
      valueListenable: manager.states,
      builder: (context, _, __) {
        final state = manager.stateOf(item.id);
        switch (state.status) {
          case DownloadStatus.completed:
            return _Action(label: trs('downloaded'), icon: Icons.download_done_rounded, active: true, onTap: () => manager.remove(item.id));
          case DownloadStatus.waiting:
          case DownloadStatus.downloading:
            return _Action(
              label: trs('downloading'),
              leading: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.4, value: state.fraction, color: FullPlayer._glow),
              ),
              onTap: () => manager.cancel(item.id),
            );
          case DownloadStatus.failed:
            return _Action(
                label: state.locked ? 'Imefungwa' : PlayerStrings.retry,
                icon: Icons.refresh_rounded,
                onTap: () => manager.download(item));
          case DownloadStatus.none:
            return _Action(label: trs('download_short'), icon: Icons.download_rounded, onTap: () => manager.download(item));
        }
      },
    );
  }
}

/// The central play/pause button: blue gradient with a soft glow, a pulse while playing, a spinner while
/// loading or buffering, and a scale+fade swap between the play and pause glyphs.
class _PlayButton extends StatefulWidget {
  const _PlayButton({required this.playing, required this.loading, required this.onTap});

  final bool playing;
  final bool loading;
  final VoidCallback onTap;

  @override
  State<_PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<_PlayButton> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))
    ..repeat();
  bool _pressed = false;

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const size = 76.0;
    return Semantics(
      button: true,
      label: widget.playing ? 'Simamisha' : trs('play'),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            final t = widget.playing ? _pulse.value : 0.0;
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                if (widget.playing)
                  Container(
                    width: size + t * 26,
                    height: size + t * 26,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: FullPlayer._glow.withValues(alpha: (1 - t) * 0.25)),
                  ),
                child!,
              ],
            );
          },
          child: AnimatedScale(
            scale: _pressed ? 0.93 : 1.0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3FB4FF), AppTokens.brandPrimary],
                ),
                boxShadow: [BoxShadow(color: FullPlayer._glow.withValues(alpha: 0.5), blurRadius: 24, offset: const Offset(0, 8))],
              ),
              child: Center(
                child: widget.loading
                    ? const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white))
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          widget.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          key: ValueKey(widget.playing),
                          size: 44,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
