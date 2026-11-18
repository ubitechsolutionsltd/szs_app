import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_result_found_comp_model.dart';
export 'no_result_found_comp_model.dart';

class NoResultFoundCompWidget extends StatefulWidget {
  const NoResultFoundCompWidget({super.key});

  @override
  State<NoResultFoundCompWidget> createState() =>
      _NoResultFoundCompWidgetState();
}

class _NoResultFoundCompWidgetState extends State<NoResultFoundCompWidget> {
  late NoResultFoundCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoResultFoundCompModel());
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
          ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: Image.asset(
              'assets/images/no_result_ic.png',
              width: 156.0,
              height: 137.0,
              fit: BoxFit.cover,
              alignment: Alignment(0.0, 0.0),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(44.0, 0.0, 44.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'q5aoajhk' /* Hakuna Matokeo */,
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
                    'xdgj78m1' /* Jaribu kutumia herufi 3 za awa... */,
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
                  .addToStart(SizedBox(height: 16.0))
                  .addToEnd(SizedBox(height: 80.0)),
            ),
          ),
        ],
      ),
    );
  }
}
