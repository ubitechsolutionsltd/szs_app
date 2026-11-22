import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'artist_container_playlist_comp_model.dart';
export 'artist_container_playlist_comp_model.dart';

class ArtistContainerPlaylistCompWidget extends StatefulWidget {
  const ArtistContainerPlaylistCompWidget({
    super.key,
    required this.data,
  });

  final PfudStruct? data;

  @override
  State<ArtistContainerPlaylistCompWidget> createState() =>
      _ArtistContainerPlaylistCompWidgetState();
}

class _ArtistContainerPlaylistCompWidgetState
    extends State<ArtistContainerPlaylistCompWidget> {
  late ArtistContainerPlaylistCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArtistContainerPlaylistCompModel());
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
        context.pushNamed(LibraryPageWidget.routeName);
      },
      child: Container(
        width: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return ((MediaQuery.sizeOf(context).width - 56) * 1 / 2);
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return ((MediaQuery.sizeOf(context).width - 88) * 1 / 4);
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return ((MediaQuery.sizeOf(context).width - 120) * 1 / 6);
          } else {
            return ((MediaQuery.sizeOf(context).width - 168) * 1 / 9);
          }
        }(),
        height: 119.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      valueOrDefault<String>(
                        widget.data?.img,
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ucvqe2zikw23/a1.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      valueOrDefault<String>(
                        () {
                          if (FFAppState().langIndex == 0) {
                            return widget.data?.name;
                          } else if (FFAppState().langIndex == 1) {
                            return widget.data?.nameHindi;
                          } else {
                            return widget.data?.nameArbic;
                          }
                        }(),
                        'Byron Akins',
                      ).maybeHandleOverflow(
                        maxChars: 24,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      minFontSize: 17.0,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            color: FlutterFlowTheme.of(context).tertiary,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            lineHeight: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
