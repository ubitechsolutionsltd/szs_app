import '/components/balance_component_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/no_notification_yet_comp_widget.dart';
import '/components/play_list_container_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'library_page_widget.dart' show LibraryPageWidget;
import 'package:flutter/material.dart';

class LibraryPageModel extends FlutterFlowModel<LibraryPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for BalanceComponent component.
  late BalanceComponentModel balanceComponentModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for PlayList_ontainer.
  late FlutterFlowDynamicModels<PlayListContainerModel> playListOntainerModels;
  // Model for NoNotificationYetComp component.
  late NoNotificationYetCompModel noNotificationYetCompModel;
  // Model for CustomLoadingIndicator component.
  late CustomLoadingIndicatorModel customLoadingIndicatorModel;

  @override
  void initState(BuildContext context) {
    balanceComponentModel = createModel(context, () => BalanceComponentModel());
    playListOntainerModels =
        FlutterFlowDynamicModels(() => PlayListContainerModel());
    noNotificationYetCompModel =
        createModel(context, () => NoNotificationYetCompModel());
    customLoadingIndicatorModel =
        createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    balanceComponentModel.dispose();
    tabBarController?.dispose();
    playListOntainerModels.dispose();
    noNotificationYetCompModel.dispose();
    customLoadingIndicatorModel.dispose();
  }
}
