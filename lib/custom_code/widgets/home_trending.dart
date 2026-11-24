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
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/home_data.dart';
import '/custom_code/ui/app_widgets.dart';

/// Horizontal rail of portrait story cards (trending stories) for the home page.
class HomeTrending extends StatelessWidget {
  const HomeTrending({super.key, this.width, this.height});

  final double? width;
  final double? height;

  static Future<List<dynamic>> _load() => HomeData.trending();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 274,
      child: AsyncSection(
        load: _load,
        empty: const StateMessage(icon: Icons.headphones_rounded, message: 'Hakuna simulizi za kuonyesha kwa sasa.'),
        loading: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (_, __) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            SkeletonBox(width: 152, height: 200, radius: AppSpace.radiusMd),
            SizedBox(height: 10),
            SkeletonBox(width: 120, height: 14, radius: 6),
            SizedBox(height: 6),
            SkeletonBox(width: 80, height: 12, radius: 6),
          ]),
        ),
        builder: (context, stories) {
          final visible = stories.take(10).toList();
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: visible.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final story = StoryStruct.maybeFromMap(visible[index]);
              if (story == null) return const SizedBox.shrink();
              return SongContainerWidget(
                key: Key('home_trending_${story.id}'),
                story: story,
                variant: 'card',
              );
            },
          );
        },
      ),
    );
  }
}
