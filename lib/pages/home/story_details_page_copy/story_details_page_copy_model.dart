import '/backend/api_requests/api_calls.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/episode_list_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'story_details_page_copy_widget.dart' show StoryDetailsPageCopyWidget;
import 'package:flutter/material.dart';

class StoryDetailsPageCopyModel
    extends FlutterFlowModel<StoryDetailsPageCopyWidget> {
  ///  Local state fields for this page.

  bool ismr = true;

  int? selectdIndex = 0;

  List<String> tabsList = ['Queue', 'Lyrics', 'Releted'];
  void addToTabsList(String item) => tabsList.add(item);
  void removeFromTabsList(String item) => tabsList.remove(item);
  void removeAtIndexFromTabsList(int index) => tabsList.removeAt(index);
  void insertAtIndexInTabsList(int index, String item) =>
      tabsList.insert(index, item);
  void updateTabsListAtIndex(int index, Function(String) updateFn) =>
      tabsList[index] = updateFn(tabsList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (AddOrRemoveBookmark)] action in IconButton widget.
  ApiCallResponse? addremoveBookmarkRes;
  // Models for EpisodeListItem dynamic component.
  late FlutterFlowDynamicModels<EpisodeListItemModel> episodeListItemModels;
  // Model for CustomLoadingIndicator component.
  late CustomLoadingIndicatorModel customLoadingIndicatorModel;

  @override
  void initState(BuildContext context) {
    episodeListItemModels =
        FlutterFlowDynamicModels(() => EpisodeListItemModel());
    customLoadingIndicatorModel =
        createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    episodeListItemModels.dispose();
    customLoadingIndicatorModel.dispose();
  }
}
