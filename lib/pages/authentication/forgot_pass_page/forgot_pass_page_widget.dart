import '/custom_code/ui/app_components.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'forgot_pass_page_model.dart';
export 'forgot_pass_page_model.dart';

class ForgotPassPageWidget extends StatefulWidget {
  const ForgotPassPageWidget({super.key});

  static String routeName = 'ForgotPassPage';
  static String routePath = '/forgotPassPage';

  @override
  State<ForgotPassPageWidget> createState() => _ForgotPassPageWidgetState();
}

class _ForgotPassPageWidgetState extends State<ForgotPassPageWidget> {
  late ForgotPassPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ForgotPassPageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
              AuthHeader(
                title: 'Rejesha Nywila',
                subtitle: FFLocalizations.of(context).getText('bcrgr35y' /* Andikwa barua pepe utakayotumi... */),
                onBack: () => context.safePop(),
              ),
              Expanded(
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        16.0,
                        0,
                        24.0,
                      ),
                      scrollDirection: Axis.vertical,
                      children: [
                        AppTextField(
                          controller: _model.textController!,
                          focusNode: _model.textFieldFocusNode,
                          hint: FFLocalizations.of(context).getText('jds1z5tn' /* Barua pepe */),
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          validator: _model.textControllerValidator.asValidator(context),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: AppButton(
                            label: FFLocalizations.of(context).getText('viv75x51' /* Endelea */),
                            icon: Icons.arrow_forward_rounded,
                            trailingIcon: true,
                            onPressed: () async {
                              if (_model.formKey.currentState == null ||
                                  !_model.formKey.currentState!.validate()) {
                                return;
                              }

                              context.pushNamed(
                                VerifyCodePageWidget.routeName,
                                queryParameters: {
                                  'emai': serializeParam(
                                    _model.textController.text,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                          ),
                        ),
                      ].divide(SizedBox(height: 24.0)),
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
