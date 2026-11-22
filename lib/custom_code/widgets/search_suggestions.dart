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

import '/backend/api_requests/api_calls.dart';
import '/components/song_container_widget.dart';
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
        const SectionHeader(title: 'Chunguza kwa kundi'),
        const SizedBox(height: 12),
        AsyncSection(
          load: _categories,
          loading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonBox(height: 44, radius: 22),
          ),
          builder: (context, categories) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final category in categories)
                  Material(
                    color: palette.surface,
                    shape: StadiumBorder(side: BorderSide(color: palette.outline, width: 0.6)),
                    child: InkWell(
                      customBorder: const StadiumBorder(),
                      onTap: () => context.pushNamed(
                        SubCatListPageWidget.routeName,
                        queryParameters: {
                          'title': serializeParam(getJsonField(category, r'''$.name''')?.toString() ?? '', ParamType.String),
                          'catId': serializeParam(getJsonField(category, r'''$.id''').toString(), ParamType.String),
                          'index': serializeParam(getJsonField(category, r'''$.id'''), ParamType.int),
                        }.withoutNulls,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: getJsonField(category, r'''$.image''')?.toString() ?? '',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(
                                width: 30,
                                height: 30,
                                color: palette.surfaceHigh,
                                child: Icon(Icons.category_rounded, size: 15, color: palette.muted),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(getJsonField(category, r'''$.name''')?.toString() ?? '',
                              style: theme.bodyMedium.override(
                                  fontFamily: 'SF Pro Display',
                                  color: palette.text,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0)),
                        ]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        const SectionHeader(title: 'Zinazopendwa'),
        const SizedBox(height: 12),
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
