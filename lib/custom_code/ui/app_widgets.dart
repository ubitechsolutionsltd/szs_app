import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'app_palette.dart';

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

/// A softly pulsing placeholder block, used while content loads.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({super.key, this.width, this.height, this.radius = 12, this.circle = false});

  final double? width;
  final double? height;
  final double radius;
  final bool circle;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Color.lerp(palette.surface, palette.surfaceHigh, _controller.value),
          shape: widget.circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: widget.circle ? null : BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}

/// Friendly empty / error message with an optional retry button.
class StateMessage extends StatelessWidget {
  const StateMessage({super.key, required this.icon, required this.message, this.onRetry, this.retryLabel = 'Jaribu tena'});

  final IconData icon;
  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

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
              child: Text(retryLabel, style: TextStyle(color: palette.accent, fontWeight: FontWeight.w700)),
            ),
        ]),
      ),
    );
  }
}

/// Loads a list, then shows a skeleton while waiting, an error with retry on failure, nothing when empty,
/// and [builder] when there are items.
class AsyncSection extends StatefulWidget {
  const AsyncSection({
    super.key,
    required this.load,
    required this.builder,
    required this.loading,
    this.errorMessage = 'Imeshindikana kupakia. Angalia mtandao wako.',
  });

  final Future<List<dynamic>> Function() load;
  final Widget Function(BuildContext context, List<dynamic> items) builder;
  final Widget loading;
  final String errorMessage;

  @override
  State<AsyncSection> createState() => _AsyncSectionState();
}

class _AsyncSectionState extends State<AsyncSection> {
  late Future<List<dynamic>> _future = widget.load();

  void _retry() => setState(() => _future = widget.load());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return widget.loading;
        if (snapshot.hasError) {
          return StateMessage(icon: Icons.wifi_off_rounded, message: widget.errorMessage, onRetry: _retry);
        }
        final items = snapshot.data ?? const [];
        if (items.isEmpty) return const SizedBox.shrink();
        return widget.builder(context, items);
      },
    );
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
