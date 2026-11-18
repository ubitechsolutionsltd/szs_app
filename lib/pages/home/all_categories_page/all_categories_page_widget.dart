import '/backend/api_requests/api_calls.dart';
import '/components/cat_container_three_widget.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'all_categories_page_model.dart';
export 'all_categories_page_model.dart';

class AllCategoriesPageWidget extends StatefulWidget {
  const AllCategoriesPageWidget({super.key});

  static String routeName = 'AllCategoriesPage';
  static String routePath = '/allCategoriesPage';

  @override
  State<AllCategoriesPageWidget> createState() =>
      _AllCategoriesPageWidgetState();
}

class _AllCategoriesPageWidgetState extends State<AllCategoriesPageWidget>
    with TickerProviderStateMixin {
  late AllCategoriesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllCategoriesPageModel());

    animationsMap.addAll({
      'catContainerThreeOnPageLoadAnimation': AnimationInfo(
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: 'Makundi',
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
                      child: FutureBuilder<ApiCallResponse>(
                        future: GeneralGroup.categoriesCall.call(),
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
                          final wrapCategoriesResponse = snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final allcategories = GeneralGroup.categoriesCall
                                      .result(
                                        wrapCategoriesResponse.jsonBody,
                                      )
                                      ?.toList() ??
                                  [];

                              return Wrap(
                                spacing: 16.0,
                                runSpacing: 16.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.start,
                                verticalDirection: VerticalDirection.down,
                                clipBehavior: Clip.none,
                                children: List.generate(allcategories.length,
                                    (allcategoriesIndex) {
                                  final allcategoriesItem =
                                      allcategories[allcategoriesIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        SubCatListPageWidget.routeName,
                                        queryParameters: {
                                          'title': serializeParam(
                                            getJsonField(
                                              allcategoriesItem,
                                              r'''$.name''',
                                            ).toString(),
                                            ParamType.String,
                                          ),
                                          'index': serializeParam(
                                            getJsonField(
                                              allcategoriesItem,
                                              r'''$.id''',
                                            ),
                                            ParamType.int,
                                          ),
                                          'catId': serializeParam(
                                            getJsonField(
                                              allcategoriesItem,
                                              r'''$.id''',
                                            ).toString(),
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.catContainerThreeModels
                                          .getModel(
                                        getJsonField(
                                          allcategoriesItem,
                                          r'''$.id''',
                                        ).toString(),
                                        allcategoriesIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: CatContainerThreeWidget(
                                        key: Key(
                                          'Keyxkf_${getJsonField(
                                            allcategoriesItem,
                                            r'''$.id''',
                                          ).toString()}',
                                        ),
                                        title: getJsonField(
                                          allcategoriesItem,
                                          r'''$.name''',
                                        ).toString(),
                                        id: getJsonField(
                                          allcategoriesItem,
                                          r'''$.id''',
                                        ),
                                        image: getJsonField(
                                          allcategoriesItem,
                                          r'''$.image''',
                                        ).toString(),
                                      ),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'catContainerThreeOnPageLoadAnimation']!);
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
        ),
      ),
    );
  }
}
