import '/components/currently_playing_story_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/song_container_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/artist_container_comp/artist_container_comp_widget.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for SongContainer dynamic component.
  late FlutterFlowDynamicModels<SongContainerModel> songContainerModels;
  // Models for ArtistContainerComp dynamic component.
  late FlutterFlowDynamicModels<ArtistContainerCompModel>
      artistContainerCompModels;
  // Model for CurrentlyPlayingStory component.
  late CurrentlyPlayingStoryModel currentlyPlayingStoryModel;
  // Model for CustomLoadingIndicator component.
  late CustomLoadingIndicatorModel customLoadingIndicatorModel;

  @override
  void initState(BuildContext context) {
    songContainerModels = FlutterFlowDynamicModels(() => SongContainerModel());
    artistContainerCompModels =
        FlutterFlowDynamicModels(() => ArtistContainerCompModel());
    currentlyPlayingStoryModel =
        createModel(context, () => CurrentlyPlayingStoryModel());
    customLoadingIndicatorModel =
        createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    songContainerModels.dispose();
    artistContainerCompModels.dispose();
    currentlyPlayingStoryModel.dispose();
    customLoadingIndicatorModel.dispose();
  }
}
