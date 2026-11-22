import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'logout_alrt_dialog_model.dart';
export 'logout_alrt_dialog_model.dart';

class LogoutAlrtDialogWidget extends StatefulWidget {
  const LogoutAlrtDialogWidget({
    super.key,
    required this.onTapLogout,
  });

  final Future Function()? onTapLogout;

  @override
  State<LogoutAlrtDialogWidget> createState() => _LogoutAlrtDialogWidgetState();
}

class _LogoutAlrtDialogWidgetState extends State<LogoutAlrtDialogWidget>
    with TickerProviderStateMixin {
  late LogoutAlrtDialogModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogoutAlrtDialogModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.5, 1.0),
            end: Offset(0.5, 1.0),
          ),
        ],
      ),
    });
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
            return 360.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return 376.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return 395.0;
          } else {
            return 395.0;
          }
        }(),
        height: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return 235.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return 240.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return 240.0;
          } else {
            return 240.0;
          }
        }(),
        decoration: BoxDecoration(
          color: Color(0xFF313030),
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 40.0, 16.0, 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'rxu0qsy2' /* Toka ? */,
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'dcr851fh' /* Ni kweli unataka kutoka ? */,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context).gray,
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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: FFLocalizations.of(context).getText(
                        'xuntpavf' /* Hapana */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 54.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.transparent,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w700,
                                  lineHeight: 1.2,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      showLoadingIndicator: false,
                    ),
                  ),
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        await widget.onTapLogout?.call();
                      },
                      text: FFLocalizations.of(context).getText(
                        'j6diwfc7' /* Ndio */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 54.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
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
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ].divide(SizedBox(height: 32.0)),
          ),
        ),
      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
    );
  }
}
