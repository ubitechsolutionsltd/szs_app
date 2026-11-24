import 'dart:math' as math;

import 'package:flutter/material.dart';

import '/flutter_flow/internationalization.dart' show trs;
import 'app_components.dart';
import 'app_tokens.dart';

/// Animated "no connection" illustration: floating headphones inside breathing sound rings, an equalizer that
/// keeps moving, and a small cloud-off badge. Built only from shapes, so it works with no network at all.
class OfflineArt extends StatefulWidget {
  const OfflineArt({super.key, this.message, this.onRetry, this.compact = false});

  final String? message;
  final VoidCallback? onRetry;

  /// Smaller version for use inside a section (not a whole screen).
  final bool compact;

  @override
  State<OfflineArt> createState() => _OfflineArtState();
}

class _OfflineArtState extends State<OfflineArt> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 3200))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final accent = dark ? AppTokens.darkAccent : AppTokens.brandPrimary;
    final text = dark ? AppTokens.darkText : AppTokens.textPrimary;
    final muted = dark ? AppTokens.darkTextSecondary : AppTokens.textSecondary;
    final size = widget.compact ? 120.0 : 168.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTokens.screenPadding, vertical: widget.compact ? 8 : 24),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, widget.compact ? 14 : 24, 20, widget.compact ? 16 : 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard + 6),
          color: dark ? AppTokens.darkSurface : AppTokens.surface,
          border: Border.all(color: dark ? AppTokens.darkBorder : AppTokens.border),
          boxShadow: AppTokens.cardShadow(dark),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [accent.withValues(alpha: dark ? 0.16 : 0.07), Colors.transparent],
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            width: size,
            height: size * 0.82,
            child: AnimatedBuilder(
              animation: _c,
              builder: (context, _) => CustomPaint(painter: _OfflinePainter(_c.value, accent, dark), size: Size(size, size * 0.82)),
            ),
          ),
          SizedBox(height: widget.compact ? 6 : 14),
          Text(trs('offline_title'),
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: AppTokens.fontFamily, color: text, fontSize: widget.compact ? 17 : 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(widget.message ?? trs('offline_sub'),
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 14, height: 1.45)),
          if (widget.onRetry != null) ...[
            const SizedBox(height: 14),
            AppButton(label: trs('retry'), icon: Icons.refresh_rounded, onPressed: widget.onRetry, expand: false),
          ],
        ]),
      ),
    );
  }
}

class _OfflinePainter extends CustomPainter {
  _OfflinePainter(this.t, this.accent, this.dark);

  final double t;
  final Color accent;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final base = math.min(size.width, size.height) / 2;

    // Breathing sound rings.
    for (var i = 0; i < 3; i++) {
      final p = (t + i / 3) % 1.0;
      canvas.drawCircle(
        c,
        base * (0.55 + p * 0.55),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = accent.withValues(alpha: (1 - p) * 0.35),
      );
    }

    // Soft disc.
    canvas.drawCircle(c, base * 0.56, Paint()..color = accent.withValues(alpha: dark ? 0.22 : 0.12));

    // Floating headphones (band + ear cups).
    final bob = math.sin(t * 2 * math.pi) * 4;
    final hc = c + Offset(0, bob - 2);
    final r = base * 0.3;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = base * 0.085
      ..strokeCap = StrokeCap.round
      ..color = accent;
    canvas.drawArc(Rect.fromCircle(center: hc, radius: r), math.pi, math.pi, false, stroke);
    final cup = Paint()..color = accent;
    for (final dx in [-r, r]) {
      final rect = RRect.fromRectAndRadius(Rect.fromCenter(center: hc + Offset(dx, r * 0.45), width: r * 0.5, height: r * 0.9), Radius.circular(r * 0.22));
      canvas.drawRRect(rect, cup);
    }

    // Equalizer bars that keep moving (the app is "waiting", not dead).
    final barPaint = Paint()..color = accent.withValues(alpha: 0.55);
    for (var i = 0; i < 5; i++) {
      final h = base * (0.12 + 0.12 * (math.sin(t * 2 * math.pi * 2 + i * 1.3) + 1));
      final x = c.dx - base * 0.28 + i * base * 0.14;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, c.dy + base * 0.62 - h, base * 0.07, h), Radius.circular(base * 0.035)),
        barPaint,
      );
    }

    // Cloud-off badge.
    final bc = c + Offset(base * 0.62, -base * 0.5);
    canvas.drawCircle(bc, base * 0.2, Paint()..color = dark ? const Color(0xFF2A3E63) : Colors.white);
    canvas.drawCircle(bc, base * 0.2, Paint()..style = PaintingStyle.stroke..strokeWidth = 1.5..color = accent.withValues(alpha: 0.5));
    final slash = Paint()
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE5484D);
    canvas.drawLine(bc + Offset(-base * 0.09, -base * 0.09), bc + Offset(base * 0.09, base * 0.09), slash);
    canvas.drawCircle(bc, base * 0.09, Paint()..style = PaintingStyle.stroke..strokeWidth = 2.2..color = accent);
  }

  @override
  bool shouldRepaint(covariant _OfflinePainter old) => old.t != t;
}
