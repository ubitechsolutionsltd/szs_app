import '/components/balance_component_widget.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_profile_page_widget.dart' show MyProfilePageWidget;
import 'package:flutter/material.dart';

class MyProfilePageModel extends FlutterFlowModel<MyProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // Model for BalanceComponent component.
  late BalanceComponentModel balanceComponentModel;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    balanceComponentModel = createModel(context, () => BalanceComponentModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    balanceComponentModel.dispose();
  }
}
