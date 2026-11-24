import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'cat_container_three_model.dart';
export 'cat_container_three_model.dart';

class CatContainerThreeWidget extends StatefulWidget {
  const CatContainerThreeWidget({
    super.key,
    required this.title,
    required this.id,
    required this.image,
  });

  final String? title;
  final int? id;
  final String? image;

  @override
  State<CatContainerThreeWidget> createState() =>
      _CatContainerThreeWidgetState();
}

class _CatContainerThreeWidgetState extends State<CatContainerThreeWidget> {
  late CatContainerThreeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CatContainerThreeModel());
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
          return ((MediaQuery.sizeOf(context).width - 88) * 1 / 4);
        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
          return ((MediaQuery.sizeOf(context).width - 120) * 1 / 6);
        } else {
          return ((MediaQuery.sizeOf(context).width - 168) * 1 / 9);
        }
      }(),
      height: 118.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryText,
                  shape: BoxShape.circle,
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.network(
                    widget.image!,
                    width: 32.0,
                    height: 32.0,
                    fit: BoxFit.contain,
                    alignment: Alignment(0.0, 0.0),
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/error_image.png',
                      width: 32.0,
                      height: 32.0,
                      fit: BoxFit.contain,
                      alignment: Alignment(0.0, 0.0),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    valueOrDefault<String>(
                      widget.title,
                      'Bila jina',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
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
