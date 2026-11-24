import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_toast.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/social_auth_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  bool _loading = false;

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
        backgroundColor: Colors.transparent,
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
                      AuthHeader(
                        title: FFLocalizations.of(context).getText('gdn2b1x7' /* Ingia */),
                        subtitle: trs('login_sub'),
                        onBack: () => context.safePop(),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController1!,
                          focusNode: _model.textFieldFocusNode1,
                          hint: FFLocalizations.of(context).getText('4gly7jca' /* Barua pepe */),
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: _model.textController1Validator.asValidator(context),
                        ),
                      ),

                                            Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController2!,
                          focusNode: _model.textFieldFocusNode2,
                          hint: FFLocalizations.of(context).getText('rq4szjuu' /* Nywila */),
                          icon: Icons.lock_outline_rounded,
                          obscure: true,
                          textInputAction: TextInputAction.done,
                          validator: _model.textController2Validator.asValidator(context),
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
                        child: AppButton(
                          loading: _loading,
                          label: FFLocalizations.of(context).getText('x4nwc5r8' /* Ingia */),
                          onPressed: () async {
                            if (_loading) return;
                            safeSetState(() => _loading = true);
                            try {
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

                                AppToast.success(context, trs('login_ok'));
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              } else {
                                AppToast.error(
                                  context,
                                  valueOrDefault<String>(
                                    GeneralGroup.loginCall.message(
                                      (_model.appleAuthlLoginResponse
                                              ?.jsonBody ??
                                          ''),
                                    ),
                                    trs('login_failed'),
                                  ),
                                );
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }
                            } else {
                              // Say what the server actually answered, so a failure can be diagnosed
                              // instead of looking like a generic network problem.
                              final status = _model.appleAuthlLoginResponse?.statusCode;
                              final bodyMsg = GeneralGroup.loginCall.message(
                                  (_model.appleAuthlLoginResponse?.jsonBody ?? ''));
                              AppToast.error(
                                context,
                                (bodyMsg != null && bodyMsg.isNotEmpty)
                                    ? bodyMsg
                                    : '${trs('connect_failed')} (${status == null || status < 0 ? 'no response' : 'HTTP $status'})',
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }

                            if (_shouldSetState) safeSetState(() {});
                          } catch (e) {
                            if (mounted) AppToast.error(context, '${trs('tech_try_later')} ($e)');
                          } finally {
                              if (mounted) safeSetState(() => _loading = false);
                            }
                          },
                        ),
                      ),
                      LabeledDivider(label: FFLocalizations.of(context).getText('0exjuge8' /* Au */)),
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
                        text: ' ' + FFLocalizations.of(context).getText(
                          'ybm2n8lx' /* Jisajili */,
                        ),
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.w800,
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
