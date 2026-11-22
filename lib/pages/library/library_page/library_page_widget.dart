import '/custom_code/widgets/index.dart' as custom_widgets;
import '/backend/api_requests/api_calls.dart';
import '/components/balance_component_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/no_song_playlist_comp_widget.dart';
import '/components/package_lists_component_widget.dart';
import '/components/play_list_container_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'library_page_model.dart';
export 'library_page_model.dart';

class LibraryPageWidget extends StatefulWidget {
  const LibraryPageWidget({super.key});

  static String routeName = 'LibraryPage';
  static String routePath = '/libraryPage';

  @override
  State<LibraryPageWidget> createState() => _LibraryPageWidgetState();
}

class _LibraryPageWidgetState extends State<LibraryPageWidget>
    with TickerProviderStateMixin {
  late LibraryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LibraryPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 16.0, 20.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'jgolgzzs' /* Maktaba */,
                              ),
                              maxLines: 1,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(HomeSearchPageWidget.routeName);
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.search,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 24.0),
                    child: Container(
                      width: double.infinity,
                      height: 130.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
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
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        Duration(milliseconds: 500),
                                    imageUrl: FFAppState().userphoto,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, stackTrace) =>
                                        Image.asset(
                                      'assets/images/error_image.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFAppState().username,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .gray,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                        Text(
                                          FFAppState().fullname,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 7.0)),
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.balanceComponentModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BalanceComponentWidget(),
                                ),
                              ],
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                useSafeArea: true,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.75,
                                          child: PackageListsComponentWidget(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            text: FFLocalizations.of(context).getText(
                              'iaf3iuiz' /* Jaza Kibubu */,
                            ),
                            icon: Icon(
                              Icons.add_card,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.85,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconAlignment: IconAlignment.end,
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0),
                          child: TabBar(
                            labelColor: FlutterFlowTheme.of(context).primary,
                            unselectedLabelColor:
                                FlutterFlowTheme.of(context).gray,
                            labelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                            unselectedLabelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            indicatorColor:
                                FlutterFlowTheme.of(context).primary,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            tabs: [
                              Tab(
                                text: FFLocalizations.of(context).getText(
                                  'dbv0tfqw' /* Uzipendazo */,
                                ),
                              ),
                              Tab(
                                text: FFLocalizations.of(context).getText(
                                  'utdfpwic' /* Ulizopakua */,
                                ),
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              [() async {}, () async {}][i]();
                            },
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _model.tabBarController,
                            children: [
                              ListView(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  24.0,
                                  0,
                                  24.0,
                                ),
                                scrollDirection: Axis.vertical,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 16.0, 20.0, 24.0),
                                    child: FutureBuilder<ApiCallResponse>(
                                      future:
                                          GeneralGroup.getBookMarksCall.call(
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
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final wrapGetBookMarksResponse =
                                            snapshot.data!;

                                        return Builder(
                                          builder: (context) {
                                            final bookMarks =
                                                GeneralGroup.getBookMarksCall
                                                        .result(
                                                          wrapGetBookMarksResponse
                                                              .jsonBody,
                                                        )
                                                        ?.toList() ??
                                                    [];
                                            if (bookMarks.isEmpty) {
                                              return NoSongPlaylistCompWidget();
                                            }

                                            return Wrap(
                                              spacing: 16.0,
                                              runSpacing: 16.0,
                                              alignment: WrapAlignment.start,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.start,
                                              direction: Axis.horizontal,
                                              runAlignment: WrapAlignment.start,
                                              verticalDirection:
                                                  VerticalDirection.down,
                                              clipBehavior: Clip.none,
                                              children: List.generate(
                                                  bookMarks.length,
                                                  (bookMarksIndex) {
                                                final bookMarksItem =
                                                    bookMarks[bookMarksIndex];
                                                return wrapWithModel(
                                                  model: _model
                                                      .playListOntainerModels
                                                      .getModel(
                                                    StoryStruct.maybeFromMap(
                                                            bookMarksItem)!
                                                        .id
                                                        .toString(),
                                                    bookMarksIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child:
                                                      PlayListContainerWidget(
                                                    key: Key(
                                                      'Keyf2u_${StoryStruct.maybeFromMap(bookMarksItem)!.id.toString()}',
                                                    ),
                                                    story: StoryStruct
                                                        .maybeFromMap(
                                                            bookMarksItem)!,
                                                  ),
                                                );
                                              }),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              custom_widgets.DownloadsList(),
                            ],
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
