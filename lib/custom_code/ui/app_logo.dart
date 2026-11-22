import 'package:flutter/material.dart';

/// The Simulizi za Sauti logo (blue square, white headphones).
///
/// Put the logo file at `assets/images/logo_szs.png`. Until it is there, a drawn stand-in with the same colours
/// is shown, so screens never break.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 64, this.radius = 18});

  static const String asset = 'assets/images/logo_szs.png';
  static const Color brandBlue = Color(0xFF0070C0);

  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          color: brandBlue,
          alignment: Alignment.center,
          child: Icon(Icons.headphones_rounded, color: Colors.white, size: size * 0.62),
        ),
      ),
    );
  }
}
