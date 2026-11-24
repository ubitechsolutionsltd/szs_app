import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_tokens.dart';

bool _isDark(BuildContext c) => Theme.of(c).brightness == Brightness.dark;
Color _accent(BuildContext c) => _isDark(c) ? AppTokens.darkAccent : AppTokens.brandPrimary;
Color _text(BuildContext c) => _isDark(c) ? AppTokens.darkText : AppTokens.textPrimary;
Color _muted(BuildContext c) => _isDark(c) ? AppTokens.darkTextSecondary : AppTokens.textSecondary;
Color _surface(BuildContext c) => _isDark(c) ? AppTokens.darkSurface : AppTokens.surface;
Color _border(BuildContext c) => _isDark(c) ? AppTokens.darkBorder : AppTokens.border;

TextStyle _style(BuildContext c, double size, FontWeight w, {Color? color, double? height}) => TextStyle(
      fontFamily: AppTokens.fontFamily,
      fontSize: size,
      fontWeight: w,
      color: color ?? _text(c),
      height: height,
      letterSpacing: 0,
    );

enum AppButtonKind { primary, secondary, text }

/// Brand button. Primary = solid blue, secondary = outlined surface, text = plain link-style.
/// Shows a spinner and ignores taps while [loading]; disabled when [onPressed] is null.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.kind = AppButtonKind.primary,
    this.icon,
    this.trailingIcon = false,
    this.loading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonKind kind;
  final IconData? icon;

  /// Puts [icon] after the label (e.g. a forward arrow) instead of before it.
  final bool trailingIcon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final accent = _accent(context);
    final enabled = onPressed != null && !loading;
    final primary = kind == AppButtonKind.primary;
    final fg = primary ? (_isDark(context) ? const Color(0xFF04182B) : Colors.white) : accent;

    final content = loading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2.4, valueColor: AlwaysStoppedAnimation(fg)),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && !trailingIcon) ...[Icon(icon, size: 20, color: fg), const SizedBox(width: 8)],
              Flexible(
                child: Text(label,
                    maxLines: 1, overflow: TextOverflow.ellipsis, style: _style(context, 16, FontWeight.w700, color: fg)),
              ),
              if (icon != null && trailingIcon) ...[const SizedBox(width: 8), Icon(icon, size: 20, color: fg)],
            ],
          );

    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTokens.radiusButton));
    final size = Size(expand ? double.infinity : 0, kind == AppButtonKind.text ? AppTokens.minTouch : AppTokens.buttonHeight);

    final Widget button;
    switch (kind) {
      case AppButtonKind.primary:
        button = ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: accent,
            disabledBackgroundColor: accent.withValues(alpha: loading ? 1 : 0.4),
            minimumSize: size,
            elevation: 0,
            shape: shape,
          ),
          child: content,
        );
      case AppButtonKind.secondary:
        button = OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: _surface(context),
            minimumSize: size,
            side: BorderSide(color: _border(context)),
            shape: shape,
          ),
          child: content,
        );
      case AppButtonKind.text:
        button = TextButton(onPressed: enabled ? onPressed : null, style: TextButton.styleFrom(minimumSize: size), child: content);
    }

    return Semantics(button: true, enabled: enabled, label: label, child: ExcludeSemantics(child: button));
  }
}

/// Labelled text field with an optional leading icon, error text and password reveal toggle.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.icon,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofillHints,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String hint;
  final String? label;
  final IconData? icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? errorText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final bool enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _hidden = widget.obscure;

  @override
  Widget build(BuildContext context) {
    final muted = _muted(context);
    final field = TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      obscureText: _hidden,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      cursorColor: _accent(context),
      style: _style(context, AppTokens.fsBody, FontWeight.w500),
      decoration: InputDecoration(
        hintText: widget.hint,
        errorText: widget.errorText,
        prefixIcon: widget.icon == null ? null : Icon(widget.icon, color: muted, size: 22),
        suffixIcon: widget.obscure
            ? IconButton(
                tooltip: _hidden ? 'Onyesha' : 'Ficha',
                icon: Icon(_hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: muted, size: 22),
                onPressed: () => setState(() => _hidden = !_hidden),
              )
            : null,
      ),
    );

    if (widget.label == null) return field;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label!, style: _style(context, 13, FontWeight.w600, color: muted)),
        const SizedBox(height: 8),
        field,
      ],
    );
  }
}

