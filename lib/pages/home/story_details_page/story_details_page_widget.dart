import '/custom_code/actions/index.dart' as actions;
import '/custom_code/player/player_service.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/app_toast.dart';
import '/custom_code/ui/wave_background.dart';
import '/custom_code/ui/app_widgets.dart';
import '/custom_code/ui/auth_gate.dart';
import '/custom_code/ui/app_palette.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/episode_list_item_widget.dart';
import '/components/when_ever_bottom_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      final episodes = widget.episodes?.toList() ?? [];
      final playable = episodes.firstWhere(
        (e) =>
            functions.jsonValueToInteger(getJsonField(e, r'''$["is_buy"]''')) == 1 ||
            functions.jsonValueToInteger(getJsonField(e, r'''$["is_audio_coin"]''')) <= 0,
        orElse: () => getJsonField(widget.episodes, r'''$[0]'''),
      );
      FFAppState().nowPlaying = playable;
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

  late bool _bookmarked = widget.story?.isBookmark == 1;
  bool _bookmarking = false;

  Widget _chip(BuildContext context, IconData icon, String label, {Color? iconColor}) {
    final palette = AppPalette.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
        border: Border.all(color: palette.outline, width: 0.8),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16.0, color: iconColor ?? palette.accent),
        SizedBox(width: 6.0),
        Text(label,
            style: TextStyle(
              fontFamily: AppTokens.fontFamily,
              color: palette.text,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            )),
      ]),
    );
  }

  Future<void> _toggleBookmark() async {
    final story = widget.story;
    if (story == null || _bookmarking) return;
    if (!isLoggedIn) {
      promptLogin(context, 'Tafadhali ingia kwanza ili kuhifadhi kwenye Pendwa.');
      return;
    }
    setState(() => _bookmarking = true);
    final response = await GeneralGroup.addOrRemoveBookmarkCall.call(
      userId: FFAppState().userid,
      contentId: story.id.toString(),
      contentType: story.contentType.toString(),
    );
    if (!mounted) return;
    setState(() => _bookmarking = false);
    if (response.succeeded) {
      final now = !_bookmarked;
      story.isBookmark = now ? 1 : 0;
      setState(() => _bookmarked = now);
      AppToast.success(context, now ? 'Imeongezwa kwenye Pendwa.' : 'Imeondolewa kwenye Pendwa.');
    } else {
      AppToast.error(context, 'Imeshindikana. Jaribu tena.');
    }
  }

  Future<void> _downloadAll() async {
    if (kIsWeb) {
      AppToast.info(context, 'Kupakua hakupatikani kwenye kivinjari. Tumia programu ya simu.');
      return;
    }
    final list = widget.episodes;
    final queued = <dynamic>[if (list is List) ...list.whereType<Map>()];
    if (queued.isEmpty) {
      AppToast.info(context, 'Hakuna cha kupakua kwa sasa.');
      return;
    }
    for (final ep in queued) {
      await actions.downloadEpisode(ep);
    }
    if (!mounted) return;
    AppToast.success(context, queued.length == 1 ? 'Kupakua kumeanza.' : 'Kupakua kwa vipindi ${queued.length} kumeanza.');
  }

  /// Makes sure something from this story is loaded, then opens the full-screen player.
  Future<void> _listenNow() async {
    final service = PlayerService.instance;
    await service.init();
    if (service.snapshot.value.item == null) {
      final now = FFAppState().nowPlaying;
      if (now is Map) {
        await service.playEpisodeMap(now, within: widget.episodes);
      }
    } else if (!service.snapshot.value.playing) {
      await service.play();
    }
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const custom_widgets.FullPlayer(),
    );
  }

  void _openMore() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) => WebViewAware(
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: WhenEverBottomWidget(
            story: widget.story,
            episodes: widget.episodes,
            onToggleSort: () {
              final eps = widget.episodes;
              if (eps is List && eps.length > 1) {
                final reversed = eps.reversed.toList();
                eps
                  ..clear()
                  ..addAll(reversed);
              }
              safeSetState(() {});
            },
          ),
        ),
      ),
    ).then((value) => safeSetState(() {}));
  }

  Widget _roundButton(IconData icon, String tooltip, VoidCallback? onTap, {Color? color}) {
    return Material(
      color: Colors.white.withValues(alpha: 0.2),
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: tooltip,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        icon: Icon(icon, color: color ?? Colors.white),
        onPressed: onTap,
      ),
    );
  }

  /// Blue gradient header with the cover art floating in the middle.
  Widget _buildHeader(BuildContext context) {
    final story = widget.story;
    final top = MediaQuery.paddingOf(context).top;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      child: Stack(children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0A86D9), AppTokens.brandPrimary, AppTokens.brandDeep],
              ),
            ),
            child: HeaderWaves(),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, top + 8, 12, 28),
          child: Column(children: [
            Row(children: [
              _roundButton(Icons.arrow_back_rounded, 'Rudi nyuma', () => context.safePop()),
              const Spacer(),
              _roundButton(Icons.more_horiz_rounded, 'Zaidi', _openMore),
            ]),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 28, offset: const Offset(0, 14))],
              ),
              child: CoverImage(url: story?.portraitImg, width: 168, height: 224, radius: 22),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _buildDetails(BuildContext context) {
    final palette = AppPalette.of(context);
    final story = widget.story;
    final rating = story?.avgRating ?? '';
    final hasRating = (double.tryParse(rating) ?? 0) > 0;
    final author = (story?.artistName ?? '').trim();

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 22, AppTokens.screenPadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            story?.title ?? '',
            style: TextStyle(
              fontFamily: AppTokens.fontFamily,
              color: palette.text,
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          if (author.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(author,
                style: TextStyle(fontFamily: AppTokens.fontFamily, color: palette.muted, fontSize: 17.0, fontWeight: FontWeight.w500)),
          ],
          const SizedBox(height: 16),
          Wrap(spacing: 10.0, runSpacing: 10.0, children: [
            if ((story?.categoryName ?? '').isNotEmpty) _chip(context, Icons.layers_rounded, story!.categoryName),
            if (hasRating) _chip(context, Icons.star_rounded, rating, iconColor: palette.warning),
            if ((story?.totalEpisode ?? 0) > 0) _chip(context, Icons.queue_music_rounded, '${story!.totalEpisode}'),
          ]),
          if ((story?.description ?? '').isNotEmpty) ...[
            const SizedBox(height: 18),
            ExpandableText(text: story!.description),
          ],
          const SizedBox(height: 22),
          AppButton(label: 'Sikiliza Sasa', icon: Icons.play_arrow_rounded, onPressed: _listenNow),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: AppButton(
                label: _bookmarked ? 'Imehifadhiwa' : 'Hifadhi',
                icon: _bookmarked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                kind: AppButtonKind.secondary,
                loading: _bookmarking,
                onPressed: _toggleBookmark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                label: 'Pakua',
                icon: Icons.download_rounded,
                kind: AppButtonKind.secondary,
                onPressed: _downloadAll,
              ),
            ),
          ]),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final palette = AppPalette.of(context);
    final episodes = widget.episodes?.toList() ?? [];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(context)),
        SliverToBoxAdapter(child: _buildDetails(context)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: custom_widgets.AudioPlayerWidget(
              width: double.infinity,
              command: FFAppState().playercommand,
              episode: FFAppState().nowPlaying,
              episodes: widget.episodes,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 4, AppTokens.screenPadding, 8),
            child: Text(
              episodes.isEmpty ? 'Vipindi' : 'Vipindi (${episodes.length})',
              style: TextStyle(fontFamily: AppTokens.fontFamily, color: palette.text, fontSize: 22.0, fontWeight: FontWeight.w800),
            ),
          ),
        ),
        if (episodes.isEmpty)
          const SliverToBoxAdapter(
            child: EmptyState(
              icon: Icons.headphones_rounded,
              title: 'Hakuna vipindi bado',
              message: 'Vipindi vya simulizi hii vitaonekana hapa.',
            ),
          )
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _buildBody(context),
          if (FFAppState().isLoading)
            wrapWithModel(
              model: _model.customLoadingIndicatorModel,
              updateCallback: () => safeSetState(() {}),
              child: CustomLoadingIndicatorWidget(),
            ),
        ],
      ),
    );
  }
}
