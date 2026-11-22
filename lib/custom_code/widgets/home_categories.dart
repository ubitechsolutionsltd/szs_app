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
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/index.dart';

/// Horizontal category pills for the home page. Loads its own data, with skeleton / error states.
class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key, this.width, this.height});

  final double? width;
  final double? height;

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
      height: height ?? 52,
      child: AsyncSection(
        load: _load,
        loading: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 4,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, __) => const SkeletonBox(width: 110, height: 44, radius: 22),
        ),
        builder: (context, categories) => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final category = categories[index];
            final name = getJsonField(category, r'''$.name''')?.toString() ?? '';
            final image = getJsonField(category, r'''$.image''')?.toString() ?? '';

            return Material(
              color: palette.surface,
              shape: StadiumBorder(side: BorderSide(color: palette.outline, width: 0.5)),
              child: InkWell(
                customBorder: const StadiumBorder(),
                onTap: () => context.pushNamed(
                  SubCatListPageWidget.routeName,
                  queryParameters: {
                    'title': serializeParam(name, ParamType.String),
                    'catId': serializeParam(getJsonField(category, r'''$.id''').toString(), ParamType.String),
                    'index': serializeParam(getJsonField(category, r'''$.id'''), ParamType.int),
                  }.withoutNulls,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: image,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(width: 32, height: 32, color: palette.surfaceHigh),
                        errorWidget: (_, __, ___) => Container(
                          width: 32,
                          height: 32,
                          color: palette.surfaceHigh,
                          child: Icon(Icons.category_rounded, size: 16, color: palette.muted),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      name,
                      style: theme.bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        color: palette.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
