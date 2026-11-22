import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/custom_code/ui/app_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'song_container_model.dart';
export 'song_container_model.dart';

class SongContainerWidget extends StatefulWidget {
  const SongContainerWidget({
    super.key,
    required this.story,
    this.variant = 'row',
  });

  final StoryStruct? story;

  /// 'row' (full-width list item) or 'card' (portrait cover card for horizontal rails).
  final String variant;

  @override
  State<SongContainerWidget> createState() => _SongContainerWidgetState();
}

class _SongContainerWidgetState extends State<SongContainerWidget> {
  late SongContainerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SongContainerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  /// Loads the story's episodes, then opens the story page.
  Future<void> _openStory() async {
            var _shouldSetState = false;
            FFAppState().isLoading = true;
            FFAppState().update(() {});
            _model.storyEpisodesResp =
                await GeneralGroup.episodesAudioByContentCall.call(
              contentId: widget.story?.id.toString(),
              userId: FFAppState().userid,
            );

            _shouldSetState = true;
            FFAppState().isLoading = false;
            FFAppState().update(() {});
            if ((_model.storyEpisodesResp?.succeeded ?? true)) {
              context.pushNamed(
                StoryDetailsPageWidget.routeName,
                queryParameters: {
                  'story': serializeParam(
                    widget.story,
                    ParamType.DataStruct,
                  ),
                  'episodes': serializeParam(
                    getJsonField(
                      (_model.storyEpisodesResp?.jsonBody ?? ''),
                      r'''$.result''',
                    ),
                    ParamType.JSON,
                  ),
                }.withoutNulls,
              );

              if (_shouldSetState) safeSetState(() {});
              return;
            } else {
              if (_shouldSetState) safeSetState(() {});
              return;
            }

            if (_shouldSetState) safeSetState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return widget.variant == 'card' ? _buildCard(context) : _buildRow(context);
  }

  Widget _buildCard(BuildContext context) {
    final palette = AppPalette.of(context);
    final story = widget.story;
    final rating = story?.avgRating ?? '';
    final episodes = story?.totalEpisode ?? 0;

    return SizedBox(
      width: 152.0,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: _openStory,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpace.radiusMd),
                  child: CachedNetworkImage(
                    imageUrl: story?.portraitImg ?? '',
                    width: 152.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(width: 152.0, height: 200.0, color: palette.surfaceHigh),
                    errorWidget: (_, __, ___) => Container(
                      width: 152.0,
                      height: 200.0,
                      color: palette.surfaceHigh,
                      child: Icon(Icons.headphones_rounded, color: palette.muted, size: 40.0),
                    ),
                  ),
                ),
                if (rating.isNotEmpty && rating != '0')
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.62),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.star_rounded, color: palette.warning, size: 14.0),
                        SizedBox(width: 2.0),
                        Text(rating,
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                  fontFamily: 'SF Pro Display',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                )),
                      ]),
                    ),
                  ),
                if (episodes > 0)
                  Positioned(
                    left: 8.0,
                    bottom: 8.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.62),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.headphones_rounded, color: Colors.white, size: 13.0),
                        SizedBox(width: 4.0),
                        Text('$episodes',
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                  fontFamily: 'SF Pro Display',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                )),
                      ]),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              story?.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.text,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.0,
                    lineHeight: 1.25,
                  ),
            ),
            SizedBox(height: 2.0),
            Text(
              story?.artistName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.muted,
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: _openStory,
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 16.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeOutDuration: Duration(milliseconds: 500),
                      imageUrl: widget.story!.portraitImg,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => Image.asset(
                        'assets/images/error_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.story?.title,
                                    'StoryTitle',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.story?.artistName,
                                    'ArtistName',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        color:
                                            FlutterFlowTheme.of(context).gray,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 2.0)),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.story?.categoryName,
                          'Category',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SF Pro Display',
                              color: FlutterFlowTheme.of(context).gray,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.story?.totalEpisode.toString(),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context).gray,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ].divide(SizedBox(height: 10.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
