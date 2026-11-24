// Compiles the whole app (catches errors the analyzer can miss, e.g. non-constant expressions).
import 'package:flutter_test/flutter_test.dart';
import 'package:simulizi/main.dart' as app;

void main() {
  test('app compiles', () {
    expect(app.MyApp, isNotNull);
  });
}
