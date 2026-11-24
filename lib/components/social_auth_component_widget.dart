import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/ui/app_toast.dart';
import '/backend/api_requests/api_calls.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'social_auth_component_model.dart';
export 'social_auth_component_model.dart';

class SocialAuthComponentWidget extends StatefulWidget {
  const SocialAuthComponentWidget({super.key});

  @override
  State<SocialAuthComponentWidget> createState() =>
      _SocialAuthComponentWidgetState();
}

class _SocialAuthComponentWidgetState extends State<SocialAuthComponentWidget> {
  late SocialAuthComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SocialAuthComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FFButtonWidget(
              onPressed: () async {
                var _shouldSetState = false;
                GoRouter.of(context).prepareAuthEvent();
                final user = await authManager.signInWithGoogle(context);
                if (user == null) {
                  return;
                }
                // The backend verifies this Firebase ID token, so it never trusts a bare email address.
                final googleIdToken =
                    await fb.FirebaseAuth.instance.currentUser?.getIdToken(true);
                if (googleIdToken == null || googleIdToken.isEmpty) {
                  return;
                }
                _model.googleAuthResp = await GeneralGroup.loginCall.call(
                  type: '2',
                  email: currentUserEmail,
                  idToken: googleIdToken,
                  deviceType: '1',
                  deviceToken: '',
                  fullName: currentUserDisplayName,
                  mobileNumber: currentPhoneNumber,
                  image: currentUserPhoto,
                );

                _shouldSetState = true;
                if ((_model.googleAuthResp?.succeeded ?? true)) {
                  if (GeneralGroup.loginCall.statusCode(
                        (_model.googleAuthResp?.jsonBody ?? ''),
                      ) ==
                      200) {
                    FFAppState().isLogin = true;
                    FFAppState().fullname = GeneralGroup.loginCall.fullname(
                      (_model.googleAuthResp?.jsonBody ?? ''),
                    )!;
                    FFAppState().username = GeneralGroup.loginCall.username(
                      (_model.googleAuthResp?.jsonBody ?? ''),
                    )!;
                    FFAppState().authToken = GeneralGroup.loginCall.token(
                          (_model.googleAuthResp?.jsonBody ?? ''),
                        ) ??
                        '';
                    FFAppState().phonenumber =
                        GeneralGroup.loginCall.mobilenumber(
                      (_model.googleAuthResp?.jsonBody ?? ''),
                    )!;
                    FFAppState().bio = GeneralGroup.loginCall.bio(
                      (_model.googleAuthResp?.jsonBody ?? ''),
                    )!;
                    FFAppState().email = currentUserEmail;
                    FFAppState().devicetoken = '';
                    FFAppState().userid = GeneralGroup.loginCall
                        .id(
                          (_model.googleAuthResp?.jsonBody ?? ''),
                        )!
                        .toString();
                    FFAppState().userphoto = GeneralGroup.loginCall.image(
                      (_model.googleAuthResp?.jsonBody ?? ''),
                    )!;
                    FFAppState().joinedat = GeneralGroup.loginCall.createdat(
                      (_model.googleAuthResp?.jsonBody ?? ''),
                    )!;
                    FFAppState().walletcoin = GeneralGroup.loginCall.walletcoin(
                      (_model.googleAuthResp?.jsonBody ?? ''),
                    )!;
                    FFAppState().update(() {});

                    context.pushNamedAuth(
                        HomePageWidget.routeName, context.mounted);

                    AppToast.success(context, 'Umeingia kikamilifu.');
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  } else {
                    AppToast.error(
                      context,
                      GeneralGroup.loginCall.message(
                            (_model.googleAuthResp?.jsonBody ?? ''),
                          ) ??
                          'Imeshindikana kuingia.',
                    );
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }
                } else {
                  AppToast.error(
                    context,
                    'Imeshindikana kuunganisha. Angalia mtandao wako na ujaribu tena.',
                  );
                  if (_shouldSetState) safeSetState(() {});
                  return;
                }

                if (_shouldSetState) safeSetState(() {});
              },
              text: FFLocalizations.of(context).getText(
                'omyauk4s' /* Google */,
              ),
              icon: FaIcon(
                FaIconData(const IconData(/* gofore */ 0xf3a7,
                    fontFamily: 'FontAwesomeBrands',
                    fontPackage: 'font_awesome_flutter')),
                size: 18.0,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 54.0,
                padding: EdgeInsets.all(8.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconColor: FlutterFlowTheme.of(context).error,
                color: FlutterFlowTheme.of(context).secondary,
                textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).tertiary,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                                  fontWeight: FontWeight.w700,
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).borderColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ].divide(SizedBox(height: 12.0)),
        ),
      ),
    );
  }
}
