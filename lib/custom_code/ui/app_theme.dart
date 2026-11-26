import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// Builds the app-wide [ThemeData] from [AppTokens], so stock Material widgets (inputs, buttons, sheets,
/// dialogs, sliders, nav bar…) match the blue-and-white brand without per-screen styling.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final accent = dark ? AppTokens.darkAccent : AppTokens.brandPrimary;
    final background = dark ? AppTokens.darkBackground : AppTokens.brandPale;
    final surface = dark ? AppTokens.darkSurface : AppTokens.surface;
    final text = dark ? AppTokens.darkText : AppTokens.textPrimary;
    final muted = dark ? AppTokens.darkTextSecondary : AppTokens.textSecondary;
    final border = dark ? AppTokens.darkBorder : AppTokens.border;

    final scheme = ColorScheme.fromSeed(
      seedColor: AppTokens.brandPrimary,
      brightness: brightness,
    ).copyWith(
      primary: accent,
      onPrimary: dark ? const Color(0xFF04182B) : Colors.white,
      secondary: AppTokens.brandDeep,
      surface: surface,
      onSurface: text,
      onSurfaceVariant: muted,
      outline: border,
      outlineVariant: border,
      error: AppTokens.error,
      surfaceTint: Colors.transparent,
    );

    final inputBorder = (Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusInput),
          borderSide: BorderSide(color: c, width: w),
        );

    return ThemeData(
      brightness: brightness,
      useMaterial3: false,
      fontFamily: AppTokens.fontFamily,
      colorScheme: scheme,
      primaryColor: accent,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      cardColor: surface,
      dividerColor: border,
      splashFactory: InkRipple.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(AppTokens.buttonHeight),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTokens.radiusButton)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          minimumSize: const Size.fromHeight(AppTokens.buttonHeight),
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTokens.radiusButton)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          minimumSize: const Size(AppTokens.minTouch, AppTokens.minTouch),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: TextStyle(color: muted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: inputBorder(border),
        enabledBorder: inputBorder(border),
        focusedBorder: inputBorder(accent, 1.6),
        errorBorder: inputBorder(AppTokens.error),
        focusedErrorBorder: inputBorder(AppTokens.error, 1.6),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTokens.radiusCard)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: dark ? AppTokens.darkSurfaceHigh : AppTokens.brandNavy,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: accent,
        inactiveTrackColor: accent.withValues(alpha: 0.22),
        thumbColor: accent,
        overlayColor: accent.withValues(alpha: 0.14),
        trackHeight: 4,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: accent),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? accent : border,
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
    );
  }
}
