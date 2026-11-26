import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '/app_state.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/package_lists_component_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_util.dart';
import 'app_components.dart';
import 'app_tokens.dart';
import 'auth_gate.dart';

/// Everything about paying for an episode: is it locked, what does it cost, and the unlock flow.
///
/// * Guest: asks to log in.
/// * Logged in with enough coins: buys it straight away (no confirmation) behind a short "unlocking" animation,
///   then the episode starts playing. The price is always visible on the button that triggers it.
/// * Not enough coins: an animated sheet explains the price and the missing amount and opens the top-up sheet.
class EpisodeUnlock {
  EpisodeUnlock._();

  static int price(dynamic episode) =>
      functions.jsonValueToInteger(getJsonField(episode, r'''$["is_audio_coin"]'''));

  static bool owned(dynamic episode) =>
      functions.jsonValueToInteger(getJsonField(episode, r'''$["is_buy"]''')) == 1;

  static bool isLocked(dynamic episode) => episode != null && !owned(episode) && price(episode) > 0;

  static bool _busy = false;

  /// Returns true when the episode is (now) unlocked and has been queued to play.
  static Future<bool> run(BuildContext context, {required dynamic episode}) async {
    if (_busy || episode == null) return false;
    if (!isLocked(episode)) {
      _play(episode);
      return true;
    }
    if (!isLoggedIn) {
      promptLogin(context, trs('login_to_buy'));
      return false;
    }

    final cost = price(episode);
    if (FFAppState().walletcoin >= cost) {
      _busy = true;
      try {
        final ok = await showGeneralDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black.withValues(alpha: 0.55),
          transitionDuration: const Duration(milliseconds: 220),
          pageBuilder: (_, __, ___) => _UnlockingDialog(episode: episode, cost: cost),
          transitionBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
        );
        if (ok == true) {
          _play(episode);
          return true;
        }
        return false;
      } finally {
        _busy = false;
      }
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _TopUpSheet(episode: episode, cost: cost),
    );
    return false;
  }

  /// Buys the episode with no dialog and no confirmation, for places that cannot show one: advancing playback
  /// to a locked next episode, or resuming/bulk-downloading locked episodes. Only acts when the episode is
  /// locked, the user is logged in and the balance already covers it; otherwise it changes nothing and returns
  /// whether the episode is playable right now (so "already unlocked" also reports true).
  static Future<bool> silentUnlock(dynamic episode) async {
    if (episode == null) return false;
    if (!isLocked(episode)) return true;
    if (!isLoggedIn) return false;
    final cost = price(episode);
    if (FFAppState().walletcoin < cost) return false;
    if (_busy) return false; // an interactive unlock is already in flight for some other episode
    _busy = true;
    try {
      return await _buy(episode, cost);
    } finally {
      _busy = false;
    }
  }

  static void _play(dynamic episode) {
    final state = FFAppState();
    state.nowPlaying = episode;
    state.playercommand = 'play';
    state.playerisplaying = true;
    state.update(() {});
  }

  static Future<bool> _buy(dynamic episode, int cost) async {
    final state = FFAppState();
    state.isLoading = false;
    final response = await GeneralGroup.buyEpisodeCall.call(
      userId: state.userid,
      contentType: getJsonField(episode, r'''$["audio_type"]''').toString(),
      audiobookType: getJsonField(episode, r'''$["audio_type"]''').toString(),
      contentId: getJsonField(episode, r'''$["content_id"]''').toString(),
      contentEpisodeId: getJsonField(episode, r'''$.id''').toString(),
      coin: getJsonField(episode, r'''$["is_audio_coin"]''').toString(),
    );
    final ok = response.succeeded && GeneralGroup.buyEpisodeCall.responseCode(response.jsonBody) == 200;
    if (ok) {
      state.walletcoin = functions.newWalletBalance(state.walletcoin, cost);
      try {
        (episode as Map)['is_buy'] = 1; // so the rest of the screen sees it as unlocked at once
      } catch (_) {}
      state.update(() {});
    }
    return ok;
  }
}

// ── Reusable artwork ───────────────────────────────────────────────────────────────────────────────────────────

/// Glowing lock badge: slow breathing rings and a gentle float, in gold on deep blue.
class AnimatedLockBadge extends StatefulWidget {
  const AnimatedLockBadge({super.key, this.size = 92, this.open = false});

  final double size;

  /// Shows an open padlock (used by the success animation).
  final bool open;

  @override
  State<AnimatedLockBadge> createState() => _AnimatedLockBadgeState();
}

