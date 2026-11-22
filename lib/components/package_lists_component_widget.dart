import '/custom_code/ui/glass.dart';
import '/custom_code/ui/app_palette.dart';
import '/backend/api_requests/api_calls.dart';
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

    return Glass(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      blur: 30.0,
      strong: true,
      shadow: false,
      child: Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.0, bottom: 14.0),
                child: Container(
                  width: 44.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: AppPalette.of(context).outline,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jaza kibubu',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'SF Pro Display',
                                  color: AppPalette.of(context).text,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'Chagua kifurushi cha sarafu',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'SF Pro Display',
                                  color: AppPalette.of(context).muted,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: AppPalette.of(context).warning.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: AppPalette.of(context).warning.withValues(alpha: 0.5), width: 0.8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.toll_rounded, color: AppPalette.of(context).warning, size: 20.0),
                          SizedBox(width: 6.0),
                          Text(
                            '${FFAppState().walletcoin}',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'SF Pro Display',
                                  color: AppPalette.of(context).text,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
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
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 14.0, 24.0, 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline_rounded, size: 15.0, color: AppPalette.of(context).muted),
                    SizedBox(width: 6.0),
                    Flexible(
                      child: Text(
                        'Malipo ni salama kupitia Selcom',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'SF Pro Display',
                              color: AppPalette.of(context).muted,
                              fontSize: 12.5,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ],
                ),
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
    ),
    );
  }
}
