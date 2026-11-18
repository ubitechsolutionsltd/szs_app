import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'forgot_pass_page_widget.dart' show ForgotPassPageWidget;
import 'package:flutter/material.dart';

class ForgotPassPageModel extends FlutterFlowModel<ForgotPassPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'nqecveoe' /* Tafadhari ingiza barua pepe sa... */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
