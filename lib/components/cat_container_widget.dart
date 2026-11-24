import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cat_container_model.dart';
export 'cat_container_model.dart';

class CatContainerWidget extends StatefulWidget {
  const CatContainerWidget({
    super.key,
    required this.ctData,
  });

  final CmStruct? ctData;

  @override
  State<CatContainerWidget> createState() => _CatContainerWidgetState();
}

class _CatContainerWidgetState extends State<CatContainerWidget> {
  late CatContainerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CatContainerModel());
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
      width: () {
        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
          return ((MediaQuery.sizeOf(context).width - 88) * 1 / 4);
        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
          return ((MediaQuery.sizeOf(context).width - 120) * 1 / 6);
        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
          return ((MediaQuery.sizeOf(context).width - 168) * 1 / 9);
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
                    valueOrDefault<String>(
                      widget.ctData?.img,
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/l958sdgto2fa/c1.svg',
                    ),
                    fit: BoxFit.contain,
                    alignment: Alignment(0.0, 0.0),
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
                      () {
                        if (FFAppState().langIndex == 0) {
                          return widget.ctData?.cName;
                        } else if (FFAppState().langIndex == 1) {
                          return widget.ctData?.cNHindi;
                        } else {
                          return widget.ctData?.cNArbic;
                        }
                      }(),
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
