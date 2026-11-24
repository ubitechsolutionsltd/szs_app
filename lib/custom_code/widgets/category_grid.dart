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
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/index.dart';

/// "Browse all" grid: big gradient category tiles with tilted cover art.
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, this.width, this.height});

  final double? width;
  final double? height;

  static const _gradients = <List<Color>>[
    [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
    [Color(0xFF7C2D12), Color(0xFFF97316)],
    [Color(0xFF14532D), Color(0xFF22C55E)],
    [Color(0xFF581C87), Color(0xFFA855F7)],
    [Color(0xFF831843), Color(0xFFEC4899)],
    [Color(0xFF134E4A), Color(0xFF14B8A6)],
    [Color(0xFF7F1D1D), Color(0xFFEF4444)],
    [Color(0xFF713F12), Color(0xFFEAB308)],
  ];

  static Future<List<dynamic>> _load() async {
    final response = await GeneralGroup.categoriesCall.call();
    if (!response.succeeded) throw Exception('categories');
    return GeneralGroup.categoriesCall.result(response.jsonBody)?.toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);

    return SizedBox(
      width: width,
      child: AsyncSection(
        cacheKey: 'categories',
        load: _load,
        loading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.7,
            children: List.generate(
                6, (_) => const SkeletonBox(radius: AppSpace.radiusMd)),
          ),
        ),
        builder: (context, categories) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              mainAxisExtent: 84,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              final name = getJsonField(category, r'''$.name''')?.toString() ?? '';
              final id = int.tryParse(getJsonField(category, r'''$.id''')?.toString() ?? '') ?? index;
              return CategoryTile(
                label: name,
                icon: categoryIconFor(name),
                imageUrl: getJsonField(category, r'''$.image''')?.toString(),
                index: id.abs(),
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
          ),
        ),
      ),
    );
  }
}
