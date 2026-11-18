import '/backend/api_requests/api_calls.dart';
import '/components/balance_component_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/package_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package_lists_component_widget.dart' show PackageListsComponentWidget;
import 'package:flutter/material.dart';

class PackageListsComponentModel
    extends FlutterFlowModel<PackageListsComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for BalanceComponent component.
  late BalanceComponentModel balanceComponentModel;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Models for PackageItem dynamic component.
  late FlutterFlowDynamicModels<PackageItemModel> packageItemModels;
  // Stores action output result for [Backend Call - API (PayForPackage)] action in PackageItem widget.
  ApiCallResponse? payforPackageResponse;
  // Model for CustomLoadingIndicator component.
  late CustomLoadingIndicatorModel customLoadingIndicatorModel;

  @override
  void initState(BuildContext context) {
    balanceComponentModel = createModel(context, () => BalanceComponentModel());
    packageItemModels = FlutterFlowDynamicModels(() => PackageItemModel());
    customLoadingIndicatorModel =
        createModel(context, () => CustomLoadingIndicatorModel());
  }

  @override
  void dispose() {
    balanceComponentModel.dispose();
    packageItemModels.dispose();
    customLoadingIndicatorModel.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
