import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:simulizi/flutter_flow/internationalization.dart';

void main() {
  test('every translation has Swahili and English text', () {
    final empty = <String>[];
    kTranslationsMap.forEach((key, value) {
      for (final lang in FFLocalizations.languages()) {
        if ((value[lang] ?? '').trim().isEmpty) empty.add('$key[$lang]');
      }
    });
    expect(empty, isEmpty, reason: 'Missing translations: $empty');
  });

  test('every key used in the code exists in the table', () {
    final used = <String, String>{};
    final pattern = RegExp(r"""(?:getText\(\s*|trs\(\s*|\.tr\(\s*)'([A-Za-z0-9_]+)'""");
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      if (!file.path.endsWith('.dart') || file.path.endsWith('internationalization.dart')) continue;
      for (final match in pattern.allMatches(file.readAsStringSync())) {
        used.putIfAbsent(match.group(1)!, () => file.path);
      }
    }
    final missing = used.entries.where((e) => !kTranslationsMap.containsKey(e.key)).map((e) => '${e.key} (${e.value})');
    expect(missing, isEmpty, reason: 'Keys used but not translated: $missing');
  });

  test('English differs from Swahili for real sentences', () {
    // Short words/names may legitimately match (Google, Kiswahili, SELCOM...), sentences must not.
    final same = kTranslationsMap.entries
        .where((e) => e.value['sw'] == e.value['en'] && e.value['sw']!.split(' ').length > 3)
        .map((e) => e.key);
    expect(same, isEmpty, reason: 'Untranslated sentences: $same');
  });

  test('placeholders are replaced and languages switch', () {
    expect(FFLocalizations.translate('minutes_n', args: {'n': '15'}), anyOf('Dakika 15', '15 minutes'));
  });
}
