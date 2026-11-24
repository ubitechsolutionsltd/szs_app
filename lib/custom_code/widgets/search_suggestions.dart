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
import '/components/song_container_widget.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/custom_code/ui/home_data.dart';
import '/index.dart';

/// Start page of Search, before anyone has typed: categories to explore and a few popular stories.
class SearchSuggestions extends StatelessWidget {
  const SearchSuggestions({super.key, this.width, this.height});

  final double? width;
  final double? height;

  static Future<List<dynamic>> _categories() async {
    final response = await GeneralGroup.categoriesCall.call();
    if (!response.succeeded) throw Exception('categories');
    return GeneralGroup.categoriesCall.result(response.jsonBody)?.toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Makundi maarufu'),
        const SizedBox(height: 14),
        AsyncSection(
          load: _categories,
          loading: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, mainAxisExtent: 84),
            itemCount: 4,
            itemBuilder: (_, __) => const SkeletonBox(radius: 22),
          ),
          builder: (context, categories) {
            final visible = categories.take(6).toList();
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, mainAxisExtent: 84),
              itemCount: visible.length,
              itemBuilder: (context, index) {
                final category = visible[index];
                final name = getJsonField(category, r'''$.name''')?.toString() ?? '';
                return CategoryTile(
                  label: name,
                  icon: categoryIconFor(name),
                  index: index + 4,
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
        const SizedBox(height: 28),
        const SectionHeader(title: 'Zinazopendwa'),
        const SizedBox(height: 14),
        AsyncSection(
          load: HomeData.trending,
          loading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonBox(height: 84, radius: AppSpace.radiusMd),
          ),
          builder: (context, stories) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                for (final raw in stories.take(5))
                  if (StoryStruct.maybeFromMap(raw) != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SongContainerWidget(
                        key: Key('search_suggest_${StoryStruct.maybeFromMap(raw)!.id}'),
                        story: StoryStruct.maybeFromMap(raw),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
