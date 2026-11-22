import '/backend/api_requests/api_calls.dart';

/// Shares one trending-stories request between the home banner and the trending rail.
/// A failed request is never kept, so "try again" really tries again.
class HomeData {
  static Future<List<dynamic>>? _trending;
  static DateTime _trendingAt = DateTime.fromMillisecondsSinceEpoch(0);

  static Future<List<dynamic>> trending() {
    final fresh = DateTime.now().difference(_trendingAt) < const Duration(seconds: 60);
    if (_trending != null && fresh) return _trending!;

    _trendingAt = DateTime.now();
    final request = () async {
      final response = await GeneralGroup.trendingsCall.call();
      if (!response.succeeded) throw Exception('trending');
      return GeneralGroup.trendingsCall.result(response.jsonBody)?.toList() ?? <dynamic>[];
    }();
    _trending = request;
    request.catchError((Object _) {
      if (identical(_trending, request)) _trending = null;
      return <dynamic>[];
    });
    return request;
  }
}
