import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'song_details_page_widget.dart' show SongDetailsPageWidget;
import 'package:flutter/material.dart';

class SongDetailsPageModel extends FlutterFlowModel<SongDetailsPageWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
