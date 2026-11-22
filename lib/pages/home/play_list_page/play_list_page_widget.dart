import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/components/no_song_playlist_comp_widget.dart';
import '/components/play_list_container_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'play_list_page_model.dart';
export 'play_list_page_model.dart';

class PlayListPageWidget extends StatefulWidget {
  const PlayListPageWidget({super.key});

  static String routeName = 'PlayListPage';
  static String routePath = '/playListPage';

  @override
  State<PlayListPageWidget> createState() => _PlayListPageWidgetState();
}

class _PlayListPageWidgetState extends State<PlayListPageWidget>
    with TickerProviderStateMixin {
  late PlayListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayListPageModel());

    animationsMap.addAll({
      'playListContainerOnPageLoadAnimation': AnimationInfo(
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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: 'Uzipendazo',
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
                      child: FutureBuilder<ApiCallResponse>(
                        future: GeneralGroup.getBookMarksCall.call(
                          userId: FFAppState().userid,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final wrapGetBookMarksResponse = snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final playlist = StoriesStruct.maybeFromMap(
                                          wrapGetBookMarksResponse.jsonBody)
                                      ?.stories
                                      .toList() ??
                                  [];
                              if (playlist.isEmpty) {
                                return NoSongPlaylistCompWidget();
                              }

                              return Wrap(
                                spacing: 16.0,
                                runSpacing: 16.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.start,
                                verticalDirection: VerticalDirection.down,
                                clipBehavior: Clip.none,
                                children: List.generate(playlist.length,
                                    (playlistIndex) {
                                  final playlistItem = playlist[playlistIndex];
                                  return wrapWithModel(
                                    model:
                                        _model.playListContainerModels.getModel(
                                      playlistItem.id.toString(),
                                      playlistIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: PlayListContainerWidget(
                                      key: Key(
                                        'Keybob_${playlistItem.id.toString()}',
                                      ),
                                      story: playlistItem,
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'playListContainerOnPageLoadAnimation']!);
                                }),
                              );
                            },
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
