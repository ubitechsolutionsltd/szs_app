import '/backend/api_requests/api_calls.dart';
import '/components/package_lists_component_widget.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/episode_unlock.dart';
import '/custom_code/ui/auth_gate.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'episode_list_item_model.dart';
export 'episode_list_item_model.dart';

class EpisodeListItemWidget extends StatefulWidget {
  const EpisodeListItemWidget({
    super.key,
    required this.episode,
  });

  final dynamic episode;

  @override
  State<EpisodeListItemWidget> createState() => _EpisodeListItemWidgetState();
}

class _EpisodeListItemWidgetState extends State<EpisodeListItemWidget> {
  late EpisodeListItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EpisodeListItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  /// Episode card: artwork, title, duration and a clear locked / playing state.
  Widget _buildRow(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final episode = widget.episode;

    final isCurrent = getJsonField(episode, r'''$.id''')?.toString() ==
        getJsonField(FFAppState().nowPlaying, r'''$.id''')?.toString();
    final price = functions
        .jsonValueToInteger(getJsonField(episode, r'''$["is_audio_coin"]'''));
    final owned = functions
            .jsonValueToInteger(getJsonField(episode, r'''$["is_buy"]''')) ==
        1;
    final locked = !owned && price > 0;
    final seconds = functions
        .jsonValueToInteger(getJsonField(episode, r'''$["audio_duration"]'''));
    final image = getJsonField(episode, r'''$.image''')?.toString() ?? '';
    final name = getJsonField(episode, r'''$["name"]''')?.toString() ?? '';

    Widget trailing;
    if (locked) {
      trailing = Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: palette.warning.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.lock_rounded, color: palette.warning, size: 14.0),
          SizedBox(width: 4.0),
          Text('$price',
              style: theme.bodySmall.override(
                fontFamily: 'SF Pro Display',
                color: palette.warning,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
              )),
        ]),
      );
    } else if (isCurrent) {
      trailing = Icon(Icons.graphic_eq_rounded, color: palette.accent, size: 24.0);
    } else {
      trailing = Icon(Icons.play_circle_outline_rounded, color: palette.muted, size: 26.0);
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isCurrent ? palette.accent.withValues(alpha: 0.12) : palette.surface,
        borderRadius: BorderRadius.circular(AppSpace.radiusMd),
        border: Border.all(
          color: isCurrent ? palette.accent.withValues(alpha: 0.55) : palette.outline,
          width: 0.6,
        ),
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: image,
            width: 54.0,
            height: 54.0,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(width: 54.0, height: 54.0, color: palette.surfaceHigh),
            errorWidget: (_, __, ___) => Container(
              width: 54.0,
              height: 54.0,
              color: palette.surfaceHigh,
              child: Icon(Icons.headphones_rounded, color: palette.muted, size: 24.0),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.bodyMedium.override(
                  fontFamily: 'SF Pro Display',
                  color: isCurrent ? palette.accent : palette.text,
                  fontSize: 16.0,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                  letterSpacing: 0.0,
                  lineHeight: 1.25,
                ),
              ),
              if (seconds > 0) ...[
                SizedBox(height: 3.0),
                Text(
                  '${Duration(seconds: seconds).inMinutes} dak',
                  style: theme.bodySmall.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.muted,
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 8.0),
        trailing,
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          // Free / owned episodes just play; locked ones go through the shared unlock flow (login prompt,
          // automatic purchase when the balance allows, or the top-up sheet).
          await EpisodeUnlock.run(context, episode: widget.episode);
          if (mounted) _model.updatePage(() {});
        },
        child: _buildRow(context),
      ),
    );
  }
}
