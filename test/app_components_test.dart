import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simulizi/custom_code/ui/app_components.dart';
import 'package:simulizi/custom_code/ui/app_theme.dart';

Widget _host(Widget child, ThemeData theme) => MaterialApp(
      theme: theme,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );

void main() {
  for (final entry in {'light': AppTheme.light, 'dark': AppTheme.dark}.entries) {
    testWidgets('components render and react in ${entry.key} theme at 320dp wide', (tester) async {
      tester.view.physicalSize = const Size(320 * 3, 800 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      var taps = 0;
      var tab = 0;
      await tester.pumpWidget(_host(
        StatefulBuilder(
          builder: (context, setState) => Column(children: [
            GradientHeader(
              title: 'Maktaba',
              bottom: PillTabs(
                  labels: const ['Saliyo lako', 'Vilivyokuliwa'],
                  selected: tab,
                  onChanged: (i) => setState(() => tab = i),
                  onGradient: true),
            ),
            AppButton(label: 'Ingia', onPressed: () => taps++),
            const AppButton(label: 'Imezimwa', onPressed: null),
            AppButton(label: 'Pili', onPressed: () {}, kind: AppButtonKind.secondary),
            AppTextField(controller: TextEditingController(), hint: 'Nenosiri', icon: Icons.lock_outline, obscure: true),
            StoryCard(
                title: 'Kichwa kirefu sana cha hadithi kinachopita mstari',
                author: 'Mwandishi',
                compact: true,
                listens: 22,
                onTap: () {}),
            const StoryCard(title: 'SHANTA', author: 'George Mosenya', category: 'Mapenzi'),
            const CategoryTile(label: 'Kutisha', icon: Icons.theater_comedy),
            const EmptyState(icon: Icons.search_off, title: 'Hakuna matokeo', message: 'Jaribu neno lingine'),
            ErrorState(onRetry: () {}),
            AppBottomNav(
              currentIndex: 0,
              onSelected: (_) {},
              items: const [
                AppNavItem(label: 'Mwanzo', icon: Icons.home_outlined, selectedIcon: Icons.home),
                AppNavItem(label: 'Tafuta', icon: Icons.search, selectedIcon: Icons.search),
                AppNavItem(label: 'Maktaba', icon: Icons.library_music_outlined, selectedIcon: Icons.library_music),
                AppNavItem(label: 'Mipangilio', icon: Icons.settings_outlined, selectedIcon: Icons.settings),
              ],
            ),
          ]),
        ),
        entry.value,
      ));

      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Ingia'));
      expect(taps, 1);
      await tester.tap(find.text('Vilivyokuliwa'));
      await tester.pump();
      expect(tab, 1);
      expect(tester.takeException(), isNull);
    });
  }
}
