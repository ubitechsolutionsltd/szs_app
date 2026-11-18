import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'artist_container_comp_model.dart';
export 'artist_container_comp_model.dart';

class ArtistContainerCompWidget extends StatefulWidget {
  const ArtistContainerCompWidget({
    super.key,
    this.artistPhoto,
    this.artistName,
    this.bio,
    this.isfollow,
    this.id,
  });

  final String? artistPhoto;
  final String? artistName;
  final String? bio;
  final String? isfollow;
  final int? id;

  @override
  State<ArtistContainerCompWidget> createState() =>
      _ArtistContainerCompWidgetState();
}

class _ArtistContainerCompWidgetState extends State<ArtistContainerCompWidget> {
  late ArtistContainerCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArtistContainerCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: () {
        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
          return ((MediaQuery.sizeOf(context).width - 72) * 1 / 3);
        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
          return ((MediaQuery.sizeOf(context).width - 120) * 1 / 6);
        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
          return ((MediaQuery.sizeOf(context).width - 168) * 1 / 9);
        } else {
          return ((MediaQuery.sizeOf(context).width - 168) * 1 / 9);
        }
      }(),
      height: 137.0,
      decoration: BoxDecoration(
        color: Color(0xFF161616),
        borderRadius: BorderRadius.circular(8.0),
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
                  width: 56.0,
                  height: 56.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 500),
                    fadeOutDuration: Duration(milliseconds: 500),
                    imageUrl: widget.artistPhoto!,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) => Image.asset(
                      'assets/images/error_image.png',
                      fit: BoxFit.cover,
                    ),
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
                      widget.artistName,
                      'Artist',
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
    );
  }
}
