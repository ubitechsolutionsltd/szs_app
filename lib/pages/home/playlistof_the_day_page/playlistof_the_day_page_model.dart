import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/artist_container_playlist_comp/artist_container_playlist_comp_widget.dart';
import '/index.dart';
import 'playlistof_the_day_page_widget.dart' show PlaylistofTheDayPageWidget;
import 'package:flutter/material.dart';

class PlaylistofTheDayPageModel
    extends FlutterFlowModel<PlaylistofTheDayPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // Models for ArtistContainerPlaylistComp dynamic component.
  late FlutterFlowDynamicModels<ArtistContainerPlaylistCompModel>
      artistContainerPlaylistCompModels;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
    artistContainerPlaylistCompModels =
        FlutterFlowDynamicModels(() => ArtistContainerPlaylistCompModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    artistContainerPlaylistCompModels.dispose();
  }
}
