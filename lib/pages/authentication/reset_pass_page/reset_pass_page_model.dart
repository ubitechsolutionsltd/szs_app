import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reset_pass_page_widget.dart' show ResetPassPageWidget;
import 'package:flutter/material.dart';

class ResetPassPageModel extends FlutterFlowModel<ResetPassPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // State field(s) for TextField widget.
  late FocusNode textFieldPasswordVisibilityFocusNode1;
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'spbo1zcl' /* Please enter valid new passwor... */,
      );
    }

    return null;
  }

  // State field(s) for TextField widget.
  late FocusNode textFieldPasswordVisibilityFocusNode2;
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController2Validator;
  String? _textController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'caxj8eoj' /* Please enter valid confirm pas... */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    textFieldPasswordVisibilityFocusNode1 = FocusNode();
    passwordVisibility1 = false;
    textController1Validator = _textController1Validator;
    textFieldPasswordVisibilityFocusNode2 = FocusNode();
    passwordVisibility2 = false;
    textController2Validator = _textController2Validator;
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();
    textFieldPasswordVisibilityFocusNode1.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
    textFieldPasswordVisibilityFocusNode2.dispose();
  }
}
