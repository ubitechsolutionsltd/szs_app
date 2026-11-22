import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/social_auth_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  static String routeName = 'LoginPage';
  static String routePath = '/loginPage';

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.linear,
            delay: 50.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, -20.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      16.0,
                      0,
                      0,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 8.0, 20.0, 20.0),
                        child: Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image.asset(
                              'assets/images/app_launcher_icon.png',
                              width: 64.0,
                              height: 64.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'gdn2b1x7' /* Ingia */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 34.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1.5,
                                  ),
                        ).animateOnPageLoad(
                            animationsMap['textOnPageLoadAnimation']!),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Text(
                          'Karibu tena. Ingia ili uendelee kusikiliza simulizi zako.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).gray,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.4,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 32.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController1,
                          focusNode: _model.textFieldFocusNode1,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'nn8dwuu4' /* Barua pepe */,
                            ),
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.3,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              '4gly7jca' /* Barua pepe */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).gray,
                                  fontSize: 17.0,
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
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.textController1Validator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
                          autofocus: false,
                          textInputAction: TextInputAction.done,
                          obscureText: !_model.passwordVisibility,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'vtz9zqyc' /* Nywila */,
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
                              'rq4szjuu' /* Nywila */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).gray,
                                  fontSize: 17.0,
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
                            suffixIcon: InkWell(
                              onTap: () async {
                                safeSetState(() => _model.passwordVisibility =
                                    !_model.passwordVisibility);
                              },
                              focusNode:
                                  _model.textFieldPasswordVisibilityFocusNode2
                                    ..skipTraversal = !(false),
                              child: Icon(
                                _model.passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: FlutterFlowTheme.of(context).gray,
                                size: 20.0,
                              ),
                            ),
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
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 16.0, 20.0, 48.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(ForgotPassPageWidget.routeName);
                            },
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'jg8v9xve' /* Umesahau Nywila ? */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            _model.appleAuthlLoginResponse =
                                await GeneralGroup.loginCall.call(
                              type: '4',
                              email: _model.textController1.text,
                              password: _model.textController2.text,
                              deviceType: '1',
                              deviceToken: '',
                              fullName: currentUserDisplayName,
                              mobileNumber: currentPhoneNumber,
                              image: currentUserPhoto,
                            );

                            _shouldSetState = true;
                            if ((_model.appleAuthlLoginResponse?.succeeded ??
                                    true) ==
                                true) {
                              if (GeneralGroup.loginCall.statusCode(
                                    (_model.appleAuthlLoginResponse?.jsonBody ??
                                        ''),
                                  ) ==
                                  200) {
                                FFAppState().isLogin = true;
                                FFAppState().fullname =
                                    GeneralGroup.loginCall.fullname(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().username =
                                    GeneralGroup.loginCall.username(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().authToken =
                                    GeneralGroup.loginCall.token(
                                          (_model.appleAuthlLoginResponse
                                                  ?.jsonBody ??
                                              ''),
                                        ) ??
                                        '';
                                FFAppState().phonenumber =
                                    GeneralGroup.loginCall.mobilenumber(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().bio = GeneralGroup.loginCall.bio(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().email =
                                    _model.textController1.text;
                                FFAppState().devicetoken =
                                    GeneralGroup.loginCall.devicetoken(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().userid = GeneralGroup.loginCall
                                    .id(
                                      (_model.appleAuthlLoginResponse
                                              ?.jsonBody ??
                                          ''),
                                    )!
                                    .toString();
                                FFAppState().userphoto =
                                    GeneralGroup.loginCall.image(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().joinedat =
                                    GeneralGroup.loginCall.createdat(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().walletcoin =
                                    GeneralGroup.loginCall.walletcoin(
                                  (_model.appleAuthlLoginResponse?.jsonBody ??
                                      ''),
                                )!;
                                FFAppState().update(() {});

                                context.pushNamed(HomePageWidget.routeName);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Successfully Logged In.',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      valueOrDefault<String>(
                                        GeneralGroup.loginCall.message(
                                          (_model.appleAuthlLoginResponse
                                                  ?.jsonBody ??
                                              ''),
                                        ),
                                        'Authentication Failed.',
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Oops ! Technical Error. Try Again.',
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                ),
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'x4nwc5r8' /* Ingia */,
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).gray,
                                ),
                              ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                '0exjuge8' /* Au */,
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
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).gray,
                                ),
                              ),
                            ),
                          ]
                              .divide(SizedBox(width: 8.0))
                              .addToStart(SizedBox(width: 20.0))
                              .addToEnd(SizedBox(width: 20.0)),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.socialAuthComponentModel,
                        updateCallback: () => safeSetState(() {}),
                        child: SocialAuthComponentWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: FFLocalizations.of(context).getText(
                          'ongo8hnn' /* Hauna akaunti ? */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SF Pro Display',
                              color: FlutterFlowTheme.of(context).tertiary,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      TextSpan(
                        text: FFLocalizations.of(context).getText(
                          'ybm2n8lx' /* Jisajili */,
                        ),
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.normal,
                          fontSize: 17.0,
                          height: 1.2,
                        ),
                        mouseCursor: SystemMouseCursors.click,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            context.pushNamed(SignupPageWidget.routeName);
                          },
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SF Pro Display',
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          lineHeight: 1.2,
                        ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