class _AnimatedLockBadgeState extends State<AnimatedLockBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = _c.value;
        final float = math.sin(t * 2 * math.pi) * 3;
        return SizedBox(
          width: s * 1.9,
          height: s * 1.9,
          child: Stack(alignment: Alignment.center, children: [
            for (var i = 0; i < 3; i++) _ring(s, (t + i / 3) % 1.0),
            Transform.translate(
              offset: Offset(0, float),
              child: Container(
                width: s,
                height: s,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF9BDCFF), Color(0xFF3FB4FF)],
                  ),
                  boxShadow: [BoxShadow(color: const Color(0xFF3FB4FF).withValues(alpha: 0.55), blurRadius: 28, spreadRadius: 2)],
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 420),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: CurvedAnimation(parent: anim, curve: Curves.elasticOut), child: child),
                  child: Icon(
                    widget.open ? Icons.lock_open_rounded : Icons.lock_rounded,
                    key: ValueKey(widget.open),
                    size: s * 0.5,
                    color: const Color(0xFF07549A),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  Widget _ring(double s, double p) {
    final d = s * (1.0 + p * 0.9);
    return Container(
      width: d,
      height: d,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF9BDCFF).withValues(alpha: (1 - p) * 0.45), width: 2),
      ),
    );
  }
}

/// Coin amount in a pill, e.g. "🪙 300".
class CoinPill extends StatelessWidget {
  const CoinPill({super.key, required this.label, this.warn = false});

  final String label;
  final bool warn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.toll_rounded, size: 17, color: warn ? const Color(0xFFFFB4B4) : const Color(0xFF9BDCFF)),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

/// Card shown in place of the player while the selected episode is locked: animated lock, price, balance and a
/// single clear action. A soft light sweep crosses the card to give it a "premium" feel.
class LockedEpisodeCard extends StatefulWidget {
  const LockedEpisodeCard({super.key, required this.episode});

  final dynamic episode;

  @override
  State<LockedEpisodeCard> createState() => _LockedEpisodeCardState();
}

class _LockedEpisodeCardState extends State<LockedEpisodeCard> with SingleTickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(vsync: this, duration: const Duration(milliseconds: 3200))..repeat();

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cost = EpisodeUnlock.price(widget.episode);
    final balance = FFAppState().walletcoin;
    final enough = isLoggedIn && balance >= cost;
    final missing = cost - balance;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0B2C57), AppTokens.brandDeep, Color(0xFF0A6FC2)]),
          ),
          child: Column(children: [
            const AnimatedLockBadge(),
            Transform.translate(
              offset: const Offset(0, -14),
              child: Column(children: [
                Text(trs('locked_title'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(trs('locked_sub', args: {'n': '$cost'}),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white.withValues(alpha: 0.82), fontSize: 14.5, height: 1.4)),
                const SizedBox(height: 14),
                Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
                  CoinPill(label: '$cost'),
                  if (isLoggedIn) CoinPill(label: trs('balance_n', args: {'n': '$balance'}), warn: !enough),
                ]),
                if (isLoggedIn && !enough) ...[
                  const SizedBox(height: 10),
                  Text(trs('need_more', args: {'n': '$missing'}),
                      style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Color(0xFFFFC2C2), fontSize: 13, fontWeight: FontWeight.w600)),
                ],
                const SizedBox(height: 16),
                _CtaButton(
                  label: !isLoggedIn ? trs('gdn2b1x7') : (enough ? trs('unlock_cta') : trs('top_up')),
                  icon: !isLoggedIn ? Icons.login_rounded : (enough ? Icons.lock_open_rounded : Icons.add_card_rounded),
                  onTap: () => EpisodeUnlock.run(context, episode: widget.episode),
                ),
              ]),
            ),
          ]),
        ),
        // Light sweep.
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _sweep,
              builder: (context, _) => FractionalTranslation(
                translation: Offset(-1.2 + _sweep.value * 3.2, 0),
                child: Transform.rotate(
                  angle: -0.35,
                  child: FractionallySizedBox(
                    widthFactor: 0.28,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.white.withValues(alpha: 0), Colors.white.withValues(alpha: 0.10), Colors.white.withValues(alpha: 0)]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTokens.radiusButton),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusButton),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppTokens.buttonHeight, minWidth: double.infinity),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, color: AppTokens.brandDeep, size: 22),
              const SizedBox(width: 8),
              Flexible(
                child: Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: AppTokens.fontFamily, color: AppTokens.brandDeep, fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Unlocking animation (balance is enough) ────────────────────────────────────────────────────────────────────

class _UnlockingDialog extends StatefulWidget {
  const _UnlockingDialog({required this.episode, required this.cost});

  final dynamic episode;
  final int cost;

  @override
  State<_UnlockingDialog> createState() => _UnlockingDialogState();
}

enum _Phase { buying, done, failed }

class _UnlockingDialogState extends State<_UnlockingDialog> with SingleTickerProviderStateMixin {
  _Phase _phase = _Phase.buying;
  late final AnimationController _burst = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    var ok = false;
    try {
      // Keep the animation on screen for at least a moment so it never flickers.
      final purchase = EpisodeUnlock._buy(widget.episode, widget.cost);
      await Future<void>.delayed(const Duration(milliseconds: 900));
      ok = await purchase;
    } catch (_) {}
    if (!mounted) return;
    setState(() => _phase = ok ? _Phase.done : _Phase.failed);
    if (ok) _burst.forward();
    await Future<void>.delayed(Duration(milliseconds: ok ? 1300 : 1800));
    if (mounted) Navigator.of(context).pop(ok);
  }

  @override
  void dispose() {
    _burst.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final failed = _phase == _Phase.failed;
    final done = _phase == _Phase.done;
    return PopScope(
      canPop: false,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0B2C57), AppTokens.brandDeep]),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 40, offset: const Offset(0, 18))],
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: 170,
                child: Stack(alignment: Alignment.center, children: [
                  if (done) _Sparkles(progress: _burst),
                  if (failed)
                    const Icon(Icons.error_outline_rounded, size: 72, color: Color(0xFFFFB4B4))
                  else
                    AnimatedLockBadge(size: 84, open: done),
                ]),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                child: Text(
                  failed ? trs('buy_failed') : (done ? trs('unlocked') : trs('unlocking')),
                  key: ValueKey(_phase),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 8),
              if (done)
                Text(trs('unlocked_sub', args: {'n': '${widget.cost}', 'b': '${FFAppState().walletcoin}'}),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white.withValues(alpha: 0.85), fontSize: 14))
              else if (!failed)
                const SizedBox(width: 120, child: LinearProgressIndicator(minHeight: 3, color: Color(0xFF9BDCFF), backgroundColor: Colors.white24)),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Little golden sparks that fly out when an episode unlocks.
