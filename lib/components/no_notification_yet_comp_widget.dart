import '/custom_code/ui/app_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_notification_yet_comp_model.dart';
export 'no_notification_yet_comp_model.dart';

class NoNotificationYetCompWidget extends StatefulWidget {
  const NoNotificationYetCompWidget({super.key});

  @override
  State<NoNotificationYetCompWidget> createState() =>
      _NoNotificationYetCompWidgetState();
}

class _NoNotificationYetCompWidgetState
    extends State<NoNotificationYetCompWidget> {
  late NoNotificationYetCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoNotificationYetCompModel());
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
          EmptyBadge(icon: Icons.notifications_off_outlined),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(44.0, 0.0, 44.0, 80.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'gpe5dtpu' /* Hakuna Taarifa */,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'y0bgn9o5' /* Hakuna taarifa yeyote kwa sasa */,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          color: FlutterFlowTheme.of(context).gray,
                          letterSpacing: 0.0,
                        ),
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
