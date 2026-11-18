import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'security_page_widget.dart' show SecurityPageWidget;
import 'package:flutter/material.dart';

class SecurityPageModel extends FlutterFlowModel<SecurityPageWidget> {
  ///  Local state fields for this page.

  bool faceid = false;

  bool notiification = true;

  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
  }
}
