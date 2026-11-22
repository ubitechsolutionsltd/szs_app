import '/custom_code/ui/app_widgets.dart';
import '/custom_code/ui/artwork_color.dart';
import '/custom_code/ui/app_palette.dart';
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
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'story_details_page_model.dart';
export 'story_details_page_model.dart';

class StoryDetailsPageWidget extends StatefulWidget {
  const StoryDetailsPageWidget({
    super.key,
    required this.story,
    required this.episodes,
  });

  final StoryStruct? story;
  final dynamic episodes;

  static String routeName = 'StoryDetailsPage';
  static String routePath = '/storyDetailsPage';

  @override
  State<StoryDetailsPageWidget> createState() => _StoryDetailsPageWidgetState();
}

class _StoryDetailsPageWidgetState extends State<StoryDetailsPageWidget>
    with TickerProviderStateMixin {
  late StoryDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoryDetailsPageModel());

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

  Widget _chip(BuildContext context, IconData icon, String label, {Color? iconColor}) {
    final palette = AppPalette.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: palette.outline, width: 0.5),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 15.0, color: iconColor ?? palette.muted),
        SizedBox(width: 5.0),
        Text(label,
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'SF Pro Display',
                  color: palette.text,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.0,
                )),
      ]),
    );
  }

  /// Cover, title, author, badges, description and the main play button.
  Widget _buildHero(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final story = widget.story;
    final rating = story?.avgRating ?? '';
    final episodes = widget.episodes?.toList() ?? [];

    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: CachedNetworkImage(
                  imageUrl: story?.portraitImg ?? '',
                  width: 120.0,
                  height: 160.0,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(width: 120.0, height: 160.0, color: palette.surfaceHigh),
                  errorWidget: (_, __, ___) => Container(
                    width: 120.0,
                    height: 160.0,
                    color: palette.surfaceHigh,
                    child: Icon(Icons.headphones_rounded, color: palette.muted, size: 40.0),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story?.title ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        color: palette.text,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        lineHeight: 1.15,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      story?.artistName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        color: palette.muted,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Wrap(spacing: 8.0, runSpacing: 8.0, children: [
                      if ((story?.categoryName ?? '').isNotEmpty)
                        _chip(context, Icons.category_rounded, story!.categoryName),
                      if (rating.isNotEmpty && rating != '0')
                        _chip(context, Icons.star_rounded, rating, iconColor: palette.warning),
                      if ((story?.totalEpisode ?? 0) > 0)
                        _chip(context, Icons.headphones_rounded, '${story!.totalEpisode}'),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          if ((story?.description ?? '').isNotEmpty) ...[
            SizedBox(height: 16.0),
            ExpandableText(text: story!.description),
          ],
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 54.0,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: palette.accent,
                foregroundColor: palette.onAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
              ),
              icon: Icon(Icons.play_arrow_rounded, size: 28.0),
              label: Text('Cheza simulizi',
                  style: theme.titleSmall.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.onAccent,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.0,
                  )),
              onPressed: episodes.isEmpty
                  ? null
                  : () {
                      final playable = episodes.firstWhere(
                        (e) =>
                            functions.jsonValueToInteger(getJsonField(e, r'''$["is_buy"]''')) == 1 ||
                            functions.jsonValueToInteger(getJsonField(e, r'''$["is_audio_coin"]''')) <= 0,
                        orElse: () => null,
                      );
                      if (playable == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Sehemu zote zimefungwa. Chagua sehemu ili kuifungua.'),
                        ));
                        return;
                      }
                      FFAppState().nowPlaying = playable;
                      FFAppState().playercommand = 'play';
                      FFAppState().playerisplaying = true;
                      FFAppState().update(() {});
                    },
            ),
          ),
          SizedBox(height: 14.0),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final episodes = widget.episodes?.toList() ?? [];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHero(context)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
            child: custom_widgets.AudioPlayerWidget(
              width: double.infinity,
              command: FFAppState().playercommand,
              episode: FFAppState().nowPlaying,
              episodes: widget.episodes,
            ),
          ),
        ),
        if (episodes.isEmpty)
          SliverToBoxAdapter(child: NoResultFoundCompWidget())
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, episodesIndex) => wrapWithModel(
                model: _model.episodeListItemModels.getModel(
                  episodesIndex.toString(),
                  episodesIndex,
                ),
                updateCallback: () => safeSetState(() {}),
                child: EpisodeListItemWidget(
                  key: Key('Keyfbo_${episodesIndex.toString()}'),
                  episode: episodes[episodesIndex],
                ),
              ),
              childCount: episodes.length,
            ),
          ),
        SliverToBoxAdapter(child: SizedBox(height: 32.0)),
      ],
    );
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
ArtworkBackdrop(
                imageUrl: widget.story?.portraitImg ?? '',
                child:               Column(
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
                                  color: Color(0xFF161616),
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: SvgPicture.asset(
                                      'assets/images/arrow_back_white_ic.svg',
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
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
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
                                color: Color(0xFF161616),
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
                                        contentId:
                                            widget.story?.id.toString(),
                                        contentType: '1',
                                      );

                                      _shouldSetState = true;
                                      if ((_model.addremoveBookmarkRes
                                              ?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              GeneralGroup
                                                  .addOrRemoveBookmarkCall
                                                  .message(
                                                (_model.addremoveBookmarkRes
                                                        ?.jsonBody ??
                                                    ''),
                                              )!,
                                              style: TextStyle(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                          ),
                                        );
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      } else {
                                        if (_shouldSetState)
                                          safeSetState(() {});
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
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
                                    color: Color(0xFF161616),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: SvgPicture.asset(
                                      'assets/images/more_white_ic.svg',
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
                  Expanded(child: _buildBody(context)),
                ],
              ),
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
