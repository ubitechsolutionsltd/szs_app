import '/custom_code/ui/app_components.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/social_auth_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'signup_page_model.dart';
export 'signup_page_model.dart';

class SignupPageWidget extends StatefulWidget {
  const SignupPageWidget({super.key});

  static String routeName = 'SignupPage';
  static String routePath = '/signupPage';

  @override
  State<SignupPageWidget> createState() => _SignupPageWidgetState();
}

class _SignupPageWidgetState extends State<SignupPageWidget>
    with TickerProviderStateMixin {
  late SignupPageModel _model;
  bool _loading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignupPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldMask1 = MaskTextInputFormatter(
        mask: 'AAAAAAAAAA AAAAAAAAAA',
        initialText: _model.textController1?.text);
    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textFieldMask2 = MaskTextInputFormatter(
        mask: '##########', initialText: _model.textController2?.text);
    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

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
                      24.0,
                      0,
                      24.0,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      AuthHeader(
                        title: FFLocalizations.of(context).getText('ulmedo12' /* Jisajili */),
                        subtitle: 'Fungua akaunti yako ili usikilize simulizi za Kiswahili.',
                        onBack: () => context.safePop(),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController1!,
                          focusNode: _model.textFieldFocusNode1,
                          hint: FFLocalizations.of(context).getText('qtk3q5ro' /* Jina kamili */),
                          icon: Icons.person_outline_rounded,
                          textInputAction: TextInputAction.next,
                          validator: _model.textController1Validator.asValidator(context),
                        ),
                      ),

                                            Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController2!,
                          focusNode: _model.textFieldFocusNode2,
                          hint: FFLocalizations.of(context).getText('o7brnlux' /* Nambari ya simu */),
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: _model.textController2Validator.asValidator(context),
                        ),
                      ),

                                            Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController3!,
                          focusNode: _model.textFieldFocusNode3,
                          hint: FFLocalizations.of(context).getText('59uyb1a3' /* Barua pepe */),
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: _model.textController3Validator.asValidator(context),
                        ),
                      ),

                                            Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController4!,
                          focusNode: _model.textFieldFocusNode4,
                          hint: FFLocalizations.of(context).getText('zkpe8jnx' /* Nywila */),
                          icon: Icons.lock_outline_rounded,
                          obscure: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validator: _model.textController4Validator.asValidator(context),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 48.0, 20.0, 0.0),
                        child: AppButton(
                          loading: _loading,
                          label: FFLocalizations.of(context).getText('x4pwu6ka' /* Jisajili */),
                          onPressed: () async {
                            if (_loading) return;
                            safeSetState(() => _loading = true);
                            try {
                            var _shouldSetState = false;
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            _model.signUpResponse =
                                await GeneralGroup.registerCall.call(
                              email: _model.textController3.text,
                              fullName: _model.textController1.text,
                              mobileNumber: _model.textController2.text,
                              password: _model.textController4.text,
                              deviceType: '1',
                            );

                            _shouldSetState = true;
                            if ((_model.signUpResponse?.succeeded ?? true)) {
                              if (GeneralGroup.loginCall.statusCode(
                                    (_model.signUpResponse?.jsonBody ?? ''),
                                  ) ==
                                  200) {
                                FFAppState().isLogin = true;
                                FFAppState().fullname =
                                    GeneralGroup.loginCall.fullname(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().username =
                                    GeneralGroup.loginCall.username(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().authToken =
                                    GeneralGroup.loginCall.token(
                                          (_model.signUpResponse?.jsonBody ??
                                              ''),
                                        ) ??
                                        '';
                                FFAppState().phonenumber =
                                    GeneralGroup.loginCall.mobilenumber(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().bio = GeneralGroup.loginCall.bio(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().email =
                                    _model.textController3.text;
                                FFAppState().devicetoken =
                                    GeneralGroup.loginCall.devicetoken(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().userid = GeneralGroup.loginCall
                                    .id(
                                      (_model.signUpResponse?.jsonBody ?? ''),
                                    )!
                                    .toString();
                                FFAppState().userphoto =
                                    GeneralGroup.loginCall.image(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().joinedat =
                                    GeneralGroup.loginCall.createdat(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().walletcoin =
                                    GeneralGroup.loginCall.walletcoin(
                                  (_model.signUpResponse?.jsonBody ?? ''),
                                )!;
                                FFAppState().update(() {});

                                context.pushNamed(HomePageWidget.routeName);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Successfully Logged In.',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.white,
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
                                      GeneralGroup.loginCall.message(
                                        (_model.signUpResponse?.jsonBody ?? ''),
                                      )!,
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.white,
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
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }

                            if (_shouldSetState) safeSetState(() {});
                          } finally {
                              if (mounted) safeSetState(() => _loading = false);
                            }
                          },
                        ),
                      ),
                      LabeledDivider(label: FFLocalizations.of(context).getText('6yippc7s' /* Au */)),
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
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 24.0),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: FFLocalizations.of(context).getText(
                          'vk4bn3cf' /* Tayari una akaunti ?  */,
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
                          '19gzc2d1' /* Ingia. */,
                        ),
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w800,
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                            ),
                        mouseCursor: SystemMouseCursors.click,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            context.safePop();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
