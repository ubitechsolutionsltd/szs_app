import '/components/cat_container_three_widget.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'all_categories_page_widget.dart' show AllCategoriesPageWidget;
import 'package:flutter/material.dart';

class AllCategoriesPageModel extends FlutterFlowModel<AllCategoriesPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // Models for CatContainerThree dynamic component.
  late FlutterFlowDynamicModels<CatContainerThreeModel> catContainerThreeModels;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    catContainerThreeModels =
        FlutterFlowDynamicModels(() => CatContainerThreeModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    catContainerThreeModels.dispose();
  }
}
