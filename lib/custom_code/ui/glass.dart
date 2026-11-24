import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// Plain brand background behind every screen (pale blue in light mode, navy in dark mode).
///
/// Kept under its old name so existing call sites keep working; the blurred "aurora" glows were removed for the
/// flatter blue-and-white look.
class AuroraBackground extends StatelessWidget {
  const AuroraBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ColoredBox(
      color: dark ? AppTokens.darkBackground : AppTokens.brandPale,
      child: child,
    );
  }
}

/// Card surface used by the bars and sheets. Despite the legacy name it is no longer blurred: a solid surface
/// with a hairline border and a soft blue-tinted shadow, which is cheaper to render and matches the new design.
class Glass extends StatelessWidget {
  const Glass({
    super.key,
    required this.child,
    this.radius = AppTokens.radiusCard,
    this.blur = 0,
    this.padding,
    this.borderRadius,
    this.strong = false,
    this.shadow = true,
  });

  final Widget child;
  final double radius;

  /// Ignored (kept so existing call sites compile).
  final double blur;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  /// Ignored (kept so existing call sites compile).
  final bool strong;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final shape = borderRadius ?? BorderRadius.circular(radius);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: dark ? AppTokens.darkSurface : AppTokens.surface,
        borderRadius: shape,
        border: Border.all(color: dark ? AppTokens.darkBorder : AppTokens.border, width: 1),
        boxShadow: shadow ? AppTokens.cardShadow(dark) : null,
      ),
      child: ClipRRect(borderRadius: shape, child: child),
    );
  }
}
