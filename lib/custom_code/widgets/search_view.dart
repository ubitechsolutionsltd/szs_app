// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import '/backend/api_requests/api_calls.dart';
import '/components/song_container_widget.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_tokens.dart';
import 'search_suggestions.dart';

enum _SearchPhase { idle, loading, results, empty, error }

/// The whole Search experience: blue gradient header with the search field, then (by state) suggestions,
/// loading skeletons, results, an empty state or an error with retry. Used by the Tafuta tab and by the
/// stand-alone search route, so both behave the same.
class SearchView extends StatefulWidget {
  const SearchView({super.key, this.autofocus = false, this.showBack = false});

  final bool autofocus;
  final bool showBack;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  static const _minChars = 3;

  final _controller = TextEditingController();
  final _focus = FocusNode();
  Timer? _debounce;
  int _requestId = 0;

  _SearchPhase _phase = _SearchPhase.idle;
  List<dynamic> _results = const [];
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final q = value.trim();
    if (q.length < _minChars) {
      _requestId++; // drop any response still in flight
      setState(() {
        _phase = _SearchPhase.idle;
        _results = const [];
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 450), () => _search(q));
  }

  Future<void> _search(String q) async {
    final id = ++_requestId;
    setState(() {
      _phase = _SearchPhase.loading;
      _query = q;
    });
    try {
      final response = await GeneralGroup.searchCall.call(type: '1', name: q);
      if (!mounted || id != _requestId) return;
      // The API answers "nothing found" with status 400 in the body (sometimes as an HTTP error too).
      final notFound = GeneralGroup.searchCall.statusCode(response.jsonBody) == 400;
      if (!response.succeeded && !notFound) {
        setState(() => _phase = _SearchPhase.error);
        return;
      }
      final list = GeneralGroup.searchCall.result(response.jsonBody)?.toList() ?? [];
      final valid = list.where((e) => StoryStruct.maybeFromMap(e) != null).toList();
      setState(() {
        _results = valid;
        _phase = valid.isEmpty ? _SearchPhase.empty : _SearchPhase.results;
      });
    } catch (_) {
      if (mounted && id == _requestId) setState(() => _phase = _SearchPhase.error);
    }
  }

  void _clear() {
    _controller.clear();
    _onChanged('');
    _focus.requestFocus();
  }

  Widget _searchField() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTokens.radiusInput),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focus,
        autofocus: widget.autofocus,
        textInputAction: TextInputAction.search,
        onChanged: (v) {
          setState(() {});
          _onChanged(v);
        },
        onSubmitted: (v) {
          final q = v.trim();
          if (q.length >= _minChars) _search(q);
        },
        style: const TextStyle(fontFamily: AppTokens.fontFamily, fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: 'Unatafuta simulizi gani?',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(tooltip: 'Futa', icon: const Icon(Icons.close_rounded), onPressed: _clear),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    switch (_phase) {
      case _SearchPhase.idle:
        return const Padding(padding: EdgeInsets.only(top: 20), child: SearchSuggestions());
      case _SearchPhase.loading:
        return Padding(
          padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 24, AppTokens.screenPadding, 0),
          child: Column(children: [
            for (var i = 0; i < 4; i++) const Padding(padding: EdgeInsets.only(bottom: 12), child: _ResultSkeleton()),
          ]),
        );
      case _SearchPhase.error:
        return Padding(
          padding: const EdgeInsets.only(top: 40),
          child: ErrorState(onRetry: () => _search(_query)),
        );
      case _SearchPhase.empty:
        return Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(children: [
            const SearchEmptyIllustration(),
            const SizedBox(height: 20),
            Text('Hakuna Matokeo',
                style: TextStyle(
                    fontFamily: AppTokens.fontFamily,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: FlutterFlowTheme.of(context).tertiary)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text('Hatukupata simulizi inayolingana na “$_query”.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppTokens.fontFamily,
                      fontSize: 15,
                      height: 1.5,
                      color: FlutterFlowTheme.of(context).gray)),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.screenPadding),
              child: AppButton(label: 'Jaribu maneno mengine', onPressed: _clear),
            ),
          ]),
        );
      case _SearchPhase.results:
        return Padding(
          padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 24, AppTokens.screenPadding, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Matokeo (${_results.length})',
                style: TextStyle(
                    fontFamily: AppTokens.fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: FlutterFlowTheme.of(context).tertiary)),
            const SizedBox(height: 14),
            for (final raw in _results)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SongContainerWidget(
                  key: Key('search_result_${StoryStruct.maybeFromMap(raw)!.id}'),
                  story: StoryStruct.maybeFromMap(raw),
                ),
              ),
          ]),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(children: [
        GradientHeader(
          title: 'Tafuta',
          trailing: null,
          bottom: Row(children: [
            if (widget.showBack) ...[
              Material(
                color: Colors.white.withValues(alpha: 0.2),
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: 'Rudi nyuma',
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  onPressed: () => context.safePop(),
                ),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(child: _searchField()),
          ]),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [_body(context)],
          ),
        ),
      ]),
    );
  }
}

class _ResultSkeleton extends StatelessWidget {
  const _ResultSkeleton();

  @override
  Widget build(BuildContext context) => const _Pulse();
}

class _Pulse extends StatelessWidget {
  const _Pulse();

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      _Box(64, 64, 14),
      SizedBox(width: 14),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _Box(160, 14, 6),
          SizedBox(height: 8),
          _Box(100, 12, 6),
        ]),
      ),
    ]);
  }
}

class _Box extends StatelessWidget {
  const _Box(this.w, this.h, this.r);
  final double w, h, r;

  @override
  Widget build(BuildContext context) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).alternate.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(r),
        ),
      );
}
