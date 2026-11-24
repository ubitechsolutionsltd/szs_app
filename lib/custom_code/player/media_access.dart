// Talks to the backend media gate: refreshes expired links and tells apart "locked" from "offline".

import 'dart:convert';

import 'package:http/http.dart' as http;

import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_manager.dart';
import 'player_core.dart';

class MediaAccessResult {
  const MediaAccessResult({this.url, this.locked = false, this.loginRequired = false});

  /// A fresh link, or null when none could be obtained.
  final String? url;

  /// The server said this episode is not unlocked for the user.
  final bool locked;

  /// The server answered 401 / "Unauthenticated": nobody is logged in (or the session expired).
  final bool loginRequired;

  bool get reachedServer => url != null || locked || loginRequired;
}

class MediaAccess {
  MediaAccess._();
  static final MediaAccess instance = MediaAccess._();

  Map<String, String> headersFor(String url) {
    final token = ApiManager.accessToken;
    if (token == null || !MediaUrlPolicy.isGateUrl(url)) return const {};
    return {'Authorization': 'Bearer $token'};
  }

  /// Exchanges an old (or soon expiring) media link for a fresh one.
  Future<MediaAccessResult> refresh(String url) async {
    final token = ApiManager.accessToken;
    try {
      final response = await http
          .post(
            Uri.parse('${GeneralGroup.getBaseUrl()}/media/access'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              if (token != null) 'Authorization': 'Bearer $token',
            },
            body: jsonEncode({'url': url}),
          )
          .timeout(const Duration(seconds: 12));

      if (response.statusCode == 401) return const MediaAccessResult(loginRequired: true);
      final body = jsonDecode(response.body);
      if (body is Map) {
        if (body['status'] == 403) return const MediaAccessResult(locked: true);
        if (body['status'] == 401 || body['message'] == 'Unauthenticated.') {
          return const MediaAccessResult(loginRequired: true);
        }
        if (body['status'] == 200 && body['url'] is String) {
          return MediaAccessResult(url: body['url'] as String);
        }
      }
    } catch (_) {
      // Offline or the server is unreachable: the caller falls back to the link it already has.
    }
    return const MediaAccessResult();
  }
}
