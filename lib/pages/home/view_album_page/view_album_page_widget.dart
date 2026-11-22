import '/backend/api_requests/api_calls.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'view_album_page_model.dart';
export 'view_album_page_model.dart';

class ViewAlbumPageWidget extends StatefulWidget {
  const ViewAlbumPageWidget({
    super.key,
    this.artistid,
    this.type,
    this.artistName,
  });

  final String? artistid;
  final String? type;
  final String? artistName;

  static String routeName = 'ViewAlbumPage';
  static String routePath = '/viewAlbumPage';

  @override
  State<ViewAlbumPageWidget> createState() => _ViewAlbumPageWidgetState();
}

class _ViewAlbumPageWidgetState extends State<ViewAlbumPageWidget>
    with TickerProviderStateMixin {
  late ViewAlbumPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewAlbumPageModel());

    animationsMap.addAll({
      'wrapOnPageLoadAnimation': AnimationInfo(
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
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
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
                      title: widget.artistName,
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
                            future: GeneralGroup.artistContentsCall.call(
                              artistId: widget.artistid,
                              type: widget.type,
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
                              final wrapArtistContentsResponse = snapshot.data!;

                              return Builder(
                                builder: (context) {
                                  final albums = GeneralGroup.artistContentsCall
                                          .result(
                                            wrapArtistContentsResponse.jsonBody,
                                          )
                                          ?.toList() ??
                                      [];

                                  return Wrap(
                                    spacing: 0.0,
                                    runSpacing: 0.0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: List.generate(albums.length,
                                        (albumsIndex) {
                                      final albumsItem = albums[albumsIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          var _shouldSetState = false;
                                          FFAppState().isLoading = true;
                                          FFAppState().update(() {});
                                          _model.storyEpisodesResp =
                                              await GeneralGroup
                                                  .episodesAudioByContentCall
                                                  .call(
                                            contentId: StoryStruct.maybeFromMap(
                                                    albumsItem)
                                                ?.id
                                                .toString(),
                                          );

                                          _shouldSetState = true;
                                          FFAppState().isLoading = false;
                                          FFAppState().update(() {});
                                          if ((_model.storyEpisodesResp
                                                  ?.succeeded ??
                                              true)) {
                                            context.pushNamed(
                                              StoryDetailsPageWidget.routeName,
                                              queryParameters: {
                                                'story': serializeParam(
                                                  StoryStruct.maybeFromMap(
                                                      albumsItem),
                                                  ParamType.DataStruct,
                                                ),
                                                'episodes': serializeParam(
                                                  getJsonField(
                                                    (_model.storyEpisodesResp
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.result''',
                                                  ),
                                                  ParamType.JSON,
                                                ),
                                              }.withoutNulls,
                                            );

                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          } else {
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                        },
                                        child: Container(
                                          width: () {
                                            if (MediaQuery.sizeOf(context)
                                                    .width <
                                                kBreakpointSmall) {
                                              return ((MediaQuery.sizeOf(
                                                              context)
                                                          .width -
                                                      40) *
                                                  1 /
                                                  1);
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointMedium) {
                                              return ((MediaQuery.sizeOf(
                                                              context)
                                                          .width -
                                                      56) *
                                                  1 /
                                                  2);
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointLarge) {
                                              return ((MediaQuery.sizeOf(
                                                              context)
                                                          .width -
                                                      88) *
                                                  1 /
                                                  4);
                                            } else {
                                              return ((MediaQuery.sizeOf(
                                                              context)
                                                          .width -
                                                      88) *
                                                  1 /
                                                  4);
                                            }
                                          }(),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondary,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 12.0, 16.0, 12.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 56.0,
                                                  height: 56.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    imageUrl: getJsonField(
                                                      albumsItem,
                                                      r'''$.portrait_img''',
                                                    ).toString(),
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/error_image.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                getJsonField(
                                                                  albumsItem,
                                                                  r'''$.title''',
                                                                ).toString(),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SF Pro Display',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .tertiary,
                                                                      fontSize:
                                                                          18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                getJsonField(
                                                                  albumsItem,
                                                                  r'''$.category_name''',
                                                                ).toString(),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SF Pro Display',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .gray,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 2.0)),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    albumsItem,
                                                    r'''$.total_episode''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation']!);
                                    }),
                                  ).animateOnPageLoad(animationsMap[
                                      'wrapOnPageLoadAnimation']!);
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
