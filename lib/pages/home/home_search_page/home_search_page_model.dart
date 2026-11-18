import '/backend/api_requests/api_calls.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/song_container_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_search_page_widget.dart' show HomeSearchPageWidget;
import 'package:flutter/material.dart';

class HomeSearchPageModel extends FlutterFlowModel<HomeSearchPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Search)] action in searchField widget.
  ApiCallResponse? searchResponse;
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
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();

    songContainerModels.dispose();
    customLoadingIndicatorModel.dispose();
  }
}
