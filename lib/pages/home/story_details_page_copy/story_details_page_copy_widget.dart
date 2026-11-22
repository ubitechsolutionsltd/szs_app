import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/episode_list_item_widget.dart';
import '/components/no_result_found_comp_widget.dart';
import '/components/when_ever_bottom_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'story_details_page_copy_model.dart';
export 'story_details_page_copy_model.dart';

class StoryDetailsPageCopyWidget extends StatefulWidget {
  const StoryDetailsPageCopyWidget({
    super.key,
    required this.story,
    required this.episodes,
  });

  final StoryStruct? story;
  final dynamic episodes;

  static String routeName = 'StoryDetailsPageCopy';
  static String routePath = '/storyDetailsPageCopy';

  @override
  State<StoryDetailsPageCopyWidget> createState() =>
      _StoryDetailsPageCopyWidgetState();
}

class _StoryDetailsPageCopyWidgetState extends State<StoryDetailsPageCopyWidget>
    with TickerProviderStateMixin {
  late StoryDetailsPageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoryDetailsPageCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().nowPlaying = getJsonField(
        widget.episodes,
        r'''$[0]''',
      );
      FFAppState().update(() {});
      FFAppState().playercommand = 'play';
      FFAppState().update(() {});
      FFAppState().playerisplaying = true;
      FFAppState().update(() {});
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
                  Container(
                    width: double.infinity,
                    height: 79.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                border: Border.all(color: FlutterFlowTheme.of(context).borderColor, width: 0.8),
                            shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: SvgPicture.asset(
                                    'assets/images/arrow_back_white_ic.svg',
                      colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                                    fit: BoxFit.contain,
                                    alignment: Alignment(0.0, 0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.story?.title,
                                  'StoryTitle',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              border: Border.all(color: FlutterFlowTheme.of(context).borderColor, width: 0.8),
                            shape: BoxShape.circle,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.bookmark_add_outlined,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 24.0,
                                  ),
                                  showLoadingIndicator: true,
                                  onPressed: () async {
                                    var _shouldSetState = false;
                                    _model.addremoveBookmarkRes =
                                        await GeneralGroup
                                            .addOrRemoveBookmarkCall
                                            .call(
                                      userId: FFAppState().userid,
                                      contentId: widget.story?.id.toString(),
                                      contentType: '1',
                                    );

                                    _shouldSetState = true;
                                    if ((_model
                                            .addremoveBookmarkRes?.succeeded ??
                                        true)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            GeneralGroup.addOrRemoveBookmarkCall
                                                .message(
                                              (_model.addremoveBookmarkRes
                                                      ?.jsonBody ??
                                                  ''),
                                            )!,
                                            style: TextStyle(
                                              fontFamily: 'SF Pro Display',
                                              color:
                                                  Colors.white,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                        ),
                                      );
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    } else {
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }

                                    if (_shouldSetState) safeSetState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
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
                                          child: WhenEverBottomWidget(),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  border: Border.all(color: FlutterFlowTheme.of(context).borderColor, width: 0.8),
                            shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: SvgPicture.asset(
                                    'assets/images/more_white_ic.svg',
                      colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                                    fit: BoxFit.contain,
                                    alignment: Alignment(0.0, 0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 98.02,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.skip_previous_outlined,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 40.0,
                                ),
                                if (!valueOrDefault<bool>(
                                  FFAppState().playerisplaying,
                                  true,
                                ))
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      FFAppState().playercommand = 'play';
                                      FFAppState().update(() {});
                                      FFAppState().playerisplaying = true;
                                      FFAppState().update(() {});
                                    },
                                    child: Icon(
                                      Icons.play_circle_outline,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 80.0,
                                    ),
                                  )
                                      .animateOnPageLoad(animationsMap[
                                          'iconOnPageLoadAnimation']!)
                                      .animateOnActionTrigger(
                                        animationsMap[
                                            'iconOnActionTriggerAnimation']!,
                                      ),
                                if (FFAppState().playerisplaying)
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      FFAppState().playercommand = 'pause';
                                      FFAppState().update(() {});
                                      FFAppState().playerisplaying = false;
                                      FFAppState().update(() {});
                                    },
                                    child: Icon(
                                      Icons.pause_circle_outline,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 80.0,
                                    ),
                                  ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    FFAppState().playercommand = 'play';
                                    FFAppState().update(() {});
                                  },
                                  child: Icon(
                                    Icons.skip_next_outlined,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 40.0,
                                  ),
                                ),
                              ].divide(SizedBox(width: 24.0)),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.95,
                              height: MediaQuery.sizeOf(context).height * 0.15,
                              child: custom_widgets.AudioPlayerWidget(
                                width: MediaQuery.sizeOf(context).width * 0.95,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                command: FFAppState().playercommand,
                                episode: FFAppState().nowPlaying,
                                onFinished: (episode) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${getJsonField(
                                          episode,
                                          r'''$["name"]''',
                                        ).toString()} Finished',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              child: Builder(
                                builder: (context) {
                                  final episodes = widget.episodes!.toList();
                                  if (episodes.isEmpty) {
                                    return NoResultFoundCompWidget();
                                  }

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: episodes.length,
                                    itemBuilder: (context, episodesIndex) {
                                      final episodesItem =
                                          episodes[episodesIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 15.0, 0.0),
                                        child: wrapWithModel(
                                          model: _model.episodeListItemModels
                                              .getModel(
                                            episodesIndex.toString(),
                                            episodesIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EpisodeListItemWidget(
                                            key: Key(
                                              'Keyifo_${episodesIndex.toString()}',
                                            ),
                                            episode: episodesItem,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
