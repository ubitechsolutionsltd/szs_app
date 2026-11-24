// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '/app_state.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/package_lists_component_widget.dart';
import '/components/song_container_widget.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/app_widgets.dart';
import '/custom_code/ui/auth_gate.dart';
import '/index.dart';

enum _SavedPhase { loading, guest, error, empty, ready }

/// The Maktaba tab: blue header with the coin balance, a pill switch between "Ulizohifadhi" (saved stories)
/// and "Ulizopakua" (offline downloads), and each list with loading, error, empty and populated states.
class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  int _tab = 0;
  _SavedPhase _phase = _SavedPhase.loading;
  List<dynamic> _saved = const [];

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    if (!isLoggedIn) {
      setState(() => _phase = _SavedPhase.guest);
      return;
    }
    setState(() => _phase = _SavedPhase.loading);
    try {
      final response = await GeneralGroup.getBookMarksCall.call(userId: FFAppState().userid);
      if (!mounted) return;
      final status = GeneralGroup.getBookMarksCall.statusCode(response.jsonBody);
      // "No bookmarks" comes back as status 400 ("Data Not Found"): that is an empty library, not a failure.
      if (!response.succeeded && status != 400) {
        setState(() => _phase = _SavedPhase.error);
        return;
      }
      final list = GeneralGroup.getBookMarksCall.result(response.jsonBody)?.toList() ?? [];
      final valid = list.where((e) => StoryStruct.maybeFromMap(e) != null).toList();
      setState(() {
        _saved = valid;
        _phase = valid.isEmpty ? _SavedPhase.empty : _SavedPhase.ready;
      });
    } catch (_) {
      if (mounted) setState(() => _phase = _SavedPhase.error);
    }
  }

  Future<void> _topUp() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      context: context,
      builder: (context) => WebViewAware(
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: SizedBox(height: MediaQuery.sizeOf(context).height * 0.75, child: PackageListsComponentWidget()),
        ),
      ),
    );
  }

  Widget _coinPill() {
    final coins = context.watch<FFAppState>().walletcoin;
    return Semantics(
      button: true,
      label: trs('sem_balance', args: {'n': '$coins'}),
      child: Material(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusPill),
          onTap: isLoggedIn ? _topUp : () => promptLogin(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 9, 14, 9),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.toll_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 6),
              Text(isLoggedIn ? '$coins' : trs('gdn2b1x7'),
                  style: const TextStyle(
                      fontFamily: AppTokens.fontFamily, color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
              if (isLoggedIn) ...[
                const SizedBox(width: 6),
                const Icon(Icons.add_circle_rounded, color: Colors.white, size: 18),
              ],
            ]),
          ),
        ),
      ),
    );
  }

  Widget _savedBody() {
    switch (_phase) {
      case _SavedPhase.loading:
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 20, AppTokens.screenPadding, 24),
          children: [for (var i = 0; i < 4; i++) const Padding(padding: EdgeInsets.only(bottom: 12), child: SkeletonBox(height: 84, radius: 22))],
        );
      case _SavedPhase.guest:
        return EmptyState(
          icon: Icons.lock_outline_rounded,
          title: trs('login_to_see'),
          message: trs('saved_hint'),
          actionLabel: trs('gdn2b1x7'),
          onAction: () => context.pushNamed(LoginPageWidget.routeName),
        );
      case _SavedPhase.error:
        return ErrorState(onRetry: _loadSaved);
      case _SavedPhase.empty:
        return RefreshIndicator(
          onRefresh: _loadSaved,
          child: ListView(children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: EmptyState(
                icon: Icons.favorite_border_rounded,
                title: trs('no_saved_title'),
                message: trs('saved_empty_hint'),
                actionLabel: trs('search_stories'),
                onAction: () => context.pushNamed(HomeSearchPageWidget.routeName),
              ),
            ),
          ]),
        );
      case _SavedPhase.ready:
        return RefreshIndicator(
          onRefresh: _loadSaved,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 20, AppTokens.screenPadding, 24),
            itemCount: _saved.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final story = StoryStruct.maybeFromMap(_saved[i])!;
              return SongContainerWidget(key: Key('library_saved_${story.id}'), story: story);
            },
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GradientHeader(
        title: trs('ztt7zgno'),
        trailing: _coinPill(),
        bottom: PillTabs(
          labels: [trs('saved_tab'), trs('downloads_tab')],
          selected: _tab,
          onGradient: true,
          onChanged: (i) => setState(() => _tab = i),
        ),
      ),
      Expanded(
        child: AnimatedSwitcher(
          duration: AppTokens.fast,
          child: KeyedSubtree(
            key: ValueKey(_tab),
            child: _tab == 0 ? _savedBody() : DownloadsList(),
          ),
        ),
      ),
    ]);
  }
}