/// Cover artwork with a rounded border, shimmer-free placeholder and broken-image fallback.
class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.url, this.width, this.height, this.radius = 16, this.fit = BoxFit.cover});

  final String? url;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width,
      height: height,
      color: _isDark(context) ? AppTokens.darkSurfaceHigh : AppTokens.brandSky,
      alignment: Alignment.center,
      child: Icon(Icons.headphones_rounded, color: _accent(context).withValues(alpha: 0.55), size: 32),
    );
    final u = url?.trim() ?? '';
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: u.isEmpty
          ? placeholder
          : CachedNetworkImage(
              imageUrl: u,
              width: width,
              height: height,
              fit: fit,
              placeholder: (_, __) => placeholder,
              errorWidget: (_, __, ___) => placeholder,
            ),
    );
  }
}

/// Story card. [meta] and [listens] are optional: pass them only when the backend actually returned a value,
/// nothing is invented here.
///
/// `compact: false` is the portrait rail card; `compact: true` is the horizontal list row.
class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.title,
    this.author,
    this.imageUrl,
    this.category,
    this.listens,
    this.onTap,
    this.trailing,
    this.compact = false,
    this.width = 152,
  });

  final String title;
  final String? author;
  final String? imageUrl;
  final String? category;
  final int? listens;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool compact;
  final double width;

  @override
  Widget build(BuildContext context) {
    final muted = _muted(context);
    final authorText = (author ?? '').trim();
    final listensWidget = listens == null
        ? null
        : Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.headphones_rounded, size: 15, color: muted),
            const SizedBox(width: 4),
            Text('$listens', style: _style(context, 13, FontWeight.w700)),
          ]);

    if (compact) {
      return Semantics(
        button: onTap != null,
        label: authorText.isEmpty ? title : '$title, $authorText',
        child: Material(
          color: _surface(context),
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppTokens.radiusCard),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTokens.radiusCard),
                border: Border.all(color: _border(context)),
                boxShadow: AppTokens.cardShadow(_isDark(context)),
              ),
              child: Row(children: [
                CoverImage(url: imageUrl, width: 64, height: 64, radius: 14),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _style(context, AppTokens.fsCardTitle, FontWeight.w800)),
                    if (authorText.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(authorText,
                          maxLines: 1, overflow: TextOverflow.ellipsis, style: _style(context, 13, FontWeight.w500, color: muted)),
                    ],
                  ]),
                ),
                if (listensWidget != null) ...[const SizedBox(width: 10), listensWidget],
                if (trailing != null) trailing!,
              ]),
            ),
          ),
        ),
      );
    }

    return Semantics(
      button: onTap != null,
      label: authorText.isEmpty ? title : '$title, $authorText',
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(children: [
              CoverImage(url: imageUrl, width: width, height: width * 1.3, radius: AppTokens.radiusCard),
              if ((category ?? '').isNotEmpty)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(color: _accent(context), borderRadius: BorderRadius.circular(AppTokens.radiusPill)),
                    child: Text(category!, style: _style(context, 11, FontWeight.w700, color: Colors.white)),
                  ),
                ),
            ]),
            const SizedBox(height: 10),
            Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: _style(context, 15, FontWeight.w800, height: 1.2)),
            if (authorText.isNotEmpty) ...[
              const SizedBox(height: 3),
              Text(authorText, maxLines: 1, overflow: TextOverflow.ellipsis, style: _style(context, 13, FontWeight.w500, color: muted)),
            ],
            if (listensWidget != null) ...[const SizedBox(height: 6), listensWidget],
          ]),
        ),
      ),
    );
  }
}

/// Coloured category tile (icon + label). Uses a gradient built from [AppTokens.categoryGradients].
class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.label, required this.icon, this.gradient, this.onTap, this.index = 0});

  final String label;
  final IconData icon;
  final List<Color>? gradient;
  final VoidCallback? onTap;

  /// Used to pick a gradient when [gradient] is null, so tiles are stable per position.
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = gradient ?? AppTokens.categoryGradients[index % AppTokens.categoryGradients.length];
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          onTap: onTap,
          child: Ink(
            height: 84,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
              boxShadow: [BoxShadow(color: colors.last.withValues(alpha: 0.28), blurRadius: 14, offset: const Offset(0, 6))],
            ),
            child: Row(children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Text(label,
                    maxLines: 2, overflow: TextOverflow.ellipsis, style: _style(context, 16, FontWeight.w800, color: Colors.white)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Friendly empty state: badge, title, optional message and optional action button.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, this.message, this.actionLabel, this.onAction});

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final accent = _accent(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(shape: BoxShape.circle, color: accent.withValues(alpha: 0.10)),
            child: Icon(icon, size: 52, color: accent),
          ),
          const SizedBox(height: 20),
          Text(title, textAlign: TextAlign.center, style: _style(context, 20, FontWeight.w800)),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(message!, textAlign: TextAlign.center, style: _style(context, AppTokens.fsBody, FontWeight.w400, color: _muted(context), height: 1.5)),
          ],
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 20),
            AppButton(label: actionLabel!, onPressed: onAction, expand: false),
          ],
        ]),
      ),
    );
  }
}

