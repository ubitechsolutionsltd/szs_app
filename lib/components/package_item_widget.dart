import '/custom_code/ui/app_palette.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package_item_model.dart';
export 'package_item_model.dart';

/// Package Item
class PackageItemWidget extends StatefulWidget {
  const PackageItemWidget({
    super.key,
    required this.package,
  });

  final PackageStruct? package;

  @override
  State<PackageItemWidget> createState() => _PackageItemWidgetState();
}

class _PackageItemWidgetState extends State<PackageItemWidget> {
  late PackageItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackageItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  static String _money(num value) {
    final digits = value.round().toString();
    final grouped = digits.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return 'TZS $grouped';
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final package = widget.package;
    final coins = package?.coin ?? 0;
    final price = package?.price ?? 0;
    final perCoin = coins > 0 ? price / coins : 0;

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: palette.solid.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: palette.outline, width: 0.8),
        ),
        child: Row(
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [palette.warning, Color.lerp(palette.warning, Colors.deepOrange, 0.55)!],
                ),
                boxShadow: [
                  BoxShadow(color: palette.warning.withValues(alpha: 0.4), blurRadius: 12.0, offset: Offset(0.0, 5.0)),
                ],
              ),
              child: Icon(Icons.toll_rounded, color: Colors.white, size: 30.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(package?.name, 'Kifurushi'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyLarge.override(
                      fontFamily: 'SF Pro Display',
                      color: palette.text,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    trs('coins_n', args: {'n': '$coins'}),
                    style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: palette.warning,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.0,
                    ),
                  ),
                  if (perCoin > 0)
                    Text(
                      trs('per_coin', args: {'price': perCoin.toStringAsFixed(perCoin >= 100 ? 0 : 1)}),
                      style: theme.bodySmall.override(
                        fontFamily: 'SF Pro Display',
                        color: palette.muted,
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 11.0),
              decoration: BoxDecoration(
                color: palette.accent,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(color: palette.accent.withValues(alpha: 0.35), blurRadius: 10.0, offset: Offset(0.0, 4.0)),
                ],
              ),
              child: Text(
                _money(price),
                style: theme.titleSmall.override(
                  fontFamily: 'SF Pro Display',
                  color: palette.onAccent,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
