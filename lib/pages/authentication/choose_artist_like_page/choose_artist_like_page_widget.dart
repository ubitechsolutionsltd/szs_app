import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'choose_artist_like_page_model.dart';
export 'choose_artist_like_page_model.dart';

class ChooseArtistLikePageWidget extends StatefulWidget {
  const ChooseArtistLikePageWidget({super.key});

  static String routeName = 'ChooseArtistLikePage';
  static String routePath = '/chooseArtistLikePage';

  @override
  State<ChooseArtistLikePageWidget> createState() =>
      _ChooseArtistLikePageWidgetState();
}

class _ChooseArtistLikePageWidgetState extends State<ChooseArtistLikePageWidget>
    with TickerProviderStateMixin {
  late ChooseArtistLikePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseArtistLikePageModel());

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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 18.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().isInfo = true;
                          safeSetState(() {});

                          context.goNamed(HomePageWidget.routeName);
                        },
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'wsf2z5m5' /* Skip */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'z8ymq7ag' /* Choose artists you like. */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 28.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                lineHeight: 1.5,
                              ),
                        ),
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'pgvdccls' /* Your experience will improve t... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SF Pro Display',
                              color: FlutterFlowTheme.of(context).gray,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.5,
                            ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 32.0, 16.0, 24.0),
                        child: Builder(
                          builder: (context) {
                            final selectArList =
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
                              children: List.generate(selectArList.length,
                                  (selectArListIndex) {
                                final selectArListItem =
                                    selectArList[selectArListIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (_model.likedArtist
                                            .contains(selectArListItem.id) ==
                                        false) {
                                      _model.addToLikedArtist(
                                          selectArListItem.id);
                                      safeSetState(() {});
                                      FFAppState().updateUserInfoStruct(
                                        (e) => e
                                          ..updateLikeArtist(
                                            (e) => e.add(selectArListItem),
                                          ),
                                      );
                                      FFAppState().update(() {});
                                    } else {
                                      _model.removeFromLikedArtist(
                                          selectArListItem.id);
                                      safeSetState(() {});
                                      FFAppState().updateUserInfoStruct(
                                        (e) => e
                                          ..updateLikeArtist(
                                            (e) => e.remove(selectArListItem),
                                          ),
                                      );
                                      FFAppState().update(() {});
                                    }
                                  },
                                  child: Container(
                                    width: () {
                                      if (MediaQuery.sizeOf(context).width <
                                          kBreakpointSmall) {
                                        return ((MediaQuery.sizeOf(context)
                                                    .width -
                                                72) *
                                            1 /
                                            3);
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointMedium) {
                                        return ((MediaQuery.sizeOf(context)
                                                    .width -
                                                120) *
                                            1 /
                                            6);
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointLarge) {
                                        return ((MediaQuery.sizeOf(context)
                                                    .width -
                                                168) *
                                            1 /
                                            9);
                                      } else {
                                        return ((MediaQuery.sizeOf(context)
                                                    .width -
                                                168) *
                                            1 /
                                            9);
                                      }
                                    }(),
                                    height: 137.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondary,
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: _model.likedArtist.contains(
                                                    selectArListItem.id) ==
                                                true
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .borderColor,
                                        width: _model.likedArtist.contains(
                                                selectArListItem.id)
                                            ? 2.0
                                            : 0.8,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    width: 72.0,
                                                    height: 72.0,
                                                    padding: EdgeInsets.all(2.5),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: _model.likedArtist.contains(selectArListItem.id)
                                                            ? FlutterFlowTheme.of(context).primary
                                                            : FlutterFlowTheme.of(context).borderColor,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: ClipOval(child: Image.network(
                                                  valueOrDefault<String>(
                                                    selectArListItem.img,
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ucvqe2zikw23/a1.png',
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                                  ),
                                                  if (_model.likedArtist.contains(selectArListItem.id))
                                                    Positioned(
                                                      right: -2.0,
                                                      bottom: -2.0,
                                                      child: Container(
                                                        width: 24.0,
                                                        height: 24.0,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primary,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Icon(Icons.check_rounded, color: Colors.white, size: 16.0),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  valueOrDefault<String>(
                                                    selectArListItem.name,
                                                    'Byron Akins',
                                                  ).maybeHandleOverflow(
                                                    maxChars: 24,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  minFontSize: 12.0,
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
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.0,
                                                        lineHeight: 1.5,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 8.0)),
                                      ),
                                    ),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'containerOnPageLoadAnimation']!);
                              }),
                            ).animateOnPageLoad(
                                animationsMap['wrapOnPageLoadAnimation']!);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 24.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      FFAppState().isInfo = true;
                      safeSetState(() {});
                      if (_model.likedArtist.isNotEmpty) {
                        context.goNamed(HomePageWidget.routeName);
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select artist',
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }
                    },
                    text: FFLocalizations.of(context).getText(
                      'eoloksn6' /* Done */,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 54.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'SF Pro Display',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w700,
                            lineHeight: 1.2,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    showLoadingIndicator: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
