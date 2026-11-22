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
import '/custom_code/ui/theme_mode_store.dart';
import '/index.dart';

/// Top of the Settings screen: the user's profile card and the light / dark / system theme switch.
class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final state = FFAppState();
    final name = state.fullname.trim();

    Widget avatar = Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: palette.accent, shape: BoxShape.circle),
      child: Text(name.isEmpty ? 'S' : name[0].toUpperCase(),
          style: TextStyle(fontFamily: 'SF Pro Display', color: palette.onAccent, fontSize: 26, fontWeight: FontWeight.w800)),
    );
    if (state.userphoto.isNotEmpty) {
      avatar = ClipOval(
        child: CachedNetworkImage(
          imageUrl: state.userphoto,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => avatar,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!state.skipUser)
            Material(
              color: palette.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpace.radiusMd),
                side: BorderSide(color: palette.outline, width: 0.6),
              ),
              child: InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpace.radiusMd)),
                onTap: () => context.pushNamed(MyProfilePageWidget.routeName),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(children: [
                    avatar,
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(name.isEmpty ? 'Mgeni' : name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.bodyMedium.override(
                                fontFamily: 'SF Pro Display',
                                color: palette.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2)),
                        if (state.email.isNotEmpty)
                          Text(state.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.bodySmall.override(
                                  fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 13, letterSpacing: 0)),
                      ]),
                    ),
                    Icon(Icons.chevron_right_rounded, color: palette.muted),
                  ]),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text('Mandhari',
              style: theme.bodyMedium.override(
                  fontFamily: 'SF Pro Display',
                  color: palette.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0)),
          const SizedBox(height: 10),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeModeStore.notifier,
            builder: (context, mode, _) {
              Widget option(ThemeMode value, IconData icon, String label) {
                final selected = mode == value;
                return Expanded(
                  child: Material(
                    color: selected ? palette.accent : palette.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: selected ? palette.accent : palette.outline, width: 0.8),
                    ),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      onTap: () => ThemeModeStore.save(value),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Icon(icon, size: 22, color: selected ? palette.onAccent : palette.muted),
                          const SizedBox(height: 4),
                          Text(label,
                              style: theme.bodySmall.override(
                                  fontFamily: 'SF Pro Display',
                                  color: selected ? palette.onAccent : palette.text,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0)),
                        ]),
                      ),
                    ),
                  ),
                );
              }

              return Row(children: [
                option(ThemeMode.light, Icons.light_mode_rounded, 'Mwanga'),
                const SizedBox(width: 10),
                option(ThemeMode.dark, Icons.dark_mode_rounded, 'Giza'),
                const SizedBox(width: 10),
                option(ThemeMode.system, Icons.phone_iphone_rounded, 'Mfumo'),
              ]);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
