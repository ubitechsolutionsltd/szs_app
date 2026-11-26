import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simulizi/custom_code/ui/api_cache.dart';
import 'package:simulizi/custom_code/ui/app_widgets.dart';
import 'package:simulizi/custom_code/ui/offline_art.dart';

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child)));

Widget _section({required Future<List<dynamic>> Function() load, String key = 'test_list'}) => AsyncSection(
      cacheKey: key,
      load: load,
      loading: const SkeletonBox(height: 40),
      builder: (context, items) => Column(children: [for (final i in items) Text('item:$i')]),
    );

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ApiCache.init();
  });

  testWidgets('first visit: skeleton, then data, and the data is cached', (tester) async {
    await tester.pumpWidget(_host(_section(load: () async => ['a', 'b'])));
    expect(find.byType(SkeletonBox), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('item:a'), findsOneWidget);
    expect(ApiCache.read('test_list')?.items, ['a', 'b']);
  });

  testWidgets('cached data is shown on the first frame and no request is made while fresh', (tester) async {
    await ApiCache.write('test_list', ['cached']);
    var calls = 0;
    await tester.pumpWidget(_host(_section(load: () async {
      calls++;
      return ['network'];
    })));
    expect(find.text('item:cached'), findsOneWidget); // painted immediately, no skeleton
    expect(find.byType(SkeletonBox), findsNothing);
    await tester.pump(const Duration(milliseconds: 400));
    expect(calls, 0);
  });

  testWidgets('first visit with no network shows the offline illustration and retry works', (tester) async {
    var online = false;
    await tester.pumpWidget(_host(_section(load: () async {
      if (!online) throw Exception('offline');
      return ['back'];
    })));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(OfflineArt), findsOneWidget);
    online = true;
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('item:back'), findsOneWidget);
  });

  test('cache entries older than the maximum age are ignored', () async {
    SharedPreferences.setMockInitialValues({
      'szs.cache.old': '{"at": ${DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch}, "items": ["x"]}',
    });
    await ApiCache.init();
    expect(ApiCache.read('old'), isNull);
  });
}
