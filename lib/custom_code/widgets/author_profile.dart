// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '/app_state.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/song_container_widget.dart';
import '/custom_code/ui/app_palette.dart';
import '/custom_code/ui/app_widgets.dart';
import '/custom_code/ui/artwork_color.dart';
import '/custom_code/ui/glass.dart';

class _AuthorData {
  const _AuthorData(this.detail, this.stories);

  final Map<dynamic, dynamic>? detail;
  final List<dynamic> stories;
}

/// An author's page: photo, stats, follow button, links, bio and their stories.
class AuthorProfile extends StatefulWidget {
  const AuthorProfile({
    super.key,
    this.width,
    this.height,
    this.artistId = '',
    this.type = '1',
    this.name = '',
  });

  final double? width;
  final double? height;
  final String artistId;
  final String type;
  final String name;

  @override
  State<AuthorProfile> createState() => _AuthorProfileState();
}

class _AuthorProfileState extends State<AuthorProfile> {
  late Future<_AuthorData> _future = _load();
  bool? _following;
  int? _followers;

  Future<_AuthorData> _load() async {
    final detail = GeneralGroup.artistDetailCall.call(artistId: widget.artistId, userId: FFAppState().userid);
    final stories = GeneralGroup.artistContentsCall.call(artistId: widget.artistId, type: widget.type);
    final results = await Future.wait([detail, stories]);

    final detailResponse = results[0];
    final storiesResponse = results[1];
    if (!detailResponse.succeeded && !storiesResponse.succeeded) throw Exception('author');

    final raw = detailResponse.succeeded ? getJsonField(detailResponse.jsonBody, r'''$.result[0]''') : null;
    return _AuthorData(
      raw is Map ? raw : null,
      storiesResponse.succeeded ? (GeneralGroup.artistContentsCall.result(storiesResponse.jsonBody)?.toList() ?? []) : [],
    );
  }

  bool _truthy(dynamic value) => value == true || value == 1 || value == '1' || value == 'true';

