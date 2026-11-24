import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/artist_container_comp/artist_container_comp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'similar_artist_page_model.dart';
export 'similar_artist_page_model.dart';

class SimilarArtistPageWidget extends StatefulWidget {
  const SimilarArtistPageWidget({super.key});

  static String routeName = 'SimilarArtistPage';
  static String routePath = '/similarArtistPage';

  @override
  State<SimilarArtistPageWidget> createState() =>
      _SimilarArtistPageWidgetState();
}

class _SimilarArtistPageWidgetState extends State<SimilarArtistPageWidget>
    with TickerProviderStateMixin {
  late SimilarArtistPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SimilarArtistPageModel());

    animationsMap.addAll({
      'artistContainerCompOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: trs('similar_authors'),
                  backIcon: false,
                  addIcon: false,
                  onTapAdd: () async {},
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 16.0, 20.0, 24.0),
                      child: Builder(
                        builder: (context) {
                          final similarArList =
                              FFAppState().chooseArList.toList();

                          return Wrap(
                            spacing: 16.0,
                            runSpacing: 16.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: List.generate(similarArList.length,
                                (similarArListIndex) {
                              final similarArListItem =
                                  similarArList[similarArListIndex];
                              return wrapWithModel(
                                model:
                                    _model.artistContainerCompModels.getModel(
                                  similarArListItem.id.toString(),
                                  similarArListIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: ArtistContainerCompWidget(
                                  key: Key(
                                    'Keyuzy_${similarArListItem.id.toString()}',
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'artistContainerCompOnPageLoadAnimation']!);
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
