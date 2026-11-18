import '/backend/api_requests/api_calls.dart';
import '/components/balance_component_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/package_item_widget.dart';
import '/components/package_payment_success_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package_lists_component_model.dart';
export 'package_lists_component_model.dart';

class PackageListsComponentWidget extends StatefulWidget {
  const PackageListsComponentWidget({
    super.key,
    this.episode,
  });

  final dynamic episode;

  @override
  State<PackageListsComponentWidget> createState() =>
      _PackageListsComponentWidgetState();
}

class _PackageListsComponentWidgetState
    extends State<PackageListsComponentWidget> {
  late PackageListsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackageListsComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17.0, 5.0, 17.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'vo9pw1aw' /* Vifurushi */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'rv2yhosj' /* Vifurushi vilivyopo */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'SF Pro Display',
                                color: FlutterFlowTheme.of(context).tertiary,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      child: wrapWithModel(
                        model: _model.balanceComponentModel,
                        updateCallback: () => safeSetState(() {}),
                        child: BalanceComponentWidget(),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<ApiCallResponse>(
                future:
                    (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
                          ..complete(GeneralGroup.packagesCall.call()))
                        .future,
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  final listViewPackagesResponse = snapshot.data!;

                  return Builder(
                    builder: (context) {
                      final packages = GeneralGroup.packagesCall
                              .result(
                                listViewPackagesResponse.jsonBody,
                              )
                              ?.toList() ??
                          [];

                      return RefreshIndicator(
                        color: FlutterFlowTheme.of(context).primary,
                        onRefresh: () async {
                          safeSetState(() => _model.apiRequestCompleter = null);
                          await _model.waitForApiRequestCompleted();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: packages.length,
                          itemBuilder: (context, packagesIndex) {
                            final packagesItem = packages[packagesIndex];
                            return Builder(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var _shouldSetState = false;
                                    FFAppState().isLoading = true;
                                    FFAppState().update(() {});
                                    _model.payforPackageResponse =
                                        await GeneralGroup.payForPackageCall
                                            .call(
                                      userId: FFAppState().userid,
                                      packageId: PackageStruct.maybeFromMap(
                                              packagesItem)
                                          ?.id
                                          .toString(),
                                    );

                                    _shouldSetState = true;
                                    FFAppState().isLoading = false;
                                    FFAppState().update(() {});
                                    if ((_model
                                            .payforPackageResponse?.succeeded ??
                                        true)) {
                                      if (GeneralGroup.payForPackageCall
                                                  .trnpaymentlink(
                                                (_model.payforPackageResponse
                                                        ?.jsonBody ??
                                                    ''),
                                              ) !=
                                              null &&
                                          GeneralGroup.payForPackageCall
                                                  .trnpaymentlink(
                                                (_model.payforPackageResponse
                                                        ?.jsonBody ??
                                                    ''),
                                              ) !=
                                              '') {
                                        showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: WebViewAware(
                                                child:
                                                    PackagePaymentSuccessWidget(
                                                  amount: PackageStruct
                                                          .maybeFromMap(
                                                              packagesItem)!
                                                      .price
                                                      .toString(),
                                                  lipanumber: GeneralGroup
                                                      .payForPackageCall
                                                      .lipanumber(
                                                    (_model.payforPackageResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!,
                                                  paymentlink: GeneralGroup
                                                      .payForPackageCall
                                                      .trnpaymentlink(
                                                    (_model.payforPackageResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!,
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return WebViewAware(
                                              child: AlertDialog(
                                                title:
                                                    Text('Tatizo la Kiufundi'),
                                                content: Text(
                                                    'Imeshindwa Kupata Link ya Malipo'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Sawa'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return WebViewAware(
                                            child: AlertDialog(
                                              title: Text('Tatizo la Kiufundi'),
                                              content: Text(
                                                  'Imeshindwa Kupata Taarifa za Malipo'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Sawa'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }

                                    if (_shouldSetState) safeSetState(() {});
                                  },
                                  child: wrapWithModel(
                                    model: _model.packageItemModels.getModel(
                                      getJsonField(
                                        packagesItem,
                                        r'''$.id''',
                                      ).toString(),
                                      packagesIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: PackageItemWidget(
                                      key: Key(
                                        'Keykus_${getJsonField(
                                          packagesItem,
                                          r'''$.id''',
                                        ).toString()}',
                                      ),
                                      package: PackageStruct.maybeFromMap(
                                          packagesItem)!,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        if (FFAppState().isLoading)
          Opacity(
            opacity: 0.6,
            child: wrapWithModel(
              model: _model.customLoadingIndicatorModel,
              updateCallback: () => safeSetState(() {}),
              child: CustomLoadingIndicatorWidget(),
            ),
          ),
      ],
    );
  }
}
