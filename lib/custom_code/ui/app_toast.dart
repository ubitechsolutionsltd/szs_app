import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'app_palette.dart';

enum ToastType { success, error, info }

/// A polished floating toast — rounded glass card, status icon, and an accent
/// edge — used in place of the plain default [SnackBar] across the app.
class AppToast {
  AppToast._();

  static void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.info,
    Duration duration = const Duration(milliseconds: 3200),
  }) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);

    final Color accent;
    final IconData icon;
    switch (type) {
      case ToastType.success:
        accent = const Color(0xFF34C759);
        icon = Icons.check_circle_rounded;
      case ToastType.error:
        accent = palette.error;
        icon = Icons.error_rounded;
      case ToastType.info:
        accent = palette.accent;
        icon = Icons.info_rounded;
    }

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        content: Container(
          decoration: BoxDecoration(
            color: palette.solid,
            borderRadius: BorderRadius.circular(16),
            border: Border(left: BorderSide(color: accent, width: 4)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.22), blurRadius: 18, offset: const Offset(0, 8)),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(14, 13, 16, 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: accent, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.text,
                    fontSize: 14.5,
                    lineHeight: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void success(BuildContext context, String message) => show(context, message, type: ToastType.success);
  static void error(BuildContext context, String message) => show(context, message, type: ToastType.error);
  static void info(BuildContext context, String message) => show(context, message, type: ToastType.info);
}
