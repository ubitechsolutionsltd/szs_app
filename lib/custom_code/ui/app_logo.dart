import 'package:flutter/material.dart';

/// The Simulizi za Sauti logo (blue square, white headphones).
///
/// The logo file is `assets/images/logo_szs.png`. If it is ever missing, a drawn stand-in with the same colours
/// is shown, so screens never break.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 64, this.radius = 18});

  static const String asset = 'assets/images/logo_szs.png';
  static const Color brandBlue = Color(0xFF0071BD);

  final double size;
  final double radius;

  static const double _sourceSize = 640;
  static const double _blueHeight = 626;
  // 8px cream strip above the blue area out of 14px of total slack (8 top + 6 bottom).
  static const double _cropAlignY = 8 / 14 * 2 - 1;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: size,
        height: size,
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          // The source picture has a thin cream border at the top and bottom: show only the blue area.
          child: SizedBox(
            width: _sourceSize,
            height: _blueHeight,
            child: ClipRect(
              child: Align(
                alignment: const Alignment(0, _cropAlignY),
                heightFactor: _blueHeight / _sourceSize,
                child: Image.asset(
                  asset,
                  width: _sourceSize,
                  height: _sourceSize,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Container(
                    width: _sourceSize,
                    height: _blueHeight,
                    color: brandBlue,
                    alignment: Alignment.center,
                    child: const Icon(Icons.headphones_rounded, color: Colors.white, size: 360),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
