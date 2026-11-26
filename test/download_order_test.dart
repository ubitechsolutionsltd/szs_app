import 'package:flutter_test/flutter_test.dart';
import 'package:simulizi/custom_code/player/download_manager.dart';

void main() {
  test('natural order puts Sehemu ya 2 before Sehemu ya 10', () {
    final names = ['Sehemu ya 10', 'Sehemu ya 02', 'Sehemu ya 1', 'Sehemu ya 3'];
    names.sort(naturalCompare);
    expect(names, ['Sehemu ya 1', 'Sehemu ya 02', 'Sehemu ya 3', 'Sehemu ya 10']);
  });
}
