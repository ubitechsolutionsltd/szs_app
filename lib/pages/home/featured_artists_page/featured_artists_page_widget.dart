import '/backend/api_requests/api_calls.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/artist_container_comp/artist_container_comp_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'featured_artists_page_model.dart';
export 'featured_artists_page_model.dart';

class FeaturedArtistsPageWidget extends StatefulWidget {
  const FeaturedArtistsPageWidget({super.key});

  static String routeName = 'FeaturedArtistsPage';
  static String routePath = '/featuredArtistsPage';

  @override
  State<FeaturedArtistsPageWidget> createState() =>
      _FeaturedArtistsPageWidgetState();
}

class _FeaturedArtistsPageWidgetState extends State<FeaturedArtistsPageWidget>
    with TickerProviderStateMixin {
  late FeaturedArtistsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeaturedArtistsPageModel());

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
                  title: trs('kwqsy6cx'),
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
                        future: GeneralGroup.artistListCall.call(
                          userId: FFAppState().userid,
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
                          final wrapArtistListResponse = snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final artists = GeneralGroup.artistListCall
                                      .result(
                                        wrapArtistListResponse.jsonBody,
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
                                children: List.generate(artists.length,
                                    (artistsIndex) {
                                  final artistsItem = artists[artistsIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        ViewAlbumPageWidget.routeName,
                                        queryParameters: {
                                          'artistid': serializeParam(
                                            getJsonField(
                                              artistsItem,
                                              r'''$.id''',
                                            ).toString(),
                                            ParamType.String,
                                          ),
                                          'type': serializeParam(
                                            '1',
                                            ParamType.String,
                                          ),
                                          'artistName': serializeParam(
                                            getJsonField(
                                              artistsItem,
                                              r'''$.user_name''',
                                            ).toString(),
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.artistContainerCompModels
                                          .getModel(
                                        getJsonField(
                                          artistsItem,
                                          r'''$.id''',
                                        ).toString(),
                                        artistsIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: ArtistContainerCompWidget(
                                        key: Key(
                                          'Keyqiw_${getJsonField(
                                            artistsItem,
                                            r'''$.id''',
                                          ).toString()}',
                                        ),
                                        artistPhoto: getJsonField(
                                          artistsItem,
                                          r'''$.image''',
                                        ).toString(),
                                        artistName: getJsonField(
                                          artistsItem,
                                          r'''$.user_name''',
                                        ).toString(),
                                        bio: getJsonField(
                                          artistsItem,
                                          r'''$.bio''',
                                        ).toString(),
                                        isfollow: getJsonField(
                                          artistsItem,
                                          r'''$.is_follow''',
                                        ).toString(),
                                        id: getJsonField(
                                          artistsItem,
                                          r'''$.id''',
                                        ),
                                      ),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'artistContainerCompOnPageLoadAnimation']!);
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