class _Sparkles extends StatelessWidget {
  const _Sparkles({required this.progress});

  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) => CustomPaint(size: const Size(170, 170), painter: _SparklePainter(Curves.easeOutCubic.transform(progress.value))),
    );
  }
}

class _SparklePainter extends CustomPainter {
  _SparklePainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final paint = Paint()..color = const Color(0xFF9BDCFF).withValues(alpha: (1 - t).clamp(0.0, 1.0));
    for (var i = 0; i < 14; i++) {
      final a = i / 14 * 2 * math.pi;
      final r = 46 + t * (40 + (i % 3) * 14);
      final p = c + Offset(math.cos(a), math.sin(a)) * r;
      canvas.drawCircle(p, (i.isEven ? 4.0 : 2.6) * (1 - t * 0.5), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklePainter old) => old.t != t;
}

// ── Not enough coins ───────────────────────────────────────────────────────────────────────────────────────────

class _TopUpSheet extends StatelessWidget {
  const _TopUpSheet({required this.episode, required this.cost});

  final dynamic episode;
  final int cost;

  @override
  Widget build(BuildContext context) {
    final balance = FFAppState().walletcoin;
    final missing = (cost - balance).clamp(0, 1 << 30);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0B2C57), AppTokens.brandDeep, Color(0xFF0A6FC2)]),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const AnimatedLockBadge(),
                Transform.translate(
                  offset: const Offset(0, -12),
                  child: Column(children: [
                    Text(trs('locked_title'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(trs('unlock_sheet_hint'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white.withValues(alpha: 0.82), fontSize: 14.5, height: 1.4)),
                    const SizedBox(height: 14),
                    Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
                      CoinPill(label: '$cost'),
                      CoinPill(label: trs('balance_n', args: {'n': '$balance'}), warn: true),
                    ]),
                    const SizedBox(height: 10),
                    Text(trs('need_more', args: {'n': '$missing'}),
                        style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Color(0xFFFFC2C2), fontSize: 13.5, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 18),
                    _CtaButton(
                      label: trs('top_up'),
                      icon: Icons.add_card_rounded,
                      onTap: () async {
                        Navigator.of(context).pop();
                        await showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => WebViewAware(
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(ctx),
                              child: SizedBox(height: MediaQuery.sizeOf(ctx).height * 0.75, child: PackageListsComponentWidget(episode: episode)),
                            ),
                          ),
                        );
                      },
                    ),
                    AppButton(label: trs('cancel'), kind: AppButtonKind.text, onPressed: () => Navigator.of(context).pop()),
                  ]),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
