import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';

/// Design tokens for the custom widgets, read from the FlutterFlow theme.
///
/// This app uses the theme "inverted": `primaryBackground` is the dark page, `secondary` is the card surface,
/// and `tertiary` is the main (light) text colour, with `gray` for muted text. This class gives those their
/// real meaning so widgets never reach for the wrong token.
class AppPalette {
  AppPalette._(this.theme);

  factory AppPalette.of(BuildContext context) =>
      AppPalette._(FlutterFlowTheme.of(context));

  final FlutterFlowTheme theme;

  Color get background => theme.primaryBackground;
  Color get surface => theme.secondary;

  /// A step above [surface]: chips, inputs, pressed states.
  Color get surfaceHigh => Color.lerp(theme.secondary, theme.tertiary, 0.08)!;

  /// Hairlines, borders and inactive tracks.
  Color get outline => Color.lerp(theme.secondary, theme.tertiary, 0.16)!;

  Color get text => theme.tertiary;
  Color get muted => theme.gray;
  Color get accent => theme.primary;

  /// Text and icons placed on [accent].
  Color get onAccent => theme.primaryText;
  Color get warning => theme.warning;
  Color get error => theme.error;
}

/// Spacing and radius scale shared by the custom widgets.
class AppSpace {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double radiusSm = 10;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
}
