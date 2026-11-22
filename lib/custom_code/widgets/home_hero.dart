// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import '/components/song_container_widget.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/custom_code/ui/home_data.dart';

/// Auto-advancing carousel of featured story banners for the top of the home page.
class HomeHero extends StatefulWidget {
  const HomeHero({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  State<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends State<HomeHero> {
  final PageController _controller = PageController(viewportFraction: 0.92);
  Timer? _timer;
  int _page = 0;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _count < 2 || !_controller.hasClients) return;
      _controller.animateToPage((_page + 1) % _count,
          duration: const Duration(milliseconds: 450), curve: Curves.easeOutCubic);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final height = widget.height ?? 210.0;

    return SizedBox(
      width: widget.width,
      child: AsyncSection(
        load: HomeData.trending,
        loading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SkeletonBox(height: height, radius: AppSpace.radiusLg),
        ),
        errorMessage: 'Imeshindikana kupakia simulizi. Angalia mtandao wako.',
        builder: (context, stories) {
          final featured = stories.take(5).toList();
          _count = featured.length;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: featured.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, index) {
                    final story = StoryStruct.maybeFromMap(featured[index]);
                    if (story == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: SongContainerWidget(
                        key: Key('home_hero_${story.id}'),
                        story: story,
                        variant: 'banner',
                      ),
                    );
                  },
                ),
              ),
              if (featured.length > 1) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < featured.length; i++)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: i == _page ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: i == _page ? palette.accent : palette.outline,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
