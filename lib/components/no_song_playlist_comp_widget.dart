import '/custom_code/ui/app_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_song_playlist_comp_model.dart';
export 'no_song_playlist_comp_model.dart';

class NoSongPlaylistCompWidget extends StatefulWidget {
  const NoSongPlaylistCompWidget({super.key});

  @override
  State<NoSongPlaylistCompWidget> createState() =>
      _NoSongPlaylistCompWidgetState();
}

class _NoSongPlaylistCompWidgetState extends State<NoSongPlaylistCompWidget> {
  late NoSongPlaylistCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoSongPlaylistCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyBadge(icon: Icons.favorite_border_rounded),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(44.0, 0.0, 44.0, 80.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'ror2owk3' /* Hakuna ulizochagua */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        color: FlutterFlowTheme.of(context).tertiary,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        lineHeight: 1.5,
                      ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'ekonhu1v' /* Tafuta  na ongeza simulizi pen... */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        color: FlutterFlowTheme.of(context).gray,
                        letterSpacing: 0.0,
                      ),
                ),
              ]
                  .divide(SizedBox(height: 8.0))
                  .addToStart(SizedBox(height: 20.0)),
            ),
          ),
        ],
      ),
    );
  }
}
