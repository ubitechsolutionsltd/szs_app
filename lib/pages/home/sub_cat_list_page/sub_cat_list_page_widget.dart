import '/custom_code/widgets/index.dart' as custom_widgets;
import '/backend/api_requests/api_calls.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/no_result_found_comp_widget.dart';
import '/components/song_container_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'sub_cat_list_page_model.dart';
export 'sub_cat_list_page_model.dart';

class SubCatListPageWidget extends StatefulWidget {
  const SubCatListPageWidget({
    super.key,
    String? title,
    int? index,
    this.catId,
  })  : this.title = title ?? 'Hip hop',
        this.index = index ?? 0;

  final String title;
  final int index;
  final String? catId;

  static String routeName = 'SubCatListPage';
  static String routePath = '/subCatListPage';

  @override
  State<SubCatListPageWidget> createState() => _SubCatListPageWidgetState();
}

class _SubCatListPageWidgetState extends State<SubCatListPageWidget>
    with TickerProviderStateMixin {
  late SubCatListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubCatListPageModel());

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
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
                    model: _model.customCenterAppBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: CustomCenterAppBarWidget(
                      title: valueOrDefault<String>(
                        widget.title,
                        'Title',
                      ),
                      backIcon: false,
                      addIcon: false,
                      onTapAdd: () async {},
                    ),
                  ),
              custom_widgets.CategoryHero(
                title: widget.title,
                categoryId: widget.index,
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
                            future: GeneralGroup.contentsByCategoryCall.call(
                              categoryId: widget.catId,
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
                              final wrapContentsByCategoryResponse =
                                  snapshot.data!;

                              return Builder(
                                builder: (context) {
                                  final content =
                                      GeneralGroup.contentsByCategoryCall
                                              .result(
                                                wrapContentsByCategoryResponse
                                                    .jsonBody,
                                              )
                                              ?.toList() ??
                                          [];
                                  if (content.isEmpty) {
                                    return NoResultFoundCompWidget();
                                  }

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
                                    children: List.generate(content.length,
                                        (contentIndex) {
                                      final contentItem = content[contentIndex];
                                      return wrapWithModel(
                                        model:
                                            _model.songContainerModels.getModel(
                                          StoryStruct.maybeFromMap(contentItem)!
                                              .id
                                              .toString(),
                                          contentIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SongContainerWidget(
                                          key: Key(
                                            'Keyryd_${StoryStruct.maybeFromMap(contentItem)!.id.toString()}',
                                          ),
                                          story: StoryStruct.maybeFromMap(
                                              contentItem)!,
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
