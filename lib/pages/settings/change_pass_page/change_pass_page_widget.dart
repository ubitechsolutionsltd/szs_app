import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_pass_page_model.dart';
export 'change_pass_page_model.dart';

class ChangePassPageWidget extends StatefulWidget {
  const ChangePassPageWidget({super.key});

  static String routeName = 'ChangePassPage';
  static String routePath = '/changePassPage';

  @override
  State<ChangePassPageWidget> createState() => _ChangePassPageWidgetState();
}

class _ChangePassPageWidgetState extends State<ChangePassPageWidget> {
  late ChangePassPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangePassPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: valueOrDefault<String>(
                    () {
                      if (FFAppState().langIndex == 0) {
                        return 'Change password';
                      } else if (FFAppState().langIndex == 1) {
                        return 'पासवर्ड बदलें';
                      } else {
                        return 'تغيير كلمة المرور';
                      }
                    }(),
                    'Change password',
                  ),
                  backIcon: false,
                  addIcon: false,
                  onTapAdd: () async {},
                ),
              ),
              Expanded(
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      24.0,
                      0,
                      24.0,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController1,
                          focusNode: _model.textFieldFocusNode1,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              '3hktdhyo' /* New password */,
                            ),
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              '7gkibsd5' /* New password */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).gray,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.5,
                                ),
                            errorStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).error,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF2E3833),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context).secondary,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            hoverColor: Colors.transparent,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.5,
                              ),
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.textController1Validator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              '8toq78qv' /* Confirm password */,
                            ),
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              's1tc1aqp' /* Confirm password */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).gray,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.5,
                                ),
                            errorStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).error,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF2E3833),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context).secondary,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            hoverColor: Colors.transparent,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.5,
                              ),
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.textController2Validator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 32.0, 20.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            if (_model.textController1.text ==
                                _model.textController2.text) {
                              FFAppState().updateUserInfoStruct(
                                (e) =>
                                    e..password = _model.textController1.text,
                              );
                              FFAppState().update(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Your password successfully changed',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'SF Pro Display',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );

                              context.goNamed(SettingPageWidget.routeName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'both password not same',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'SF Pro Display',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            }
                          },
                          text: FFLocalizations.of(context).getText(
                            't6iq9mry' /* Save */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 54.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
