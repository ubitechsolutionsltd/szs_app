import '/backend/api_requests/api_calls.dart';
import '/components/social_auth_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'a1mkaptj' /* Tafadhari jaza barua pepe sahi... */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'h3holdcg' /* Tafadhari jaza barua pepe sahi... */,
      );
    }
    return null;
  }

  // State field(s) for TextField widget.
  late FocusNode textFieldPasswordVisibilityFocusNode2;
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController2Validator;
  String? _textController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '381lm5sj' /* Tafadharinweka nywila sahihi */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Login)] action in Button widget.
  ApiCallResponse? appleAuthlLoginResponse;
  // Model for socialAuthComponent component.
  late SocialAuthComponentModel socialAuthComponentModel;

  @override
  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
    textFieldPasswordVisibilityFocusNode2 = FocusNode();
    passwordVisibility = false;
    textController2Validator = _textController2Validator;
    socialAuthComponentModel =
        createModel(context, () => SocialAuthComponentModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
    textFieldPasswordVisibilityFocusNode2.dispose();
    socialAuthComponentModel.dispose();
  }
}
