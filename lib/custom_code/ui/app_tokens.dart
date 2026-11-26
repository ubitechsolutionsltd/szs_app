import 'package:flutter/material.dart';

/// Central design tokens for Simulizi za Sauti (blue-and-white brand).
///
/// Source of truth: the UI package `design_tokens.json`. The brand blue is the exact colour sampled from the
/// real logo (#0071BD) rather than the package's approximation (#0876C9).
///
/// Everything visual (the [FlutterFlowTheme] colours, `AppTheme`, `AppPalette` and the shared components) reads
/// from here, so a brand change is a one-file edit.
class AppTokens {
  AppTokens._();

  // ── Brand colours ──────────────────────────────────────────────────────────────────────────────────────────
  static const Color brandPrimary = Color(0xFF0071BD);
  static const Color brandDeep = Color(0xFF07549A);
  static const Color brandNavy = Color(0xFF10264A);
  static const Color brandSky = Color(0xFFD9EEFF);
  static const Color brandPale = Color(0xFFEEF7FF);

  // ── Light surfaces & text ──────────────────────────────────────────────────────────────────────────────────
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF5FAFF);
  static const Color textPrimary = Color(0xFF10213A);
  static const Color textSecondary = Color(0xFF66788F);
  static const Color border = Color(0xFFD8E5F1);

  // ── Dark surfaces & text ───────────────────────────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0A1424);
  static const Color darkSurface = Color(0xFF13213A);
  static const Color darkSurfaceHigh = Color(0xFF1B2D4C);
  static const Color darkText = Color(0xFFEAF1FA);
  static const Color darkTextSecondary = Color(0xFF9AAEC9);
  static const Color darkBorder = Color(0xFF253A5E);
  static const Color darkAccent = Color(0xFF3B9BF0);

  // ── Coins (sarafu): sky-to-brand blue, so money never introduces an off-theme colour ──────────────────────────
  static const Color coinLight = Color(0xFF3FB4FF);
  static const List<Color> coinGradient = [coinLight, brandPrimary];

  // ── Status ─────────────────────────────────────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF1EAA70);
  static const Color warning = Color(0xFFE7A33E);
  static const Color error = Color(0xFFE5484D);

  // ── Category accents (used for tiles, never for brand surfaces) ────────────────────────────────────────────
  static const List<Color> categoryGreen = [Color(0xFF0E8F6B), Color(0xFF056B4F)];
  static const List<Color> categoryPurple = [Color(0xFF7C4DDB), Color(0xFF5A32B4)];
  static const List<Color> categoryOrange = [Color(0xFFEE9B1F), Color(0xFFC77607)];
  static const List<Color> categoryPink = [Color(0xFFEF5B93), Color(0xFFD13A76)];
  static const List<List<Color>> categoryGradients = [
    categoryGreen,
    categoryPurple,
    categoryOrange,
    categoryPink,
    [Color(0xFF0071BD), Color(0xFF07549A)],
    [Color(0xFF00A6B4), Color(0xFF007A87)],
  ];

  // ── Shape ──────────────────────────────────────────────────────────────────────────────────────────────────
  static const double radiusCard = 22;
  static const double radiusInput = 16;
  static const double radiusButton = 18;
  static const double radiusPill = 999;

  // ── Spacing (8dp scale) ────────────────────────────────────────────────────────────────────────────────────
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;

  /// Horizontal screen padding (design spec: 20–24dp).
  static const double screenPadding = 20;

  /// Minimum touch target (design spec: 44–48dp).
  static const double minTouch = 48;
  static const double buttonHeight = 52;

  // ── Typography ─────────────────────────────────────────────────────────────────────────────────────────────
  /// Bundled font (works offline). Change this one constant to swap the app's typeface.
  static const String fontFamily = 'SF Pro Display';

  static const double fsScreenTitle = 30;
  static const double fsSectionTitle = 22;
  static const double fsCardTitle = 16;
  static const double fsBody = 15;
  static const double fsCaption = 12;

  // ── Elevation ──────────────────────────────────────────────────────────────────────────────────────────────
  /// Restrained, blue-tinted shadow for cards.
  static List<BoxShadow> cardShadow(bool dark) => [
        BoxShadow(
          color: (dark ? Colors.black : const Color(0xFF0B3A66)).withValues(alpha: dark ? 0.35 : 0.08),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ];

  static const Duration fast = Duration(milliseconds: 160);
  static const Duration medium = Duration(milliseconds: 280);
}
