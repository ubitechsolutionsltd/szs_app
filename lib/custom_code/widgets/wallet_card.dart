// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '/app_state.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/package_lists_component_widget.dart';
import '/custom_code/ui/app_palette.dart';

/// Coin balance card with refresh and top-up, shared by the profile and library screens.
class WalletCard extends StatelessWidget {
  const WalletCard({super.key, this.width, this.height});

  final double? width;
  final double? height;

  Future<void> _refresh() async {
    final response = await GeneralGroup.meCall.call();
    final coin = GeneralGroup.loginCall.walletcoin(response.jsonBody);
    if (coin != null) {
      FFAppState().walletcoin = coin;
      FFAppState().update(() {});
    }
  }

  Future<void> _topUp(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return WebViewAware(
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.75,
              child: PackageListsComponentWidget(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    context.watch<FFAppState>();

    const onGradient = Colors.white;

    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpace.radiusLg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [palette.accent, Color.lerp(palette.accent, Colors.black, 0.5)!],
        ),
        boxShadow: [BoxShadow(color: palette.accent.withValues(alpha: 0.28), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            const Icon(Icons.toll_rounded, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Salio lako',
                  style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0)),
            ),
            IconButton(
              tooltip: 'Onyesha upya',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.refresh_rounded, color: onGradient),
              onPressed: _refresh,
            ),
          ]),
          const SizedBox(height: 4),
          Text('${FFAppState().walletcoin}',
              style: theme.bodyMedium.override(
                  fontFamily: 'SF Pro Display',
                  color: onGradient,
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1)),
          Text('sarafu',
              style: theme.bodyMedium
                  .override(fontFamily: 'SF Pro Display', color: Colors.white70, fontSize: 14, letterSpacing: 0)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: palette.accent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: const Text('Jaza kibubu',
                  style: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w800)),
              onPressed: () => _topUp(context),
            ),
          ),
        ],
      ),
    );
  }
}
