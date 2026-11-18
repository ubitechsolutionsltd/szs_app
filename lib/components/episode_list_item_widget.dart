import '/backend/api_requests/api_calls.dart';
import '/components/package_lists_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'episode_list_item_model.dart';
export 'episode_list_item_model.dart';

class EpisodeListItemWidget extends StatefulWidget {
  const EpisodeListItemWidget({
    super.key,
    required this.episode,
  });

  final dynamic episode;

  @override
  State<EpisodeListItemWidget> createState() => _EpisodeListItemWidgetState();
}

class _EpisodeListItemWidgetState extends State<EpisodeListItemWidget> {
  late EpisodeListItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EpisodeListItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          var _shouldSetState = false;
          if (((functions.jsonValueToInteger(getJsonField(
                            widget.episode,
                            r'''$["is_buy"]''',
                          )) ==
                          1
                      ? true
                      : false) ==
                  true) ||
              (functions.jsonValueToInteger(getJsonField(
                    widget.episode,
                    r'''$["is_audio_coin"]''',
                  )) <=
                  0)) {
            FFAppState().nowPlaying = widget.episode!;
            _model.updatePage(() {});
            FFAppState().playercommand = 'play';
            FFAppState().update(() {});
            FFAppState().playerisplaying = true;
            FFAppState().update(() {});
            if (_shouldSetState) safeSetState(() {});
            return;
          } else {
            if (FFAppState().walletcoin >=
                valueOrDefault<int>(
                  functions.jsonValueToInteger(getJsonField(
                    widget.episode,
                    r'''$["is_audio_coin"]''',
                  )),
                  0,
                )) {
              FFAppState().isLoading = true;
              FFAppState().update(() {});
              _model.buyEpisodeResp = await GeneralGroup.buyEpisodeCall.call(
                userId: FFAppState().userid,
                contentType: getJsonField(
                  widget.episode,
                  r'''$["audio_type"]''',
                ).toString(),
                audiobookType: getJsonField(
                  widget.episode,
                  r'''$["audio_type"]''',
                ).toString(),
                contentId: getJsonField(
                  widget.episode,
                  r'''$["content_id"]''',
                ).toString(),
                contentEpisodeId: getJsonField(
                  widget.episode,
                  r'''$.id''',
                ).toString(),
                coin: getJsonField(
                  widget.episode,
                  r'''$["is_audio_coin"]''',
                ).toString(),
              );

              _shouldSetState = true;
              FFAppState().isLoading = false;
              FFAppState().update(() {});
              if ((_model.buyEpisodeResp?.succeeded ?? true)) {
                if (GeneralGroup.buyEpisodeCall.responseCode(
                      (_model.buyEpisodeResp?.jsonBody ?? ''),
                    ) ==
                    200) {
                  FFAppState().nowPlaying = widget.episode!;
                  _model.updatePage(() {});
                  FFAppState().playercommand = 'play';
                  FFAppState().update(() {});
                  FFAppState().playerisplaying = true;
                  FFAppState().update(() {});
                  FFAppState().walletcoin = functions.newWalletBalance(
                      FFAppState().walletcoin,
                      functions.jsonValueToInteger(getJsonField(
                        widget.episode,
                        r'''$["is_audio_coin"]''',
                      )));
                  FFAppState().update(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        GeneralGroup.buyEpisodeCall.message(
                          (_model.buyEpisodeResp?.jsonBody ?? ''),
                        )!,
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: FlutterFlowTheme.of(context).tertiary,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).error,
                    ),
                  );
                  if (_shouldSetState) safeSetState(() {});
                  return;
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Imeshindwa kununua. Jaribu tena baadae.',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        color: FlutterFlowTheme.of(context).tertiary,
                      ),
                    ),
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: FlutterFlowTheme.of(context).error,
                  ),
                );
                if (_shouldSetState) safeSetState(() {});
                return;
              }
            } else {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return WebViewAware(
                    child: Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.75,
                        child: PackageListsComponentWidget(
                          episode: widget.episode,
                        ),
                      ),
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));

              if (_shouldSetState) safeSetState(() {});
              return;
            }

            if (_shouldSetState) safeSetState(() {});
            return;
          }

          if (_shouldSetState) safeSetState(() {});
        },
        child: Container(
          width: double.infinity,
          height: 45.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  2.0,
                ),
              )
            ],
            borderRadius: BorderRadius.only(),
            border: Border.all(
              color: FlutterFlowTheme.of(context).lightGray,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.play_circle,
                      color: colorFromCssString(
                        getJsonField(
                                  widget.episode,
                                  r'''$["name"]''',
                                ) ==
                                getJsonField(
                                  FFAppState().nowPlaying,
                                  r'''$["name"]''',
                                )
                            ? 'green'
                            : 'white',
                        defaultColor: FlutterFlowTheme.of(context).tertiary,
                      ),
                      size: 18.0,
                    ),
                    Text(
                      valueOrDefault<String>(
                        getJsonField(
                          widget.episode,
                          r'''$["name"]''',
                        )?.toString(),
                        'episodeTitle',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            color: colorFromCssString(
                              getJsonField(
                                        widget.episode,
                                        r'''$["name"]''',
                                      ) ==
                                      getJsonField(
                                        FFAppState().nowPlaying,
                                        r'''$["name"]''',
                                      )
                                  ? 'green'
                                  : 'white',
                              defaultColor:
                                  FlutterFlowTheme.of(context).tertiary,
                            ),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ].divide(SizedBox(width: 5.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if ((functions.jsonValueToInteger(getJsonField(
                                    widget.episode,
                                    r'''$["is_buy"]''',
                                  )) ==
                                  1) ||
                              (functions.jsonValueToInteger(getJsonField(
                                    widget.episode,
                                    r'''$["is_audio_coin"]''',
                                  )) <=
                                  0))
                            Icon(
                              Icons.check_circle_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 18.0,
                            ),
                          if ((functions.jsonValueToInteger(getJsonField(
                                    widget.episode,
                                    r'''$["is_buy"]''',
                                  )) ==
                                  0) &&
                              (functions.jsonValueToInteger(getJsonField(
                                    widget.episode,
                                    r'''$["is_audio_coin"]''',
                                  )) >
                                  0))
                            Icon(
                              Icons.radio_button_checked_sharp,
                              color: FlutterFlowTheme.of(context).warning,
                              size: 18.0,
                            ),
                          Text(
                            valueOrDefault<String>(
                              getJsonField(
                                widget.episode,
                                r'''$["is_audio_coin"]''',
                              )?.toString(),
                              'episodePrice',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: colorFromCssString(
                                    getJsonField(
                                              widget.episode,
                                              r'''$["name"]''',
                                            ) ==
                                            getJsonField(
                                              FFAppState().nowPlaying,
                                              r'''$["name"]''',
                                            )
                                        ? 'green'
                                        : 'white',
                                    defaultColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ].divide(SizedBox(width: 3.0)),
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: colorFromCssString(
                        getJsonField(
                                  widget.episode,
                                  r'''$["name"]''',
                                ) ==
                                getJsonField(
                                  FFAppState().nowPlaying,
                                  r'''$["name"]''',
                                )
                            ? 'green'
                            : 'white',
                        defaultColor: FlutterFlowTheme.of(context).tertiary,
                      ),
                      size: 18.0,
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
          ),
        ),
      ),
    );
  }
}
