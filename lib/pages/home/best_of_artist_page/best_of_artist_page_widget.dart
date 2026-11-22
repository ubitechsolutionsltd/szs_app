import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/artist_container_comp/artist_container_comp_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'best_of_artist_page_model.dart';
export 'best_of_artist_page_model.dart';

class BestOfArtistPageWidget extends StatefulWidget {
  const BestOfArtistPageWidget({super.key});

  static String routeName = 'BestOfArtistPage';
  static String routePath = '/bestOfArtistPage';

  @override
  State<BestOfArtistPageWidget> createState() => _BestOfArtistPageWidgetState();
}

class _BestOfArtistPageWidgetState extends State<BestOfArtistPageWidget> {
  late BestOfArtistPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BestOfArtistPageModel());
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
                  title: valueOrDefault<String>(
                    () {
                      if (FFAppState().langIndex == 0) {
                        return 'Best of artists';
                      } else if (FFAppState().langIndex == 1) {
                        return 'सर्वश्रेष्ठ कलाकार';
                      } else {
                        return 'أفضل الفنانين';
                      }
                    }(),
                    'Best of artists',
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
                          final bestArtistList = FFAppState()
                              .chooseArList
                              .where((e) => e.isBestArtist)
                              .toList();

                          return Wrap(
                            spacing: 16.0,
                            runSpacing: 16.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: List.generate(bestArtistList.length,
                                (bestArtistListIndex) {
                              final bestArtistListItem =
                                  bestArtistList[bestArtistListIndex];
                              return wrapWithModel(
                                model:
                                    _model.artistContainerCompModels.getModel(
                                  bestArtistListItem.id.toString(),
                                  bestArtistListIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: ArtistContainerCompWidget(
                                  key: Key(
                                    'Keyqjp_${bestArtistListItem.id.toString()}',
                                  ),
                                ),
                              );
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
