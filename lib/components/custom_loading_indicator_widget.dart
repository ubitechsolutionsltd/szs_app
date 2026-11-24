import 'dart:math' as math;
import 'dart:ui';

import '/custom_code/ui/app_palette.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_loading_indicator_model.dart';
export 'custom_loading_indicator_model.dart';

class CustomLoadingIndicatorWidget extends StatefulWidget {
  const CustomLoadingIndicatorWidget({super.key});

  @override
  State<CustomLoadingIndicatorWidget> createState() =>
      _CustomLoadingIndicatorWidgetState();
}

class _CustomLoadingIndicatorWidgetState
    extends State<CustomLoadingIndicatorWidget> with TickerProviderStateMixin {
  late CustomLoadingIndicatorModel _model;
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    _controller.dispose();
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final palette = AppPalette.of(context);
    final visible = FFAppState().isLoading;

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: palette.background.withValues(alpha: 0.38)),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.85, end: 1.0),
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
                    child: Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(
                        color: palette.solid,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: palette.outline, width: 0.8),
                        boxShadow: [
                          BoxShadow(
                            color: palette.accent.withValues(alpha: 0.18),
                            blurRadius: 28,
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                      child: CustomPaint(
                        painter: _StoryLoaderPainter(
                          progress: _controller.value,
                          accent: palette.accent,
                          track: palette.outline,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Paints a slowly spinning gradient arc (the "loading" read) around a small
/// audio-equalizer pulse (bars breathing like a story is being narrated) —
/// a motif native to an audio-storytelling app rather than a generic spinner.
class _StoryLoaderPainter extends CustomPainter {
  _StoryLoaderPainter({required this.progress, required this.accent, required this.track});

  /// Loops 0..1 continuously.
  final double progress;
  final Color accent;
  final Color track;

  static const _tau = math.pi * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final ringRadius = size.shortestSide / 2 - 10;

    // Faint full track ring, so the arc reads as "progress" rather than a bare streak.
    canvas.drawCircle(
      center,
      ringRadius,
      Paint()
        ..color = track
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Rotating gradient arc.
    final arcRect = Rect.fromCircle(center: center, radius: ringRadius);
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: _tau,
        colors: [accent.withValues(alpha: 0.0), accent.withValues(alpha: 0.0), accent],
        stops: const [0.0, 0.62, 1.0],
        transform: GradientRotation(progress * _tau),
      ).createShader(arcRect);
    canvas.drawArc(arcRect, 0, _tau, false, arcPaint);

    // Centered equalizer: bars breathing at staggered phases, like narration levels.
    const barCount = 4;
    const barWidth = 5.0;
    const gap = 6.0;
    const minH = 8.0;
    const maxH = 26.0;
    final totalWidth = barCount * barWidth + (barCount - 1) * gap;
    var x = center.dx - totalWidth / 2 + barWidth / 2;
    final barPaint = Paint()
      ..color = accent
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < barCount; i++) {
      final phase = progress * _tau * 1.6 + i * 1.15;
      final h = minH + (maxH - minH) * (0.5 + 0.5 * math.sin(phase));
      canvas.drawLine(Offset(x, center.dy + h / 2), Offset(x, center.dy - h / 2), barPaint);
      x += barWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _StoryLoaderPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.accent != accent || oldDelegate.track != track;
}
