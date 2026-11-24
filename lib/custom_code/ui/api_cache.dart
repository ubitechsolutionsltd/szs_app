import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A cached list and how old it is.
class CachedList {
  const CachedList(this.items, this.age);

  final List<dynamic> items;
  final Duration age;
}

/// Small on-device cache for lists that rarely change (categories, authors, trending stories).
///
/// Reading is synchronous once [init] has run at start-up, so screens can paint cached content on their very first
/// frame, with no loading flash, and keep working without a network.
class ApiCache {
  ApiCache._();

  static const _prefix = 'szs.cache.';
  static SharedPreferences? _prefs;

  /// How long cached data is used without asking the server again.
  static const Duration freshFor = Duration(hours: 24);

  /// Cached data older than this is dropped instead of being shown.
  static const Duration maxStale = Duration(days: 14);

  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint('ApiCache unavailable: $e');
    }
  }

  static CachedList? read(String key) {
    try {
      final raw = _prefs?.getString('$_prefix$key');
      if (raw == null) return null;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final at = DateTime.fromMillisecondsSinceEpoch((map['at'] as num).toInt());
      final age = DateTime.now().difference(at);
      if (age > maxStale) return null;
      final items = (map['items'] as List).toList();
      return CachedList(items, age.isNegative ? Duration.zero : age);
    } catch (_) {
      return null;
    }
  }

  static Future<void> write(String key, List<dynamic> items) async {
    try {
      await _prefs?.setString('$_prefix$key', jsonEncode({'at': DateTime.now().millisecondsSinceEpoch, 'items': items}));
    } catch (_) {}
  }
}