/// Error state with retry; same layout as [EmptyState] but with a warning icon and a "try again" action.
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, this.message = 'Imeshindikana kupakia. Angalia mtandao wako.', required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => EmptyState(
        icon: Icons.wifi_off_rounded,
        title: 'Kuna tatizo',
        message: message,
        actionLabel: 'Jaribu tena',
        onAction: onRetry,
      );
}

/// Blue gradient page header with a title (and optional trailing widget / bottom widget), used by tab pages such
/// as Maktaba. Content below should overlap nothing: it is a normal box, not a flexible space.
class GradientHeader extends StatelessWidget {
  const GradientHeader({super.key, required this.title, this.subtitle, this.trailing, this.bottom});

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.fromLTRB(AppTokens.screenPadding, top + 16, AppTokens.screenPadding, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppTokens.brandPrimary, AppTokens.brandDeep]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: _style(context, AppTokens.fsScreenTitle, FontWeight.w800, color: Colors.white)),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: _style(context, 14, FontWeight.w500, color: Colors.white.withValues(alpha: 0.85))),
              ],
            ]),
          ),
          if (trailing != null) trailing!,
        ]),
        if (bottom != null) ...[const SizedBox(height: 16), bottom!],
      ]),
    );
  }
}

/// Segmented pill tabs ("Saved" / "Purchased"). Works on any background, including [GradientHeader].
class PillTabs extends StatelessWidget {
  const PillTabs({super.key, required this.labels, required this.selected, required this.onChanged, this.onGradient = false});

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onChanged;

  /// True when placed on the blue gradient header (white selected pill), false on a normal surface.
  final bool onGradient;

  @override
  Widget build(BuildContext context) {
    final accent = _accent(context);
    final trackColor = onGradient ? Colors.white.withValues(alpha: 0.18) : (_isDark(context) ? AppTokens.darkSurface : AppTokens.brandSky);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: trackColor, borderRadius: BorderRadius.circular(AppTokens.radiusPill)),
      child: Row(children: [
        for (var i = 0; i < labels.length; i++)
          Expanded(
            child: Semantics(
              button: true,
              selected: i == selected,
              label: labels[i],
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: AppTokens.fast,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == selected ? (onGradient ? Colors.white : accent) : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppTokens.radiusPill),
                  ),
                  child: Text(
                    labels[i],
                    style: _style(
                      context,
                      14,
                      FontWeight.w700,
                      color: i == selected
                          ? (onGradient ? AppTokens.brandPrimary : Colors.white)
                          : (onGradient ? Colors.white : _muted(context)),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}

/// Bottom navigation destination description.
class AppNavItem {
  const AppNavItem({required this.label, required this.icon, required this.selectedIcon});
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Floating pill-style bottom navigation with a clear active state and always-visible labels.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.items, required this.currentIndex, required this.onSelected});

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final accent = _accent(context);
    final dark = _isDark(context);
    return Container(
      decoration: BoxDecoration(
        color: _surface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        border: Border(top: BorderSide(color: _border(context))),
        boxShadow: AppTokens.cardShadow(dark),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
          child: Row(children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: Semantics(
                  button: true,
                  selected: i == currentIndex,
                  label: items[i].label,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => onSelected(i),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 58),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        AnimatedContainer(
                          duration: AppTokens.fast,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                          decoration: BoxDecoration(
                            color: i == currentIndex ? accent.withValues(alpha: dark ? 0.22 : 0.14) : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppTokens.radiusPill),
                          ),
                          child: Icon(i == currentIndex ? items[i].selectedIcon : items[i].icon,
                              size: 24, color: i == currentIndex ? accent : _muted(context)),
                        ),
                        const SizedBox(height: 2),
                        Text(items[i].label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _style(context, 12, i == currentIndex ? FontWeight.w800 : FontWeight.w500,
                                color: i == currentIndex ? accent : _muted(context))),
                      ]),
                    ),
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
