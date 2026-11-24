import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/downloads.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/auth_gate.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'when_ever_bottom_model.dart';
export 'when_ever_bottom_model.dart';

/// Quick-actions sheet shown from a story's "more options" button.
///
/// [story] drives bookmarking, sharing and "more like this"; [episodes] (a
/// list of episode maps, as returned by the API) drives bulk download.
/// [onToggleSort] lets the caller reorder whatever episode list it is
/// currently displaying (the sheet itself holds no list state).
class WhenEverBottomWidget extends StatefulWidget {
  const WhenEverBottomWidget({
    super.key,
    this.story,
    this.episodes,
    this.onToggleSort,
  });

  final StoryStruct? story;
  final dynamic episodes;
  final VoidCallback? onToggleSort;

  @override
  State<WhenEverBottomWidget> createState() => _WhenEverBottomWidgetState();
}

class _WhenEverBottomWidgetState extends State<WhenEverBottomWidget> {
  late WhenEverBottomModel _model;
  bool _working = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WhenEverBottomModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _download() async {
    if (kIsWeb) {
      _toast(trs('dl_web'));
      Navigator.pop(context);
      return;
    }
    final list = widget.episodes;
    final queued = <dynamic>[];
    if (list is List) {
      for (final ep in list) {
        if (ep is Map) queued.add(ep);
      }
    }
    if (queued.isEmpty) {
      _toast(trs('nothing_to_download'));
      Navigator.pop(context);
      return;
    }
    for (final ep in queued) {
      await downloadEpisode(ep);
    }
    _toast(queued.length == 1 ? trs('dl_started') : trs('dl_started_n', args: {'n': '${queued.length}'}));
    if (mounted) Navigator.pop(context);
  }

  Future<void> _toggleBookmark() async {
    final story = widget.story;
    if (story == null || _working) {
      Navigator.pop(context);
      return;
    }
    if (!isLoggedIn) {
      Navigator.pop(context);
      promptLogin(context, trs('login_to_save'));
      return;
    }
    final wasBookmarked = story.isBookmark == 1;
    setState(() => _working = true);
    final response = await GeneralGroup.addOrRemoveBookmarkCall.call(
      userId: FFAppState().userid,
      contentType: story.contentType.toString(),
      contentId: story.id.toString(),
    );
    if (!mounted) return;
    setState(() => _working = false);
    if (response.succeeded) {
      story.isBookmark = wasBookmarked ? 0 : 1;
      _toast(wasBookmarked ? 'Imeondolewa kwenye Pendwa.' : trs('added_fav'));
      Navigator.pop(context);
    } else {
      _toast(trs('failed_retry'));
    }
  }

  void _toggleSort() {
    widget.onToggleSort?.call();
    Navigator.pop(context);
  }

  void _moreLikeThis() {
    final story = widget.story;
    if (story == null || story.artistId == 0) {
      _toast(trs('unavailable_now'));
      Navigator.pop(context);
      return;
    }
    Navigator.pop(context);
    context.pushNamed(
      ViewAlbumPageWidget.routeName,
      queryParameters: {
        'artistid': serializeParam(story.artistId.toString(), ParamType.String),
        'type': serializeParam(story.contentType.toString(), ParamType.String),
        'artistName': serializeParam(story.artistName, ParamType.String),
      }.withoutNulls,
    );
  }

  Future<void> _share() async {
    final story = widget.story;
    final text = story == null
        ? '${trs('share_generic')}https://szs.co.tz'
        : '${trs('share_story', args: {'title': story.title, 'artist': story.artistName})}https://szs.co.tz';
    Navigator.pop(context);
    await Share.share(text, sharePositionOrigin: getWidgetBoundingBox(context));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppPalette.of(context).solid,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'uqbilfzc' /* Chaguo za Haraka */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            color: FlutterFlowTheme.of(context).tertiary,
                            fontSize: 20.0,
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
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).tertiary,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _download,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: SvgPicture.asset(
                        'assets/images/w_download_ic.svg',
                        colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'odgxauyg' /* Pakua */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
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
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _working ? null : _toggleBookmark,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: SvgPicture.asset(
                        'assets/images/w_addp_ic.svg',
                        colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '7fzs7t21' /* Ongeza Orodha Pendwa */,
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
                    ),
                    if (_working)
                      SizedBox(
                        width: 16.0,
                        height: 16.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0, color: FlutterFlowTheme.of(context).tertiary),
                      ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _toggleSort,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: SvgPicture.asset(
                        'assets/images/sort_item_ic.svg',
                        colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '85udr75o' /* Geuza Mpangilio */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
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
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _moreLikeThis,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: SvgPicture.asset(
                        'assets/images/wva_ic.svg',
                        colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '2no99jg7' /* Nyingine kama hizi */,
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
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) => InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: _share,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: SvgPicture.asset(
                          'assets/images/w_share_ic.svg',
                          colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                          width: 24.0,
                          height: 24.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'qtyye74m' /* Shirikisha */,
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
                      ),
                    ],
                  ),
                ),
              ),
            ]
                .divide(SizedBox(height: 24.0))
                .addToStart(SizedBox(height: 24.0))
                .addToEnd(SizedBox(height: 40.0)),
          ),
        ),
      ),
    );
  }
}
