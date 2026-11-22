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

import '/app_state.dart';
import '/backend/api_requests/api_calls.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/index.dart';

/// Horizontal rail of authors (round photos) for the home page.
class HomeAuthors extends StatelessWidget {
  const HomeAuthors({super.key, this.width, this.height});

  final double? width;
  final double? height;

  static Future<List<dynamic>> _load() async {
    final response = await GeneralGroup.artistListCall.call(userId: FFAppState().userid);
    if (!response.succeeded) throw Exception('authors');
    return GeneralGroup.artistListCall.result(response.jsonBody)?.toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);

    return SizedBox(
      width: width,
      height: height ?? 128,
      child: AsyncSection(
        load: _load,
        loading: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 5,
          separatorBuilder: (_, __) => const SizedBox(width: 18),
          itemBuilder: (_, __) => Column(children: const [
            SkeletonBox(width: 76, height: 76, circle: true),
            SizedBox(height: 10),
            SkeletonBox(width: 60, height: 12, radius: 6),
          ]),
        ),
        builder: (context, authors) => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: authors.length,
          separatorBuilder: (_, __) => const SizedBox(width: 18),
          itemBuilder: (context, index) {
            final author = authors[index];
            final userName = getJsonField(author, r'''$.user_name''')?.toString() ?? '';
            final photo = getJsonField(author, r'''$.image''')?.toString() ?? '';

            return InkWell(
              borderRadius: BorderRadius.circular(AppSpace.radiusMd),
              onTap: () => context.pushNamed(
                ViewAlbumPageWidget.routeName,
                queryParameters: {
                  'artistid': serializeParam(getJsonField(author, r'''$.id''').toString(), ParamType.String),
                  'type': serializeParam('1', ParamType.String),
                  'artistName': serializeParam(userName, ParamType.String),
                }.withoutNulls,
              ),
              child: SizedBox(
                width: 80,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: palette.accent, width: 2)),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: photo,
                        width: 68,
                        height: 68,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(width: 68, height: 68, color: palette.surfaceHigh),
                        errorWidget: (_, __, ___) => Container(
                          width: 68,
                          height: 68,
                          color: palette.surfaceHigh,
                          child: Icon(Icons.person_rounded, color: palette.muted, size: 34),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: palette.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
