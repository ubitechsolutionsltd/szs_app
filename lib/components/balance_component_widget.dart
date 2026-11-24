import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'balance_component_model.dart';
export 'balance_component_model.dart';

class BalanceComponentWidget extends StatefulWidget {
  const BalanceComponentWidget({super.key});

  @override
  State<BalanceComponentWidget> createState() => _BalanceComponentWidgetState();
}

class _BalanceComponentWidgetState extends State<BalanceComponentWidget> {
  late BalanceComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BalanceComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          formatNumber(
            FFAppState().walletcoin,
            formatType: FormatType.decimal,
            decimalType: DecimalType.periodDecimal,
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'SF Pro Display',
                color: FlutterFlowTheme.of(context).tertiary,
                fontSize: 17.0,
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FFButtonWidget(
              onPressed: () async {
                var _shouldSetState = false;
                _model.loginForBalanceInLibararyPage =
                    await GeneralGroup.meCall.call();

                _shouldSetState = true;
                if (GeneralGroup.loginCall.walletcoin(
                      (_model.loginForBalanceInLibararyPage?.jsonBody ?? ''),
                    ) !=
                    null) {
                  if (GeneralGroup.loginCall.walletcoin(
                        (_model.loginForBalanceInLibararyPage?.jsonBody ?? ''),
                      ) !=
                      null) {
                    FFAppState().walletcoin = GeneralGroup.loginCall.walletcoin(
                      (_model.loginForBalanceInLibararyPage?.jsonBody ?? ''),
                    )!;
                    safeSetState(() {});
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          trs('tech_try_later'),
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: Colors.white,
                          ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        trs('tech_try_later'),
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).error,
                    ),
                  );
                  if (_shouldSetState) safeSetState(() {});
                  return;
                }

                if (_shouldSetState) safeSetState(() {});
              },
              text: FFLocalizations.of(context).getText(
                'dxcpkfka' /* Salio  */,
              ),
              icon: Icon(
                Icons.refresh,
                size: 15.0,
              ),
              options: FFButtonOptions(
                height: 30.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconAlignment: IconAlignment.end,
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).tertiary,
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ].divide(SizedBox(width: 10.0)),
        ),
      ].divide(SizedBox(height: 7.0)),
    );
  }
}
