import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'password_succsess_alrt_model.dart';
export 'password_succsess_alrt_model.dart';

class PasswordSuccsessAlrtWidget extends StatefulWidget {
  const PasswordSuccsessAlrtWidget({
    super.key,
    required this.onTapLogin,
  });

  final Future Function()? onTapLogin;

  @override
  State<PasswordSuccsessAlrtWidget> createState() =>
      _PasswordSuccsessAlrtWidgetState();
}

class _PasswordSuccsessAlrtWidgetState
    extends State<PasswordSuccsessAlrtWidget> {
  late PasswordSuccsessAlrtModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PasswordSuccsessAlrtModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        width: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return 396.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return 420.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return 420.0;
          } else {
            return 420.0;
          }
        }(),
        height: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return 425.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return 425.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return 425.0;
          } else {
            return 400.0;
          }
        }(),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/password_changes_img.png',
                width: 156.0,
                height: 137.0,
                fit: BoxFit.contain,
                alignment: Alignment(0.0, 0.0),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      '9cdr0td1' /* Password changed! */,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          color: FlutterFlowTheme.of(context).tertiary,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          lineHeight: 1.5,
                        ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'm714g4la' /* Your password has been changed... */,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          color: FlutterFlowTheme.of(context).gray,
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          lineHeight: 1.5,
                        ),
                  ),
                ].divide(SizedBox(height: 13.0)),
              ),
              FFButtonWidget(
                onPressed: () async {
                  await widget.onTapLogin?.call();
                },
                text: FFLocalizations.of(context).getText(
                  'bh30kghu' /* Ok */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 56.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'SF Pro Display',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w700,
                        lineHeight: 1.2,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                showLoadingIndicator: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
