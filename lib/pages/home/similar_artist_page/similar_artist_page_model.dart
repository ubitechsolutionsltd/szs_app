import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/artist_container_comp/artist_container_comp_widget.dart';
import 'similar_artist_page_widget.dart' show SimilarArtistPageWidget;
import 'package:flutter/material.dart';

class SimilarArtistPageModel extends FlutterFlowModel<SimilarArtistPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // Models for ArtistContainerComp dynamic component.
  late FlutterFlowDynamicModels<ArtistContainerCompModel>
      artistContainerCompModels;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    artistContainerCompModels =
        FlutterFlowDynamicModels(() => ArtistContainerCompModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    artistContainerCompModels.dispose();
  }
}
