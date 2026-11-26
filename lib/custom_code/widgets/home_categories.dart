// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/backend/api_requests/api_calls.dart';
import '/custom_code/ui/adaptive.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/index.dart';

/// Home category grid: colourful 2-column tiles (first four categories). Loads its own data, with skeleton,
/// empty and error states.
class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key, this.width, this.height});

  final double? width;
  final double? height;

  static Future<List<dynamic>> _load() async {
    final response = await GeneralGroup.categoriesCall.call();
    if (!response.succeeded) throw Exception('categories');
    return GeneralGroup.categoriesCall.result(response.jsonBody)?.toList() ?? [];
  }

  static SliverGridDelegate _grid(BuildContext context) => SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Adaptive.tileColumns(context),
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        mainAxisExtent: 84,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AsyncSection(
        cacheKey: 'categories',
        load: _load,
        loading: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: _grid(context),
          itemCount: Adaptive.tileColumns(context),
          itemBuilder: (_, __) => const SkeletonBox(radius: 22),
        ),
        empty: StateMessage(icon: Icons.category_outlined, message: trs('no_categories')),
        builder: (context, categories) {
          final visible = categories.take(Adaptive.tileColumns(context)).toList();
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: _grid(context),
            itemCount: visible.length,
            itemBuilder: (context, index) {
              final category = visible[index];
              final name = getJsonField(category, r'''$.name''')?.toString() ?? '';
              return CategoryTile(
                label: name,
                icon: categoryIconFor(name),
                imageUrl: getJsonField(category, r'''$.image''')?.toString(),
                index: index,
                onTap: () => context.pushNamed(
                  SubCatListPageWidget.routeName,
                  queryParameters: {
                    'title': serializeParam(name, ParamType.String),
                    'catId': serializeParam(getJsonField(category, r'''$.id''').toString(), ParamType.String),
                    'index': serializeParam(getJsonField(category, r'''$.id'''), ParamType.int),
                  }.withoutNulls,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
