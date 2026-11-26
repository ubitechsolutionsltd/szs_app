import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'play_list_container_model.dart';
export 'play_list_container_model.dart';

class PlayListContainerWidget extends StatefulWidget {
  const PlayListContainerWidget({
    super.key,
    required this.story,
  });

  final StoryStruct? story;

  @override
  State<PlayListContainerWidget> createState() =>
      _PlayListContainerWidgetState();
}

class _PlayListContainerWidgetState extends State<PlayListContainerWidget> {
  late PlayListContainerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayListContainerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
      },
      child: Container(
        width: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return ((MediaQuery.sizeOf(context).width - 56) * 1 / 2);
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return ((MediaQuery.sizeOf(context).width - 88) * 1 / 4);
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return ((MediaQuery.sizeOf(context).width - 88) * 1 / 4);
          } else {
            return ((MediaQuery.sizeOf(context).width - 120) * 1 / 6);
          }
        }(),
        height: 256.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 500),
                  fadeOutDuration: Duration(milliseconds: 500),
                  imageUrl: widget.story!.portraitImg,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment(0.0, 0.0),
                  errorWidget: (context, error, stackTrace) => Image.asset(
                    'assets/images/error_image.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment(0.0, 0.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            valueOrDefault<String>(
                              widget.story?.title,
                              trs('no_name'),
                            ),
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontSize: 18.0,
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
                              'Artist Name',
                            ),
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).gray,
                                  fontSize: 17.0,
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
          ],
        ),
      ),
    );
  }
}
