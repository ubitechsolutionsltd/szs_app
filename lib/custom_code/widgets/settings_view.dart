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
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '/backend/api_requests/api_calls.dart';
import '/components/language_select_a_lrt_dialog_widget.dart';
import '/components/logout_alrt_dialog_widget.dart';
import '/custom_code/player/audio_handler.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/theme_mode_store.dart';
import '/index.dart';

/// The Mipangilio tab: blue header, profile (or guest) card, light / dark / system theme choice and the
/// list of settings (security, about, language, help, feedback) with log in / log out at the bottom.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  bool get _loggedIn => FFAppState().isLogin;

  Future<void> _pickLanguage(BuildContext context) => showDialog(
        context: context,
        builder: (dialogContext) => Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: WebViewAware(child: LanguageSelectALrtDialogWidget()),
        ),
      );

  Future<void> _confirmLogout(BuildContext context) => showDialog(
        context: context,
        builder: (dialogContext) => Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: WebViewAware(
            child: LogoutAlrtDialogWidget(
              onTapLogout: () async {
                await GeneralGroup.logoutCall.call();
                FFAppState().authToken = '';
                FFAppState().isLogin = false;
                Navigator.pop(context);
                context.goNamed(LoginPageWidget.routeName);
              },
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final dark = Theme.of(context).brightness == Brightness.dark;
    final text = dark ? AppTokens.darkText : AppTokens.textPrimary;
    final muted = dark ? AppTokens.darkTextSecondary : AppTokens.textSecondary;

    return Column(children: [
      GradientHeader(title: trs('e46mrzzy')),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 20, AppTokens.screenPadding, 28),
          children: [
            _ProfileCard(loggedIn: _loggedIn),
            const SizedBox(height: 24),
            Text(trs('theme'),
                style: TextStyle(fontFamily: AppTokens.fontFamily, color: text, fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            const _ThemePicker(),
            const SizedBox(height: 24),
            if (_loggedIn)
              _Row(
                icon: Icons.lock_outline_rounded,
                label: trs('f3kfj34i'),
                onTap: () => context.pushNamed(SecurityPageWidget.routeName),
              ),
            _Row(
              icon: Icons.info_outline_rounded,
              label: trs('4l2dbb28'),
              onTap: () => context.pushNamed(AboutUsPageWidget.routeName),
            ),
            _Row(
              icon: Icons.translate_rounded,
              label: trs('1jig2hkn'),
              value: trs('current_language'),
              onTap: () => _pickLanguage(context),
            ),
            _Row(
              icon: Icons.help_outline_rounded,
              label: trs('adni9znu'),
              onTap: () => context.pushNamed(HelpPageWidget.routeName),
            ),
            _Row(
              icon: Icons.chat_bubble_outline_rounded,
              label: trs('jpp0w391'),
              onTap: () => context.pushNamed(FeedbackPageWidget.routeName),
            ),
            const SizedBox(height: 12),
            if (_loggedIn)
              _Row(
                icon: Icons.logout_rounded,
                label: trs('x2z78gev'),
                danger: true,
                onTap: () => _confirmLogout(context),
              )
            else
              AppButton(label: trs('gdn2b1x7'), icon: Icons.login_rounded, onPressed: () => context.pushNamed(LoginPageWidget.routeName)),
            const SizedBox(height: 16),
            if (BackgroundAudio.lastError != null) ...[
              // Shown only when the lock-screen / notification player could not start, so it can be reported.
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Media controls: ${BackgroundAudio.lastError}',
                    textAlign: TextAlign.center, maxLines: 4, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 11)),
              ),
            ],
            Center(
              child: Text('Simulizi za Sauti · ${trs('about_tagline')}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 12.5)),
            ),
          ],
        ),
      ),
    ]);
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.loggedIn});

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final text = dark ? AppTokens.darkText : AppTokens.textPrimary;
    final muted = dark ? AppTokens.darkTextSecondary : AppTokens.textSecondary;
    final state = FFAppState();
    final name = state.fullname.trim();
    final accent = dark ? AppTokens.darkAccent : AppTokens.brandPrimary;

    Widget avatar = Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [Color(0xFF1189DA), AppTokens.brandDeep]),
      ),
      child: Text(name.isEmpty ? 'S' : name[0].toUpperCase(),
          style: const TextStyle(fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
    );
    if (loggedIn && state.userphoto.isNotEmpty) {
      final fallback = avatar;
      avatar = ClipOval(
        child: CachedNetworkImage(
          imageUrl: state.userphoto,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => fallback,
        ),
      );
    }

    return Semantics(
      button: true,
      label: loggedIn ? (name.isEmpty ? trs('guest') : name) : trs('guest_login_hint'),
      child: Material(
        color: dark ? AppTokens.darkSurface : AppTokens.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          onTap: () => context.pushNamed(loggedIn ? MyProfilePageWidget.routeName : LoginPageWidget.routeName),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              border: Border.all(color: dark ? AppTokens.darkBorder : AppTokens.border),
              boxShadow: AppTokens.cardShadow(dark),
            ),
            child: Row(children: [
              avatar,
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(loggedIn ? (name.isEmpty ? trs('guest') : name) : trs('guest'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: AppTokens.fontFamily, color: text, fontSize: 19, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(loggedIn ? state.email : trs('guest_login_hint'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 13)),
                ]),
              ),
              Icon(Icons.chevron_right_rounded, color: accent, size: 28),
            ]),
          ),
        ),
      ),
    );
  }
}

