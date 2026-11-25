import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// Tablet support. Phones (< [breakpoint]) are untouched. On wider screens (iPad, Android tablets, landscape) the
/// whole app is shown in a centred, rounded "panel" of [panelMaxWidth] over the brand background, and the
/// panel reports its own width through [MediaQuery] so every screen lays out for the width it really has.
class Adaptive {
  Adaptive._();

  static const double breakpoint = 700;
  static const double panelMaxWidth = 780;

  /// True when the app is being shown in the tablet panel.
  static bool isTablet(BuildContext context) => MediaQuery.sizeOf(context).width >= breakpoint;

  /// Columns for tile grids: 2 on phones, 4 once the panel is wide enough.
  static int tileColumns(BuildContext context) => MediaQuery.sizeOf(context).width >= 640 ? 4 : 2;
}

class AdaptiveFrame extends StatelessWidget {
  const AdaptiveFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < Adaptive.breakpoint) return child;
      final dark = Theme.of(context).brightness == Brightness.dark;
      final width = constraints.maxWidth < Adaptive.panelMaxWidth ? constraints.maxWidth : Adaptive.panelMaxWidth;
      final mq = MediaQuery.of(context);
      return Center(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: (dark ? Colors.black : const Color(0xFF0B3A66)).withValues(alpha: dark ? 0.55 : 0.18),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRect(
            child: MediaQuery(
              data: mq.copyWith(size: Size(width, mq.size.height)),
              child: ColoredBox(
                color: dark ? AppTokens.darkBackground : AppTokens.surfaceSubtle,
                child: child,
              ),
            ),
          ),
        ),
      );
    });
  }
}
