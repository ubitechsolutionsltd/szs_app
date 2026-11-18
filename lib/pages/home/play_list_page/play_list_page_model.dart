import '/components/custom_center_app_bar_widget.dart';
import '/components/play_list_container_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'play_list_page_widget.dart' show PlayListPageWidget;
import 'package:flutter/material.dart';

class PlayListPageModel extends FlutterFlowModel<PlayListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // Models for PlayListContainer dynamic component.
  late FlutterFlowDynamicModels<PlayListContainerModel> playListContainerModels;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    playListContainerModels =
        FlutterFlowDynamicModels(() => PlayListContainerModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    playListContainerModels.dispose();
  }
}
