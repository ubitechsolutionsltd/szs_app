import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;

import '/flutter_flow/flutter_flow_theme.dart';
import 'api_cache.dart';
import 'app_palette.dart';
import 'offline_art.dart';
import '/flutter_flow/internationalization.dart' show trs;

/// Section title with an optional "see more" action.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.bodyMedium.override(
                fontFamily: 'SF Pro Display',
                color: palette.text,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ),
          if (actionLabel != null && onAction != null)
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onAction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    actionLabel!,
                    style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: palette.accent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: palette.accent, size: 20),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}

/// One clock shared by every skeleton on screen, so a whole group of placeholders sweeps in sync and the cost
/// stays at a single ticker no matter how many boxes there are.
class _ShimmerClock extends ChangeNotifier {
  _ShimmerClock._();
  static final _ShimmerClock instance = _ShimmerClock._();

  Ticker? _ticker;
  int _listeners = 0;
  double value = 0;

  void attach() {
    if (_listeners++ == 0) {
      _ticker = Ticker((elapsed) {
        value = (elapsed.inMilliseconds % 1500) / 1500.0;
        notifyListeners();
      })..start();
    }
  }

  void detach() {
    if (--_listeners <= 0) {
      _listeners = 0;
      _ticker?.dispose();
      _ticker = null;
    }
  }
}

class _SlideGradient extends GradientTransform {
  const _SlideGradient(this.percent);

  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) => Matrix4.translationValues(bounds.width * percent, 0, 0);
}

/// Placeholder block with a soft light sweep ("shimmer"), shown while content loads for the first time.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({super.key, this.width, this.height, this.radius = 12, this.circle = false});

  final double? width;
  final double? height;
  final double radius;
  final bool circle;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox> {
  @override
  void initState() {
    super.initState();
    _ShimmerClock.instance.attach();
  }

  @override
  void dispose() {
    _ShimmerClock.instance.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final base = dark ? const Color(0xFF16253F) : const Color(0xFFE2EEFA);
    final glow = dark ? const Color(0xFF2A4068) : const Color(0xFFF7FBFF);

    return AnimatedBuilder(
      animation: _ShimmerClock.instance,
      builder: (context, _) {
        final t = _ShimmerClock.instance.value;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.circle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.circle ? null : BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: const Alignment(-1.0, -0.3),
              end: const Alignment(1.0, 0.3),
              colors: [base, glow, base],
              stops: const [0.30, 0.5, 0.70],
              transform: _SlideGradient(-1.0 + t * 2.0),
            ),
          ),
        );
      },
    );
  }
}

/// Friendly empty / error message with an optional retry button.
class StateMessage extends StatelessWidget {
  const StateMessage({super.key, required this.icon, required this.message, this.onRetry, this.retryLabel});

  final IconData icon;
  final String message;
  final VoidCallback? onRetry;
  /// Defaults to the translated "try again".
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(AppSpace.radiusMd),
          border: Border.all(color: palette.outline, width: 0.5),
        ),
        child: Row(children: [
          Icon(icon, color: palette.muted, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message,
                style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 14, letterSpacing: 0)),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: Text(retryLabel ?? trs('retry'), style: TextStyle(color: palette.accent, fontWeight: FontWeight.w700)),
            ),
        ]),
      ),
    );
  }
}

/// Loads a list and shows: a shimmering skeleton the first time, an animated offline illustration with retry on
/// failure, nothing (or [empty]) when there are no items, and [builder] when there are.
///
/// With a [cacheKey] the list is also kept on the device: cached data is painted on the very first frame (no
/// loading flash), is refreshed from the server only when older than [ApiCache.freshFor], and keeps being shown if
/// the refresh fails (for example with no network).
class AsyncSection extends StatefulWidget {
  const AsyncSection({
    super.key,
    required this.load,
    required this.builder,
    required this.loading,
    this.empty,
    this.errorMessage,
    this.cacheKey,
  });

  final Future<List<dynamic>> Function() load;
  final Widget Function(BuildContext context, List<dynamic> items) builder;
  final Widget loading;

  /// Shown when the request succeeds but returns nothing (nothing is shown if null).
  final Widget? empty;

  /// Defaults to the translated "offline" text.
  final String? errorMessage;
  final String? cacheKey;

  @override
  State<AsyncSection> createState() => _AsyncSectionState();
}

class _AsyncSectionState extends State<AsyncSection> {
  List<dynamic>? _items;
  Object? _error;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    final key = widget.cacheKey;
    final cached = key == null ? null : ApiCache.read(key);
    if (cached != null) {
      _items = cached.items;
      if (cached.age < ApiCache.freshFor) return; // fresh enough: no request at all
    }
    _fetch();
  }

  Future<void> _fetch() async {
    if (_refreshing) return;
    _refreshing = true;
    if (mounted && _items == null) setState(() => _error = null);
    try {
      final items = await widget.load();
      if (widget.cacheKey != null && items.isNotEmpty) unawaited(ApiCache.write(widget.cacheKey!, items));
      if (mounted) setState(() {
        _items = items;
        _error = null;
      });
    } catch (e) {
      // Keep showing cached data when the refresh fails.
      if (mounted && _items == null) setState(() => _error = e);
    } finally {
      _refreshing = false;
    }
  }

  void _retry() {
    setState(() => _error = null);
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    Widget child;
    if (items != null) {
      child = items.isEmpty ? (widget.empty ?? const SizedBox.shrink()) : widget.builder(context, items);
    } else if (_error != null) {
      child = OfflineArt(compact: true, message: widget.errorMessage, onRetry: _retry);
    } else {
      child = widget.loading;
    }
    return AnimatedSwitcher(duration: const Duration(milliseconds: 320), child: KeyedSubtree(key: ValueKey(items != null ? 'data' : (_error != null ? 'error' : 'loading')), child: child));
  }
}

/// Text clamped to [maxLines] with a "read more" toggle (only shown when the text is long enough to need it).
class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.moreLabel = 'Soma zaidi',
    this.lessLabel = 'Punguza',
  });

  final String text;
  final int maxLines;
  final String moreLabel;
  final String lessLabel;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final style = theme.bodyMedium.override(
      fontFamily: 'SF Pro Display',
      color: palette.muted,
      fontSize: 15,
      letterSpacing: 0,
      lineHeight: 1.45,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final painter = TextPainter(
        text: TextSpan(text: widget.text, style: style),
        maxLines: widget.maxLines,
        textDirection: Directionality.of(context),
      )..layout(maxWidth: constraints.maxWidth);
      final overflows = painter.didExceedMaxLines;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: style,
            maxLines: _expanded ? null : widget.maxLines,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          if (overflows)
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  _expanded ? widget.lessLabel : widget.moreLabel,
                  style: style.copyWith(color: palette.accent, fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      );
    });
  }
}


/// Round icon badge used at the top of empty states.
class EmptyBadge extends StatelessWidget {
  const EmptyBadge({super.key, required this.icon, this.size = 112});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: palette.accent.withValues(alpha: 0.10),
        border: Border.all(color: palette.accent.withValues(alpha: 0.35), width: 1.5),
      ),
      child: Icon(icon, size: size * 0.46, color: palette.accent),
    );
  }
}
