import '/components/custom_center_app_bar_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/song_container_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sub_cat_list_page_widget.dart' show SubCatListPageWidget;
import 'package:flutter/material.dart';

class SubCatListPageModel extends FlutterFlowModel<SubCatListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // Models for SongContainer dynamic component.
  late FlutterFlowDynamicModels<SongContainerModel> songContainerModels;
  // Model for CustomLoadingIndicator component.
  late CustomLoadingIndicatorModel customLoadingIndicatorModel;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    songContainerModels = FlutterFlowDynamicModels(() => SongContainerModel());
    customLoadingIndicatorModel =
        createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    songContainerModels.dispose();
    customLoadingIndicatorModel.dispose();
  }
}
