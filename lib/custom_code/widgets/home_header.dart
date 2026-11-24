// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';

import '/app_state.dart';
import '/custom_code/ui/app_palette.dart';
import '/index.dart';

/// Greeting row for the home page: the user's avatar, a time-of-day greeting and the notifications bell.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.width, this.height});

  final double? width;
  final double? height;

  static String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Habari za asubuhi';
    if (hour < 17) return 'Habari za mchana';
    return 'Habari za jioni';
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final appState = FFAppState();
    final fullName = appState.fullname.trim();
    final firstName = fullName.isEmpty ? '' : fullName.split(' ').first;
    final photo = appState.userphoto;

    Widget avatar = Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: palette.accent, shape: BoxShape.circle),
      child: Text(
        firstName.isEmpty ? 'S' : firstName[0].toUpperCase(),
        style: TextStyle(fontFamily: 'SF Pro Display', color: palette.onAccent, fontWeight: FontWeight.w800, fontSize: 20),
      ),
    );
    if (photo.isNotEmpty) {
      final fallbackAvatar = avatar;
      avatar = ClipOval(
        child: CachedNetworkImage(
          imageUrl: photo,
          width: 46,
          height: 46,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => fallbackAvatar,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          InkWell(
            customBorder: const CircleBorder(),
            onTap: () => context.pushNamed(MyProfilePageWidget.routeName),
            child: avatar,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting(),
                  style: theme.bodySmall.override(
                      fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 13, letterSpacing: 0),
                ),
                Text(
                  firstName.isEmpty ? 'Karibu' : firstName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.text,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          if (!appState.skipUser)
            Material(
              color: palette.surface,
              shape: CircleBorder(side: BorderSide(color: palette.outline, width: 0.5)),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => context.pushNamed(NotificationPageWidget.routeName),
                child: SizedBox(
                  width: 46,
                  height: 46,
                  child: Icon(Icons.notifications_none_rounded, color: palette.text, size: 24),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
