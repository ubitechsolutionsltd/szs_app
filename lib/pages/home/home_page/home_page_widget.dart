import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/auth/firebase_auth/auth_util.dart';
import '/components/currently_playing_story_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, -20.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, -20.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'rowOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'rowOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'rowOnPageLoadAnimation3': AnimationInfo(
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
      'artistContainerCompOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'lplgi0st' /* Karibu  */,
                                ),
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
                              if (!FFAppState().skipUser)
                                Text(
                                  FFAppState().fullname,
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        lineHeight: 1.5,
                                      ),
                                ),
                            ],
                          ).animateOnPageLoad(
                              animationsMap['columnOnPageLoadAnimation']!),
                        ),
                        if (!FFAppState().skipUser)
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context
                                  .pushNamed(NotificationPageWidget.routeName);
                            },
                            child: Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF161616),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: SvgPicture.asset(
                                  'assets/images/notification_white_ic.svg',
                                  fit: BoxFit.contain,
                                  alignment: Alignment(0.0, 0.0),
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation1']!),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(HomeSearchPageWidget.routeName);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: AppPalette.of(context).outline,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              13.0, 13.0, 16.0, 13.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.search,
                                color: FlutterFlowTheme.of(context).gray,
                                size: 24.0,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'lgb4aznq' /* Tafuta */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SF Pro Display',
                                          color:
                                              FlutterFlowTheme.of(context).gray,
                                          fontSize: 17.0,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation2']!),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        12.0,
                        0,
                        24.0,
                      ),
                      scrollDirection: Axis.vertical,
                      children: [
                        SectionHeader(
            title: FFLocalizations.of(context).getText(
              'tuwluj0n' /* Makundi */,
            ),
            actionLabel: FFLocalizations.of(context).getText(
              '61tzl2pc' /* Tazama zaidi */,
            ),
            onAction: () =>
                context.pushNamed(AllCategoriesPageWidget.routeName),
          ),
          SizedBox(height: 14.0),
          custom_widgets.HomeCategories(),
          SizedBox(height: 28.0),
          SectionHeader(
            title: FFLocalizations.of(context).getText(
              'awke62tg' /* Zinazobamba */,
            ),
            actionLabel: FFLocalizations.of(context).getText(
              'kz1r6p5g' /* Tazama zaidi */,
            ),
            onAction: () => context.pushNamed(QuickPicksPageWidget.routeName),
          ),
          SizedBox(height: 14.0),
          custom_widgets.HomeTrending(),
          SizedBox(height: 20.0),
          SectionHeader(
            title: FFLocalizations.of(context).getText(
              'kwqsy6cx' /* Waandishi */,
            ),
            actionLabel: FFLocalizations.of(context).getText(
              'x44p14fp' /* Tazama zaidi */,
            ),
            onAction: () =>
                context.pushNamed(FeaturedArtistsPageWidget.routeName),
          ),
          SizedBox(height: 14.0),
          custom_widgets.HomeAuthors(),
          SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                  if ((FFAppState().selectedTrackUrl != '') &&
                      (currentUserEmail == 'ubitechsolutionsltd@gmail.com'))
                    wrapWithModel(
                      model: _model.currentlyPlayingStoryModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CurrentlyPlayingStoryWidget(
                        epTitle: FFAppState().selectedTrackTitle,
                        storyUrl: FFAppState().selectedTrackUrl,
                      ),
                    ),
                ],
              ),
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
