import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// Brand blue gradient with soft layered waves (splash, player footer, auth headers).
/// Pure widgets/painting: no image assets.
class WaveBackground extends StatelessWidget {
  const WaveBackground({super.key, this.child, this.colors, this.waves = true});

  final Widget? child;
  final List<Color>? colors;
  final bool waves;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors ?? const [AppTokens.brandPrimary, AppTokens.brandDeep],
        ),
      ),
      child: waves
          ? CustomPaint(painter: _WavePainter(), child: child ?? const SizedBox.expand())
          : child,
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    Path wave(double top, double amp, double phase) {
      final p = Path()..moveTo(0, top);
      p.cubicTo(w * 0.25, top - amp + phase, w * 0.55, top + amp + phase, w, top - amp * 0.4);
      p.lineTo(w, h);
      p.lineTo(0, h);
      return p..close();
    }

    canvas.drawPath(wave(h * 0.80, 34, 0), Paint()..color = Colors.white.withValues(alpha: 0.07));
    canvas.drawPath(wave(h * 0.86, 28, 14), Paint()..color = Colors.white.withValues(alpha: 0.09));
    canvas.drawPath(wave(h * 0.92, 20, -10), Paint()..color = Colors.white.withValues(alpha: 0.10));

    // Soft sweep in the top corner.
    final top = Path()
      ..moveTo(0, 0)
      ..lineTo(w * 0.75, 0)
      ..cubicTo(w * 0.5, h * 0.06, w * 0.2, h * 0.08, 0, h * 0.2)
      ..close();
    canvas.drawPath(top, Paint()..color = Colors.white.withValues(alpha: 0.06));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Soft translucent curves for the top-right of a blue header (matches the reference headers).
class HeaderWaves extends StatelessWidget {
  const HeaderWaves({super.key});

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _HeaderWavePainter(), size: Size.infinite);
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final a = Path()
      ..moveTo(w * 0.25, 0)
      ..cubicTo(w * 0.45, h * 0.55, w * 0.75, h * 0.15, w, h * 0.5)
      ..lineTo(w, 0)
      ..close();
    canvas.drawPath(a, Paint()..color = Colors.white.withValues(alpha: 0.08));
    final b = Path()
      ..moveTo(0, h * 0.75)
      ..cubicTo(w * 0.3, h * 1.05, w * 0.6, h * 0.55, w, h * 0.85)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(b, Paint()..color = Colors.white.withValues(alpha: 0.07));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Pale-blue wave strip for the bottom of light pages (About, password recovery).
class FooterWave extends StatelessWidget {
  const FooterWave({super.key, this.height = 110});

  final double height;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: SizedBox(height: height, width: double.infinity, child: CustomPaint(painter: _FooterWavePainter())),
      );
}

class _FooterWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    Path wave(double top, double amp) => Path()
      ..moveTo(0, top)
      ..cubicTo(w * 0.3, top - amp, w * 0.6, top + amp, w, top - amp * 0.3)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(wave(h * 0.35, 22), Paint()..color = AppTokens.brandPrimary.withValues(alpha: 0.10));
    canvas.drawPath(wave(h * 0.58, 20), Paint()..color = AppTokens.brandPrimary.withValues(alpha: 0.16));
    canvas.drawPath(wave(h * 0.8, 14), Paint()..color = AppTokens.brandPrimary.withValues(alpha: 0.26));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
