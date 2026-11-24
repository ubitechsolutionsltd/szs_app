import '/custom_code/ui/app_components.dart';
import '/components/password_succsess_alrt_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'reset_pass_page_model.dart';
export 'reset_pass_page_model.dart';

class ResetPassPageWidget extends StatefulWidget {
  const ResetPassPageWidget({super.key});

  static String routeName = 'ResetPassPage';
  static String routePath = '/resetPassPage';

  @override
  State<ResetPassPageWidget> createState() => _ResetPassPageWidgetState();
}

class _ResetPassPageWidgetState extends State<ResetPassPageWidget> {
  late ResetPassPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetPassPageModel());

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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AuthHeader(
                title: 'Nywila Mpya',
                subtitle: 'Weka nywila mpya ili uendelee kusikiliza simulizi zako.',
                onBack: () => context.safePop(),
              ),
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
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController1!,
                          focusNode: _model.textFieldFocusNode1,
                          hint: FFLocalizations.of(context).getText('x076kttg' /* New password */),
                          icon: Icons.lock_outline_rounded,
                          obscure: true,
                          textInputAction: TextInputAction.next,
                          validator: _model.textController1Validator.asValidator(context),
                        ),
                      ),

                                            Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                        child: AppTextField(
                          controller: _model.textController2!,
                          focusNode: _model.textFieldFocusNode2,
                          hint: FFLocalizations.of(context).getText('lcitwxqm' /* Confirm password */),
                          icon: Icons.lock_outline_rounded,
                          obscure: true,
                          textInputAction: TextInputAction.next,
                          validator: _model.textController2Validator.asValidator(context),
                        ),
                      ),

                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 32.0, 20.0, 0.0),
                          child: AppButton(
 label: FFLocalizations.of(context).getText('4nm3sliq'),
 icon: Icons.arrow_forward_rounded,
 trailingIcon: true,
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
                                safeSetState(() {});
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: WebViewAware(
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: PasswordSuccsessAlrtWidget(
                                            onTapLogin: () async {
                                              Navigator.pop(context);

                                              context.goNamed(
                                                  LoginPageWidget.routeName);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Both password not same',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'SF Pro Display',
                                            color: Colors.white,
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
 ),
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
