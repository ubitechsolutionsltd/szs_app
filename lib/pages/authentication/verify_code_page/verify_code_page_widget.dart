import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'verify_code_page_model.dart';
export 'verify_code_page_model.dart';

class VerifyCodePageWidget extends StatefulWidget {
  const VerifyCodePageWidget({
    super.key,
    required this.emai,
  });

  final String? emai;

  static String routeName = 'VerifyCodePage';
  static String routePath = '/verifyCodePage';

  @override
  State<VerifyCodePageWidget> createState() => _VerifyCodePageWidgetState();
}

class _VerifyCodePageWidgetState extends State<VerifyCodePageWidget> {
  late VerifyCodePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerifyCodePageModel());

    _model.pinCodeFocusNode ??= FocusNode();
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
                        return 'Verify code';
                      } else if (FFAppState().langIndex == 1) {
                        return 'कोड सत्यापित करें';
                      } else {
                        return 'التحقق من كود';
                      }
                    }(),
                    'Verify code',
                  ),
                  backIcon: false,
                  addIcon: false,
                  onTapAdd: () async {},
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 16.0, 20.0, 32.0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: FFLocalizations.of(context).getText(
                                '6zfweh9y' /* The confimation code was sent ... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.5,
                                  ),
                            ),
                            TextSpan(
                              text: valueOrDefault<String>(
                                widget.emai,
                                'johnabram@gmail.com',
                              ),
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 17.0,
                              ),
                            )
                          ],
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.5,
                              ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 20.0),
                        child: PinCodeTextField(
                          autoDisposeControllers: false,
                          appContext: context,
                          length: 6,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                letterSpacing: 0.0,
                              ),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          enableActiveFill: false,
                          autoFocus: true,
                          focusNode: _model.pinCodeFocusNode,
                          enablePinAutofill: false,
                          errorTextSpace: 16.0,
                          showCursor: true,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          pinTheme: PinTheme(
                            fieldHeight: 50.0,
                            fieldWidth: 50.0,
                            borderWidth: 1.0,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            shape: PinCodeFieldShape.box,
                            activeColor: Color(0xFFC5C5C5),
                            inactiveColor: Color(0xFFC5C5C5),
                            selectedColor: Color(0xFFC5C5C5),
                          ),
                          controller: _model.pinCodeController,
                          onChanged: (_) {},
                          autovalidateMode: AutovalidateMode.disabled,
                          validator: _model.pinCodeControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 48.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: FFLocalizations.of(context).getText(
                                  'g6fodzyt' /* Don’t get the code?  */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SF Pro Display',
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      lineHeight: 1.5,
                                    ),
                              ),
                              TextSpan(
                                text: FFLocalizations.of(context).getText(
                                  'bdathw2i' /* Resend code */,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17.0,
                                  height: 1.5,
                                ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }

                          context.pushNamed(ResetPassPageWidget.routeName);
                        },
                        text: FFLocalizations.of(context).getText(
                          '0hus5k3h' /* Continue */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 54.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
