import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_select_a_lrt_dialog_model.dart';
export 'language_select_a_lrt_dialog_model.dart';

class LanguageSelectALrtDialogWidget extends StatefulWidget {
  const LanguageSelectALrtDialogWidget({super.key});

  @override
  State<LanguageSelectALrtDialogWidget> createState() =>
      _LanguageSelectALrtDialogWidgetState();
}

class _LanguageSelectALrtDialogWidgetState
    extends State<LanguageSelectALrtDialogWidget> {
  late LanguageSelectALrtDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LanguageSelectALrtDialogModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondary,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 24.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '6t5vctjg' /* Lugha */,
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
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.clear,
                        color: FlutterFlowTheme.of(context).tertiary,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().langIndex = 0;
                        safeSetState(() {});
                        setAppLanguage(context, 'sw');
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Builder(
                            builder: (context) {
                              if (FFAppState().langIndex == 0) {
                                return Icon(
                                  Icons.radio_button_checked,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                );
                              } else {
                                return Icon(
                                  Icons.radio_button_off,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 24.0,
                                );
                              }
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'fvirzxyl' /* Kiswahili */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color: FFAppState().langIndex == 0
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .tertiary,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().langIndex = 1;
                        safeSetState(() {});
                        setAppLanguage(context, 'en');
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Builder(
                            builder: (context) {
                              if (FFAppState().langIndex == 1) {
                                return Icon(
                                  Icons.radio_button_checked,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                );
                              } else {
                                return Icon(
                                  Icons.radio_button_off,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 24.0,
                                );
                              }
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '6s0s4jvz' /* English */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color: valueOrDefault<Color>(
                                        FFAppState().langIndex == 1
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .tertiary,
                                        FlutterFlowTheme.of(context).tertiary,
                                      ),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                      .divide(SizedBox(height: 16.0))
                      .addToStart(SizedBox(height: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
