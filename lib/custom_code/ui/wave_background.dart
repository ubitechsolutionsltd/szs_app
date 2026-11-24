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
