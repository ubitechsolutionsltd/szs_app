import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color, DateTimeRange;
// Redundant when the data-type schema export already re-exports it.
// ignore: unnecessary_import
import 'package:from_css_color/from_css_color.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start General Group Code

class GeneralGroup {
  static String getBaseUrl() => 'https://szs.co.tz/public/api';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static LoginCall loginCall = LoginCall();
  static ContentsByCategoryCall contentsByCategoryCall =
      ContentsByCategoryCall();
  static EpisodesAudioByContentCall episodesAudioByContentCall =
      EpisodesAudioByContentCall();
  static ArtistListCall artistListCall = ArtistListCall();
  static CategoriesCall categoriesCall = CategoriesCall();
  static TrendingsCall trendingsCall = TrendingsCall();
  static ArtistContentsCall artistContentsCall = ArtistContentsCall();
  static SearchCall searchCall = SearchCall();
  static PaymentOptionsCall paymentOptionsCall = PaymentOptionsCall();
  static PackagesCall packagesCall = PackagesCall();
  static AddOrRemoveBookmarkCall addOrRemoveBookmarkCall =
      AddOrRemoveBookmarkCall();
  static GetBookMarksCall getBookMarksCall = GetBookMarksCall();
  static GetNotificationsCall getNotificationsCall = GetNotificationsCall();
  static ReadNotificationCall readNotificationCall = ReadNotificationCall();
  static PayForPackageCall payForPackageCall = PayForPackageCall();
  static BuyEpisodeCall buyEpisodeCall = BuyEpisodeCall();
  static ArtistDetailCall artistDetailCall = ArtistDetailCall();
  static FollowCall followCall = FollowCall();
  static RegisterCall registerCall = RegisterCall();
  static MeCall meCall = MeCall();
  static LogoutCall logoutCall = LogoutCall();
  static AkCall akCall = AkCall();
  static AlCall alCall = AlCall();
  static AmCall amCall = AmCall();
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? type = '4',
    String? email = '',
    String? fullName = '',
    String? mobileNumber = '',
    String? password = '',
    String? deviceType = '',
    String? deviceToken = '1',
    String? image = '',
    String? idToken = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "type": ${type == null ? 'null' : '"${escapeStringForJson(type)}"'},
  "email": ${email == null ? 'null' : '"${escapeStringForJson(email)}"'},
  "full_name": ${fullName == null ? 'null' : '"${escapeStringForJson(fullName)}"'},
  "mobile_number": ${mobileNumber == null ? 'null' : '"${escapeStringForJson(mobileNumber)}"'},
  "password": ${password == null ? 'null' : '"${escapeStringForJson(password)}"'},
  "device_type": ${deviceType == null ? 'null' : '"${escapeStringForJson(deviceType)}"'},
  "device_token": ${deviceToken == null ? 'null' : '"${escapeStringForJson(deviceToken)}"'},
  "image": ${image == null ? 'null' : '"${escapeStringForJson(image)}"'},
  "id_token": ${idToken == null ? 'null' : '"${escapeStringForJson(idToken)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '${baseUrl}/login',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));
  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.result[:].id''',
      ));
  String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].user_name''',
      ));
  String? fullname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].full_name''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].email''',
      ));
  String? mobilenumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].mobile_number''',
      ));
  String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].image''',
      ));
  int? type(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.result[:].type''',
      ));
  String? bio(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].bio''',
      ));
  int? walletcoin(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.result[:].wallet_coin''',
      ));
  String? devicetoken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].device_token''',
      ));
  int? devicetype(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.result[:].device_type''',
      ));
  String? createdat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].created_at''',
      ));
  String? updatedat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result[:].updated_at''',
      ));
  int? userstatus(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.result[:].status''',
      ));
}

class ContentsByCategoryCall {
  Future<ApiCallResponse> call({
    String? categoryId = '',
    String? type = '1',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "category_id": ${categoryId == null ? 'null' : '"${escapeStringForJson(categoryId)}"'},
  "type": ${type == null ? 'null' : '"${escapeStringForJson(type)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ContentsByCategory',
      apiUrl: '${baseUrl}/get_content_by_category',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class EpisodesAudioByContentCall {
  Future<ApiCallResponse> call({
    String? contentId = '',
    String? userId = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();
    // Guests have no user id, and the server rejects an empty one ("The user id must be a number"): it accepts 0.
    if (userId == null || userId.trim().isEmpty) userId = '0';

    final ffApiRequestBody = '''
{
  "content_id": ${contentId == null ? 'null' : '"${escapeStringForJson(contentId)}"'},
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'EpisodesAudioByContent',
      apiUrl: '${baseUrl}/get_episode_audio_by_content',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class ArtistListCall {
  Future<ApiCallResponse> call({
    String? userId = '1',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ArtistList',
      apiUrl: '${baseUrl}/get_artist_suggestion_list',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class CategoriesCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Categories',
      apiUrl: '${baseUrl}/get_category',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class TrendingsCall {
  Future<ApiCallResponse> call({
    String? categoryId = '1',
    String? type = '1',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "category_id": ${categoryId == null ? 'null' : '"${escapeStringForJson(categoryId)}"'},
  "type": ${type == null ? 'null' : '"${escapeStringForJson(type)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Trendings',
      apiUrl: '${baseUrl}/get_content_by_category',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class ArtistContentsCall {
  Future<ApiCallResponse> call({
    String? artistId = '',
    String? type = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "artist_id": ${artistId == null ? 'null' : '"${escapeStringForJson(artistId)}"'},
  "type": ${type == null ? 'null' : '"${escapeStringForJson(type)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ArtistContents',
      apiUrl: '${baseUrl}/get_content_by_artist',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class SearchCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? type = '1',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": ${name == null ? 'null' : '"${escapeStringForJson(name)}"'},
  "type": ${type == null ? 'null' : '"${escapeStringForJson(type)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Search',
      apiUrl: '${baseUrl}/search_content',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class PaymentOptionsCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'PaymentOptions',
      apiUrl: '${baseUrl}/get_payment_option',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  dynamic result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
      );
}

class PackagesCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Packages',
      apiUrl: '${baseUrl}/get_package',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class AddOrRemoveBookmarkCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? contentType = '1',
    String? contentId = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'},
  "content_type": ${contentType == null ? 'null' : '"${escapeStringForJson(contentType)}"'},
  "content_id": ${contentId == null ? 'null' : '"${escapeStringForJson(contentId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddOrRemoveBookmark',
      apiUrl: '${baseUrl}/add_remove_bookmark',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class GetBookMarksCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetBookMarks',
      apiUrl: '${baseUrl}/get_bookmark_list',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class GetNotificationsCall {
  Future<ApiCallResponse> call({
    String? userid = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${userid == null ? 'null' : '"${escapeStringForJson(userid)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetNotifications',
      apiUrl: '${baseUrl}/get_notification',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class ReadNotificationCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? notificationId = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'},
  "notification_id": ${notificationId == null ? 'null' : '"${escapeStringForJson(notificationId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ReadNotification',
      apiUrl: '${baseUrl}/read_notification',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic statusCode(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

class PayForPackageCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? packageId = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'},
  "package_id": ${packageId == null ? 'null' : '"${escapeStringForJson(packageId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PayForPackage',
      apiUrl: '${baseUrl}/pay_for_package',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? responseCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.responseCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  String? lipanumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.checkout_response.payment_details.data[:].payment_token''',
      ));
  String? paymentlink(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.checkout_response.payment_details.data[:].payment_gateway_url''',
      ));
  String? trnlipano(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.checkout_response.transaction.lipa_number''',
      ));
  String? trnpaymentlink(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.checkout_response.transaction.payment_link''',
      ));
}

class BuyEpisodeCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? contentType = '',
    String? audiobookType = '',
    String? contentId = '',
    String? contentEpisodeId = '',
    String? coin = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${escapeStringForJson(userId)},
  "content_type": ${escapeStringForJson(contentType)},
  "audiobook_type": ${escapeStringForJson(audiobookType)},
  "content_id": ${escapeStringForJson(contentId)},
  "content_episode_id": ${escapeStringForJson(contentEpisodeId)},
  "coin": ${escapeStringForJson(coin)}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'BuyEpisode',
      apiUrl: '${baseUrl}/buy_content_episode',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? responseCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
        true,
      ) as List?;
}

/// One author's profile: photo, bio, follower count and whether the signed-in user follows them.
class ArtistDetailCall {
  Future<ApiCallResponse> call({
    String? artistId = '',
    String? userId = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "artist_id": ${artistId == null ? 'null' : '"${escapeStringForJson(artistId)}"'},
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ArtistDetail',
      apiUrl: '${baseUrl}/get_artist_detail',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// Follows or unfollows an author (it toggles).
class FollowCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? artistId = '',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": ${userId == null ? 'null' : '"${escapeStringForJson(userId)}"'},
  "artist_id": ${artistId == null ? 'null' : '"${escapeStringForJson(artistId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Follow',
      apiUrl: '${baseUrl}/add_remove_follow',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// Creates an email + password account. The response has the same shape as the Login call
/// (parse it with GeneralGroup.loginCall getters) and includes `token`.
class RegisterCall {
  Future<ApiCallResponse> call({
    String? fullName = '',
    String? email = '',
    String? mobileNumber = '',
    String? password = '',
    String? deviceType = '1',
  }) async {
    final baseUrl = GeneralGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "full_name": ${fullName == null ? 'null' : '"${escapeStringForJson(fullName)}"'},
  "email": ${email == null ? 'null' : '"${escapeStringForJson(email)}"'},
  "mobile_number": ${mobileNumber == null ? 'null' : '"${escapeStringForJson(mobileNumber)}"'},
  "password": ${password == null ? 'null' : '"${escapeStringForJson(password)}"'},
  "device_type": ${deviceType == null ? 'null' : '"${escapeStringForJson(deviceType)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Register',
      apiUrl: '${baseUrl}/auth/register',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// The signed-in user's profile (needs the stored token). Same response shape as Login.
class MeCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Me',
      apiUrl: '${baseUrl}/auth/me',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: '{}',
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// Revokes the current login token on the server.
class LogoutCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Logout',
      apiUrl: '${baseUrl}/auth/logout',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      body: '{}',
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AkCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'ak',
      apiUrl: '${baseUrl}/k',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AlCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'al',
      apiUrl: '${baseUrl}/l',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AmCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GeneralGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'am',
      apiUrl: '${baseUrl}/m',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End General Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  if (item is Color) {
    return item.toCssString();
  }
  if (item is LatLng) {
    return item.serialize();
  }
  if (item is DateTimeRange) {
    String millis(DateTime d) =>
        '${d.isUtc ? 'u' : 'l'}${d.millisecondsSinceEpoch}';
    return '${millis(item.start)}|${millis(item.end)}';
  }
  if (item is FFPlace) {
    return jsonEncode({
      'latLng': item.latLng.serialize(),
      'name': item.name,
      'address': item.address,
      'city': item.city,
      'state': item.state,
      'country': item.country,
      'zipCode': item.zipCode,
    });
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  final encoded = jsonEncode(input);
  return encoded.substring(1, encoded.length - 1);
}
