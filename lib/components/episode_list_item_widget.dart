import '/backend/api_requests/api_calls.dart';
import '/components/package_lists_component_widget.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/auth_gate.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
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

  /// Episode card: artwork, title, duration and a clear locked / playing state.
  Widget _buildRow(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final episode = widget.episode;

    final isCurrent = getJsonField(episode, r'''$.id''')?.toString() ==
        getJsonField(FFAppState().nowPlaying, r'''$.id''')?.toString();
    final price = functions
        .jsonValueToInteger(getJsonField(episode, r'''$["is_audio_coin"]'''));
    final owned = functions
            .jsonValueToInteger(getJsonField(episode, r'''$["is_buy"]''')) ==
        1;
    final locked = !owned && price > 0;
    final seconds = functions
        .jsonValueToInteger(getJsonField(episode, r'''$["audio_duration"]'''));
    final image = getJsonField(episode, r'''$.image''')?.toString() ?? '';
    final name = getJsonField(episode, r'''$["name"]''')?.toString() ?? '';

    Widget trailing;
    if (locked) {
      trailing = Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: palette.warning.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.lock_rounded, color: palette.warning, size: 14.0),
          SizedBox(width: 4.0),
          Text('$price',
              style: theme.bodySmall.override(
                fontFamily: 'SF Pro Display',
                color: palette.warning,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
              )),
        ]),
      );
    } else if (isCurrent) {
      trailing = Icon(Icons.graphic_eq_rounded, color: palette.accent, size: 24.0);
    } else {
      trailing = Icon(Icons.play_circle_outline_rounded, color: palette.muted, size: 26.0);
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isCurrent ? palette.accent.withValues(alpha: 0.12) : palette.surface,
        borderRadius: BorderRadius.circular(AppSpace.radiusMd),
        border: Border.all(
          color: isCurrent ? palette.accent.withValues(alpha: 0.55) : palette.outline,
          width: 0.6,
        ),
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: image,
            width: 54.0,
            height: 54.0,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(width: 54.0, height: 54.0, color: palette.surfaceHigh),
            errorWidget: (_, __, ___) => Container(
              width: 54.0,
              height: 54.0,
              color: palette.surfaceHigh,
              child: Icon(Icons.headphones_rounded, color: palette.muted, size: 24.0),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.bodyMedium.override(
                  fontFamily: 'SF Pro Display',
                  color: isCurrent ? palette.accent : palette.text,
                  fontSize: 16.0,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                  letterSpacing: 0.0,
                  lineHeight: 1.25,
                ),
              ),
              if (seconds > 0) ...[
                SizedBox(height: 3.0),
                Text(
                  '${Duration(seconds: seconds).inMinutes} dak',
                  style: theme.bodySmall.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.muted,
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 8.0),
        trailing,
      ]),
    );
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
            if (!isLoggedIn) {
              promptLogin(context, trs('login_to_buy'));
              return;
            }
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
                          color: Colors.white,
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
                      trs('buy_failed'),
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        color: Colors.white,
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
                backgroundColor: Colors.transparent,
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
        child: _buildRow(context),
      ),
    );
  }
}
