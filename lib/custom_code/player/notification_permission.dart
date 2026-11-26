import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Asks Android 13+ for the notification permission, once per app run, so the playback notification and the
/// lock-screen controls are allowed to show. Does nothing on other platforms; never throws.
class NotificationPermission {
  NotificationPermission._();

  static const _channel = MethodChannel('szs/notifications');
  static bool _asked = false;

  static Future<void> ensure() async {
    if (_asked || kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    _asked = true;
    try {
      await _channel.invokeMethod<bool>('requestPermission');
    } catch (e) {
      debugPrint('Notification permission request failed: $e');
    }
  }
}
