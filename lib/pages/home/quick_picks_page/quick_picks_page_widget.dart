import '/backend/api_requests/api_calls.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/song_container_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'quick_picks_page_model.dart';
export 'quick_picks_page_model.dart';

class QuickPicksPageWidget extends StatefulWidget {
  const QuickPicksPageWidget({super.key});

  static String routeName = 'QuickPicksPage';
  static String routePath = '/quickPicksPage';

  @override
  State<QuickPicksPageWidget> createState() => _QuickPicksPageWidgetState();
}

class _QuickPicksPageWidgetState extends State<QuickPicksPageWidget>
    with TickerProviderStateMixin {
  late QuickPicksPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuickPicksPageModel());

    animationsMap.addAll({
      'songContainerOnPageLoadAnimation': AnimationInfo(
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
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  wrapWithModel(
                    model: _model.customCenterAppBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: CustomCenterAppBarWidget(
                      title: trs('awke62tg'),
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
                              20.0, 16.0, 20.0, 16.0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: GeneralGroup.trendingsCall.call(
                              categoryId: '1',
                              type: '1',
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final wrapTrendingsResponse = snapshot.data!;

                              return Builder(
                                builder: (context) {
                                  final trendings = GeneralGroup.trendingsCall
                                          .result(
                                            wrapTrendingsResponse.jsonBody,
                                          )
                                          ?.toList() ??
                                      [];

                                  return Wrap(
                                    spacing: 16.0,
                                    runSpacing: 16.0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: List.generate(trendings.length,
                                        (trendingsIndex) {
                                      final trendingsItem =
                                          trendings[trendingsIndex];
                                      return wrapWithModel(
                                        model:
                                            _model.songContainerModels.getModel(
                                          StoryStruct.maybeFromMap(
                                                  trendingsItem)!
                                              .id
                                              .toString(),
                                          trendingsIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SongContainerWidget(
                                          key: Key(
                                            'Keyl3j_${StoryStruct.maybeFromMap(trendingsItem)!.id.toString()}',
                                          ),
                                          story: StoryStruct.maybeFromMap(
                                              trendingsItem)!,
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'songContainerOnPageLoadAnimation']!);
                                    }),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (FFAppState().isLoading)
                wrapWithModel(
                  model: _model.customLoadingIndicatorModel,
                  updateCallback: () => safeSetState(() {}),
                  child: CustomLoadingIndicatorWidget(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
