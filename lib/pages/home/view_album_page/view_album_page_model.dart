import '/backend/api_requests/api_calls.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'view_album_page_widget.dart' show ViewAlbumPageWidget;
import 'package:flutter/material.dart';

class ViewAlbumPageModel extends FlutterFlowModel<ViewAlbumPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // Stores action output result for [Backend Call - API (EpisodesAudioByContent)] action in Container widget.
  ApiCallResponse? storyEpisodesResp;
  // Model for CustomLoadingIndicator component.
  late CustomLoadingIndicatorModel customLoadingIndicatorModel;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    customLoadingIndicatorModel =
        createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    customLoadingIndicatorModel.dispose();
  }
}
