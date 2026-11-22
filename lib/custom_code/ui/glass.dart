import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Soft blue "aurora" behind every screen. Static (no animation) so it costs almost nothing.
class AuroraBackground extends StatelessWidget {
  const AuroraBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final palette = AppPalette.of(context);
    final blue = palette.accent;
    const cyan = Color(0xFF38BDF8);

    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: dark
                    ? const [Color(0xFF0A1630), Color(0xFF08101F)]
                    : const [Color(0xFFEAF3FC), Color(0xFFF6F9FD)],
              ),
            ),
            child: Stack(children: [
              Positioned(
                top: -120,
                left: -90,
                child: _glow(blue.withValues(alpha: dark ? 0.32 : 0.22), 340),
              ),
              Positioned(
                top: 220,
                right: -140,
                child: _glow(cyan.withValues(alpha: dark ? 0.16 : 0.18), 320),
              ),
              Positioned(
                bottom: -140,
                left: -60,
                child: _glow(blue.withValues(alpha: dark ? 0.22 : 0.14), 360),
              ),
            ]),
          ),
        ),
        child,
      ],
    );
  }

  static Widget _glow(Color color, double size) => ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      );
}

/// Frosted glass: blurred backdrop, translucent tint, bright hairline edge and a soft shadow.
class Glass extends StatelessWidget {
  const Glass({
    super.key,
    required this.child,
    this.radius = 20,
    this.blur = 22,
    this.padding,
    this.borderRadius,
    this.strong = false,
    this.shadow = true,
  });

  final Widget child;
  final double radius;
  final double blur;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  /// A more opaque tint, for surfaces that carry a lot of text.
  final bool strong;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final shape = borderRadius ?? BorderRadius.circular(radius);

    final fill = dark
        ? Colors.white.withValues(alpha: strong ? 0.12 : 0.07)
        : Colors.white.withValues(alpha: strong ? 0.78 : 0.55);
    final edge = dark ? Colors.white.withValues(alpha: 0.16) : Colors.white.withValues(alpha: 0.85);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: shape,
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: (dark ? Colors.black : const Color(0xFF0B3A66)).withValues(alpha: dark ? 0.35 : 0.10),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: shape,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: shape,
              border: Border.all(color: edge, width: 1),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [fill, fill.withValues(alpha: fill.a * 0.65)],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
