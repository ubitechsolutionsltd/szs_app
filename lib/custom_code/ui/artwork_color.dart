import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Picks a deep, pleasant accent colour from a cover image, so detail screens can tint their background.
class ArtworkColor {
  static final Map<String, Color> _cache = {};

  static Future<Color?> of(String url) async {
    if (url.isEmpty) return null;
    final cached = _cache[url];
    if (cached != null) return cached;

    try {
      final completer = Completer<ui.Image>();
      final stream = CachedNetworkImageProvider(url, maxWidth: 48).resolve(ImageConfiguration.empty);
      late ImageStreamListener listener;
      listener = ImageStreamListener(
        (info, _) {
          if (!completer.isCompleted) completer.complete(info.image);
          stream.removeListener(listener);
        },
        onError: (error, _) {
          if (!completer.isCompleted) completer.completeError(error);
          stream.removeListener(listener);
        },
      );
      stream.addListener(listener);

      final image = await completer.future.timeout(const Duration(seconds: 8));
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (data == null) return null;

      final color = fromPixels(data.buffer.asUint8List());
      if (color != null) _cache[url] = color;
      return color;
    } catch (_) {
      return null;
    }
  }

  /// Saturation-weighted average of RGBA pixels, toned down to a deep colour that works behind white text.
  static Color? fromPixels(List<int> rgba) {
    double r = 0, g = 0, b = 0, total = 0;
    for (var i = 0; i + 3 < rgba.length; i += 8) {
      if (rgba[i + 3] < 128) continue;
      final hsv = HSVColor.fromColor(Color.fromARGB(255, rgba[i], rgba[i + 1], rgba[i + 2]));
      if (hsv.value < 0.12) continue;
      final weight = hsv.saturation * hsv.value + 0.05;
      r += rgba[i] * weight;
      g += rgba[i + 1] * weight;
      b += rgba[i + 2] * weight;
      total += weight;
    }
    if (total == 0) return null;

    final average = HSVColor.fromColor(Color.fromARGB(255, (r / total).round(), (g / total).round(), (b / total).round()));
    return average
        .withSaturation(average.saturation.clamp(0.35, 0.75).toDouble())
        .withValue(average.value.clamp(0.32, 0.6).toDouble())
        .toColor();
  }
}

/// A soft gradient from the cover's colour into the page background, behind [child].
class ArtworkBackdrop extends StatefulWidget {
  const ArtworkBackdrop({super.key, required this.imageUrl, required this.child, this.height = 460});

  final String imageUrl;
  final Widget child;
  final double height;

  @override
  State<ArtworkBackdrop> createState() => _ArtworkBackdropState();
}

class _ArtworkBackdropState extends State<ArtworkBackdrop> {
  Color? _color;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant ArtworkBackdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) _load();
  }

  Future<void> _load() async {
    final color = await ArtworkColor.of(widget.imageUrl);
    if (mounted) setState(() => _color = color);
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    // No artwork to sample a colour from yet: use a deep, branded tone (from
    // the app accent) instead of a flat grey, so the backdrop still feels alive.
    final fallback = HSVColor.fromColor(palette.accent).withSaturation(0.55).withValue(0.42).toColor();

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: widget.height,
          child: TweenAnimationBuilder<Color?>(
            tween: ColorTween(end: _color ?? fallback),
            duration: const Duration(milliseconds: 500),
            builder: (context, color, _) => DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.2, 1.0],
                  colors: [
                    (color ?? fallback).withValues(alpha: 0.0),
                    (color ?? fallback).withValues(
                        alpha: Theme.of(context).brightness == Brightness.dark ? 0.8 : 0.34),
                    palette.background.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(child: widget.child),
      ],
    );
  }
}
