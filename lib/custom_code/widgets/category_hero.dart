// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/ui/app_palette.dart';

/// Coloured header for a category's story list. The colour is stable per category.
class CategoryHero extends StatelessWidget {
  const CategoryHero({super.key, this.width, this.height, this.title = '', this.categoryId = 0});

  final double? width;
  final double? height;
  final String title;
  final int categoryId;

  static const _gradients = <List<Color>>[
    [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
    [Color(0xFF7C2D12), Color(0xFFF97316)],
    [Color(0xFF14532D), Color(0xFF22C55E)],
    [Color(0xFF581C87), Color(0xFFA855F7)],
    [Color(0xFF831843), Color(0xFFEC4899)],
    [Color(0xFF134E4A), Color(0xFF14B8A6)],
    [Color(0xFF7F1D1D), Color(0xFFEF4444)],
    [Color(0xFF713F12), Color(0xFFEAB308)],
  ];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final colors = _gradients[categoryId.abs() % _gradients.length];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpace.radiusLg),
        child: Container(
          width: width,
          height: height ?? 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: colors),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -18,
                bottom: -22,
                child: Icon(Icons.headphones_rounded, size: 130, color: Colors.white.withValues(alpha: 0.22)),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