  Future<void> _toggleFollow(bool current, int followers) async {
    setState(() {
      _following = !current;
      _followers = followers + (current ? -1 : 1);
    });
    final response = await GeneralGroup.followCall.call(userId: FFAppState().userid, artistId: widget.artistId);
    if (!response.succeeded && mounted) {
      setState(() {
        _following = current;
        _followers = followers;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imeshindikana. Jaribu tena.')),
      );
    }
  }

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_AuthorData>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return _loading(context);
        if (snapshot.hasError || snapshot.data == null) {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: StateMessage(
                icon: Icons.wifi_off_rounded,
                message: 'Imeshindikana kupakia ukurasa wa mwandishi.',
                onRetry: () => setState(() => _future = _load()),
              ),
            ),
          );
        }
        return _content(context, snapshot.data!);
      },
    );
  }

  Widget _loading(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: const [
        Center(child: SkeletonBox(width: 112, height: 112, circle: true)),
        SizedBox(height: 16),
        Center(child: SkeletonBox(width: 180, height: 26, radius: 8)),
        SizedBox(height: 24),
        SkeletonBox(height: 84, radius: AppSpace.radiusMd),
        SizedBox(height: 16),
        SkeletonBox(height: 52, radius: 14),
      ],
    );
  }

  Widget _content(BuildContext context, _AuthorData data) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final detail = data.detail;

    final name = (detail?['user_name']?.toString().isNotEmpty ?? false) ? detail!['user_name'].toString() : widget.name;
    final photo = detail?['image']?.toString() ?? '';
    final bio = detail?['bio']?.toString().trim() ?? '';
    final instagram = detail?['instagram_url']?.toString() ?? '';
    final facebook = detail?['facebook_url']?.toString() ?? '';
    final followers = _followers ?? int.tryParse(detail?['followes']?.toString() ?? '') ?? 0;
    final following = _following ?? _truthy(detail?['is_follow']);

    Widget avatar = Container(
      width: 104,
      height: 104,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: palette.accent, shape: BoxShape.circle),
      child: Text(name.isEmpty ? 'S' : name.replaceAll('@', '')[0].toUpperCase(),
          style: TextStyle(fontFamily: 'SF Pro Display', color: palette.onAccent, fontSize: 44, fontWeight: FontWeight.w800)),
    );
    if (photo.isNotEmpty) {
      avatar = ClipOval(
        child: CachedNetworkImage(imageUrl: photo, width: 104, height: 104, fit: BoxFit.cover, errorWidget: (_, __, ___) => avatar),
      );
    }

    Widget stat(String value, String label) => Expanded(
          child: Column(children: [
            Text(value,
                style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display', color: palette.text, fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
            const SizedBox(height: 2),
            Text(label,
                style: theme.bodySmall.override(fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 13, letterSpacing: 0)),
          ]),
        );

    Widget social(IconData icon, String url) => Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Material(
            color: palette.surface,
            shape: CircleBorder(side: BorderSide(color: palette.outline, width: 0.8)),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => _open(url),
              child: SizedBox(width: 50, height: 50, child: Icon(icon, color: palette.text, size: 22)),
            ),
          ),
        );

    return ArtworkBackdrop(
      imageUrl: photo,
      height: 360,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: palette.accent, width: 3)),
              child: avatar,
            ),
          ),
          const SizedBox(height: 14),
          Text(name,
              textAlign: TextAlign.center,
              style: theme.bodyMedium.override(
                  fontFamily: 'SF Pro Display', color: palette.text, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
          const SizedBox(height: 2),
          Text('Mwandishi',
              textAlign: TextAlign.center,
              style: theme.bodyMedium.override(fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 15, letterSpacing: 0)),
          const SizedBox(height: 18),
          Glass(
            radius: AppSpace.radiusMd,
            strong: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(children: [
              stat('$followers', 'Wafuasi'),
              Container(width: 1, height: 36, color: palette.outline),
              stat('${data.stories.length}', 'Simulizi'),
            ]),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: following
                    ? OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: palette.accent,
                          side: BorderSide(color: palette.accent, width: 1.4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('Unafuatilia', style: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w800)),
                        onPressed: () => _toggleFollow(true, followers),
                      )
                    : FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: palette.accent,
                          foregroundColor: palette.onAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Fuatilia', style: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w800)),
                        onPressed: () => _toggleFollow(false, followers),
                      ),
              ),
            ),
            if (instagram.isNotEmpty) social(Icons.camera_alt_outlined, instagram),
            if (facebook.isNotEmpty) social(Icons.facebook_rounded, facebook),
          ]),
          if (bio.isNotEmpty) ...[
            const SizedBox(height: 20),
            Glass(
              radius: AppSpace.radiusMd,
              strong: true,
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Kuhusu mwandishi',
                    style: theme.bodyMedium.override(
                        fontFamily: 'SF Pro Display', color: palette.text, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0)),
                const SizedBox(height: 8),
                ExpandableText(text: bio),
              ]),
            ),
          ],
          const SizedBox(height: 26),
          Row(children: [
            Expanded(
              child: Text('Simulizi zake',
                  style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display', color: palette.text, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
            ),
            if (data.stories.isNotEmpty)
              Text('${data.stories.length}',
                  style: theme.bodyMedium.override(fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 16, letterSpacing: 0)),
          ]),
          const SizedBox(height: 14),
          if (data.stories.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(children: [
                EmptyBadge(icon: Icons.auto_stories_outlined, size: 88),
                SizedBox(height: 14),
                Text('Hakuna simulizi bado.'),
              ]),
            )
          else
            for (final raw in data.stories)
              if (StoryStruct.maybeFromMap(raw) != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SongContainerWidget(
                    key: Key('author_story_${StoryStruct.maybeFromMap(raw)!.id}'),
                    story: StoryStruct.maybeFromMap(raw),
                  ),
                ),
        ],
      ),
    );
  }
}
