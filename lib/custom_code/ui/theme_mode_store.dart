import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Remembers the user's light / dark / system choice. Light is the default until someone changes it.
class ThemeModeStore {
  static const _key = 'szs_theme_mode';

  static ThemeMode current = ThemeMode.light;

  /// The app listens to this and rebuilds when the choice changes.
  static final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

  static Future<void> init() async {
    try {
      final saved = (await SharedPreferences.getInstance()).getString(_key);
      current = _parse(saved);
      notifier.value = current;
    } catch (_) {
      current = ThemeMode.light;
    }
  }

  static Future<void> save(ThemeMode mode) async {
    current = mode;
    notifier.value = mode;
    try {
      await (await SharedPreferences.getInstance()).setString(_key, mode.name);
    } catch (_) {}
  }

  static ThemeMode _parse(String? value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}
