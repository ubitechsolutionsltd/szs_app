import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:simulizi/app_state.dart';
import 'package:simulizi/components/language_select_a_lrt_dialog_widget.dart';
import 'package:simulizi/components/logout_alrt_dialog_widget.dart';
import 'package:simulizi/components/package_payment_success_widget.dart';
import 'package:simulizi/custom_code/ui/app_components.dart';
import 'package:simulizi/custom_code/ui/episode_unlock.dart';
import 'package:simulizi/custom_code/ui/app_theme.dart';
import 'package:simulizi/custom_code/widgets/library_view.dart';
import 'package:simulizi/custom_code/widgets/settings_view.dart';
import 'package:simulizi/flutter_flow/internationalization.dart';

/// Layout QA: every screen below is pumped on small and large phones, in light and dark, with the system text
/// scaled up to 200%, and fails on any overflow or build exception.
const _sizes = [Size(320, 568), Size(360, 640), Size(411, 891)];
const _scales = [1.0, 1.5, 2.0];

Widget _app(Widget child, ThemeData theme, double scale) => ChangeNotifierProvider<FFAppState>.value(
      value: FFAppState(),
      child: MaterialApp(
        theme: theme,
        localizationsDelegates: const [FFLocalizationsDelegate()],
        supportedLocales: const [Locale('sw'), Locale('en')],
        builder: (context, c) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
          child: c!,
        ),
        home: Scaffold(body: child),
      ),
    );

void main() {
  final screens = <String, Widget Function()>{
    'settings (guest)': () => const SettingsView(),
    'library (guest)': () => const LibraryView(),
    'logout dialog': () => const LogoutAlrtDialogWidget(onTapLogout: null),
    'language dialog': () => const LanguageSelectALrtDialogWidget(),
    'locked episode card': () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: LockedEpisodeCard(episode: {'id': 1, 'is_audio_coin': 300, 'is_buy': 0}),
        ),
    'payment card': () => const PackagePaymentSuccessWidget(amount: '200.0', lipanumber: '83816242', paymentlink: 'https://example.com/pay'),
    'empty state': () => const EmptyState(
          icon: Icons.favorite_border_rounded,
          title: 'Hakuna ulizohifadhi',
          message: 'Tafuta na hifadhi simulizi pendwa ili uzipate hapa kwa haraka.',
          actionLabel: 'Tafuta simulizi',
          onAction: _noop,
        ),
    'faq': () => ListView(children: const [
          FaqCard(question: 'Nawezaje kushiriki simulizi ninazozipenda na marafiki zangu?', answer: 'Tumia kitufe cha “Shirikisha” kwenye ukurasa wa simulizi.', initiallyOpen: true),
        ]),
    'story rows': () => ListView(children: const [
          StoryCard(title: 'Kichwa kirefu sana cha hadithi kinachopita mistari miwili au mitatu kabisa', author: 'Mwandishi Mwenye Jina Refu Sana', compact: true, listens: 1234),
          StoryCard(title: 'SHANTA', author: 'George Mosenya'),
        ]),
    'category tiles': () => GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.8,
          children: const [
            CategoryTile(label: 'Kutisha', icon: Icons.theater_comedy),
            CategoryTile(label: 'Simulizi za upelelezi', icon: Icons.search),
          ],
        ),
  };

  for (final size in _sizes) {
    for (final scale in _scales) {
      for (final dark in [false, true]) {
        for (final e in screens.entries) {
          testWidgets('${e.key} @ ${size.width.toInt()}x${size.height.toInt()} text ${scale}x ${dark ? 'dark' : 'light'}', (tester) async {
            tester.view.physicalSize = size * 3;
            tester.view.devicePixelRatio = 3;
            addTearDown(tester.view.reset);
            final errors = <String>[];
            final previous = FlutterError.onError;
            FlutterError.onError = (d) {
              final text = d.toString();
              final i = text.indexOf('relevant error-causing widget was');
              final culprit = i < 0 ? '' : text.substring(i, (i + 200).clamp(0, text.length)).replaceAll('\n', ' ');
              errors.add('${d.exceptionAsString().split('\n').first} <- $culprit');
            };
            await tester.pumpWidget(_app(e.value(), dark ? AppTheme.dark : AppTheme.light, scale));
            await tester.pump(const Duration(milliseconds: 400));
            FlutterError.onError = previous;
            expect(errors, isEmpty);
          });
        }
      }
    }
  }
}

void _noop() {}
