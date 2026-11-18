import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/artist_container_playlist_comp/artist_container_playlist_comp_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'playlistof_the_day_page_model.dart';
export 'playlistof_the_day_page_model.dart';

class PlaylistofTheDayPageWidget extends StatefulWidget {
  const PlaylistofTheDayPageWidget({super.key});

  static String routeName = 'PlaylistofTheDayPage';
  static String routePath = '/playlistofTheDayPage';

  @override
  State<PlaylistofTheDayPageWidget> createState() =>
      _PlaylistofTheDayPageWidgetState();
}

class _PlaylistofTheDayPageWidgetState extends State<PlaylistofTheDayPageWidget>
    with TickerProviderStateMixin {
  late PlaylistofTheDayPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlaylistofTheDayPageModel());

    animationsMap.addAll({
      'artistContainerPlaylistCompOnPageLoadAnimation': AnimationInfo(
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: valueOrDefault<String>(
                    () {
                      if (FFAppState().langIndex == 0) {
                        return 'Playlists for your day';
                      } else if (FFAppState().langIndex == 1) {
                        return 'आपके दिन के लिए प्लेलिस्ट';
                      } else {
                        return 'قوائم التشغيل ليومك';
                      }
                    }(),
                    'Playlists for your day',
                  ),
                  backIcon: false,
                  addIcon: false,
                  onTapAdd: () async {},
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 16.0, 20.0, 24.0),
                      child: Builder(
                        builder: (context) {
                          final dayPlaylist = FFAppState().plfudList.toList();

                          return Wrap(
                            spacing: 16.0,
                            runSpacing: 16.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: List.generate(dayPlaylist.length,
                                (dayPlaylistIndex) {
                              final dayPlaylistItem =
                                  dayPlaylist[dayPlaylistIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context
                                      .pushNamed(LibraryPageWidget.routeName);
                                },
                                child: wrapWithModel(
                                  model: _model
                                      .artistContainerPlaylistCompModels
                                      .getModel(
                                    dayPlaylistItem.id.toString(),
                                    dayPlaylistIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: ArtistContainerPlaylistCompWidget(
                                    key: Key(
                                      'Keyki4_${dayPlaylistItem.id.toString()}',
                                    ),
                                    data: dayPlaylistItem,
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'artistContainerPlaylistCompOnPageLoadAnimation']!);
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