class _ThemePicker extends StatelessWidget {
  const _ThemePicker();

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final text = dark ? AppTokens.darkText : AppTokens.textPrimary;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeModeStore.notifier,
      builder: (context, mode, _) {
        Widget option(ThemeMode value, IconData icon, String label) {
          final selected = mode == value;
          return Expanded(
            child: Semantics(
              button: true,
              selected: selected,
              label: label,
              child: GestureDetector(
                onTap: () => ThemeModeStore.save(value),
                child: AnimatedContainer(
                  duration: AppTokens.fast,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTokens.radiusInput + 2),
                    gradient: selected
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF1189DA), AppTokens.brandDeep],
                          )
                        : null,
                    color: selected ? null : (dark ? AppTokens.darkSurface : AppTokens.surface),
                    border: Border.all(color: selected ? Colors.transparent : (dark ? AppTokens.darkBorder : AppTokens.border)),
                    boxShadow: selected
                        ? [BoxShadow(color: AppTokens.brandPrimary.withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 6))]
                        : AppTokens.cardShadow(dark),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(icon, size: 28, color: selected ? Colors.white : (dark ? AppTokens.darkAccent : AppTokens.brandDeep)),
                    const SizedBox(height: 6),
                    Text(label,
                        style: TextStyle(
                            fontFamily: AppTokens.fontFamily,
                            color: selected ? Colors.white : text,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                  ]),
                ),
              ),
            ),
          );
        }

        return Row(children: [
          option(ThemeMode.light, Icons.wb_sunny_rounded, trs('theme_light')),
          const SizedBox(width: 10),
          option(ThemeMode.dark, Icons.nightlight_round, trs('theme_dark')),
          const SizedBox(width: 10),
          option(ThemeMode.system, Icons.phone_iphone_rounded, trs('theme_system')),
        ]);
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.label, required this.onTap, this.value, this.danger = false});

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final text = danger ? AppTokens.error : (dark ? AppTokens.darkText : AppTokens.textPrimary);
    final muted = dark ? AppTokens.darkTextSecondary : AppTokens.textSecondary;
    final iconColor = danger ? AppTokens.error : (dark ? AppTokens.darkAccent : AppTokens.brandDeep);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        button: true,
        label: label,
        child: Material(
          color: dark ? AppTokens.darkSurface : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.radiusInput + 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppTokens.radiusInput + 2),
            onTap: onTap,
            child: Container(
              constraints: const BoxConstraints(minHeight: 60),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTokens.radiusInput + 2),
                border: Border.all(color: dark ? AppTokens.darkBorder : AppTokens.border),
                boxShadow: AppTokens.cardShadow(dark),
              ),
              child: Row(children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor.withValues(alpha: 0.12)),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(label,
                      style: TextStyle(fontFamily: AppTokens.fontFamily, color: text, fontSize: 16.5, fontWeight: FontWeight.w700)),
                ),
                if (value != null) ...[
                  Text(value!, style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 14)),
                  const SizedBox(width: 6),
                ],
                if (!danger) Icon(Icons.chevron_right_rounded, color: muted),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
