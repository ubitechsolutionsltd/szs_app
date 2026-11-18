// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StoryStruct extends BaseStruct {
  StoryStruct({
    int? id,
    int? contentType,
    int? artistId,
    int? categoryId,
    int? languageId,
    String? title,
    String? portraitImg,
    String? landscapeImg,
    String? webBannerImg,
    String? description,
    String? fullNovel,
    int? isPaidNovel,
    int? novelCoin,
    int? totalPlayed,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? categoryName,
    String? artistName,
    String? languageName,
    String? avgRating,
    int? totalEpisode,
    int? totalReviews,
    int? totalUserPlay,
    int? isBookmark,
  })  : _id = id,
        _contentType = contentType,
        _artistId = artistId,
        _categoryId = categoryId,
        _languageId = languageId,
        _title = title,
        _portraitImg = portraitImg,
        _landscapeImg = landscapeImg,
        _webBannerImg = webBannerImg,
        _description = description,
        _fullNovel = fullNovel,
        _isPaidNovel = isPaidNovel,
        _novelCoin = novelCoin,
        _totalPlayed = totalPlayed,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _categoryName = categoryName,
        _artistName = artistName,
        _languageName = languageName,
        _avgRating = avgRating,
        _totalEpisode = totalEpisode,
        _totalReviews = totalReviews,
        _totalUserPlay = totalUserPlay,
        _isBookmark = isBookmark;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "content_type" field.
  int? _contentType;
  int get contentType => _contentType ?? 0;
  set contentType(int? val) => _contentType = val;

  void incrementContentType(int amount) => contentType = contentType + amount;

  bool hasContentType() => _contentType != null;

  // "artist_id" field.
  int? _artistId;
  int get artistId => _artistId ?? 0;
  set artistId(int? val) => _artistId = val;

  void incrementArtistId(int amount) => artistId = artistId + amount;

  bool hasArtistId() => _artistId != null;

  // "category_id" field.
  int? _categoryId;
  int get categoryId => _categoryId ?? 0;
  set categoryId(int? val) => _categoryId = val;

  void incrementCategoryId(int amount) => categoryId = categoryId + amount;

  bool hasCategoryId() => _categoryId != null;

  // "language_id" field.
  int? _languageId;
  int get languageId => _languageId ?? 0;
  set languageId(int? val) => _languageId = val;

  void incrementLanguageId(int amount) => languageId = languageId + amount;

  bool hasLanguageId() => _languageId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "portrait_img" field.
  String? _portraitImg;
  String get portraitImg => _portraitImg ?? '';
  set portraitImg(String? val) => _portraitImg = val;

  bool hasPortraitImg() => _portraitImg != null;

  // "landscape_img" field.
  String? _landscapeImg;
  String get landscapeImg => _landscapeImg ?? '';
  set landscapeImg(String? val) => _landscapeImg = val;

  bool hasLandscapeImg() => _landscapeImg != null;

  // "web_banner_img" field.
  String? _webBannerImg;
  String get webBannerImg => _webBannerImg ?? '';
  set webBannerImg(String? val) => _webBannerImg = val;

  bool hasWebBannerImg() => _webBannerImg != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "full_novel" field.
  String? _fullNovel;
  String get fullNovel => _fullNovel ?? '';
  set fullNovel(String? val) => _fullNovel = val;

  bool hasFullNovel() => _fullNovel != null;

  // "is_paid_novel" field.
  int? _isPaidNovel;
  int get isPaidNovel => _isPaidNovel ?? 0;
  set isPaidNovel(int? val) => _isPaidNovel = val;

  void incrementIsPaidNovel(int amount) => isPaidNovel = isPaidNovel + amount;

  bool hasIsPaidNovel() => _isPaidNovel != null;

  // "novel_coin" field.
  int? _novelCoin;
  int get novelCoin => _novelCoin ?? 0;
  set novelCoin(int? val) => _novelCoin = val;

  void incrementNovelCoin(int amount) => novelCoin = novelCoin + amount;

  bool hasNovelCoin() => _novelCoin != null;

  // "total_played" field.
  int? _totalPlayed;
  int get totalPlayed => _totalPlayed ?? 0;
  set totalPlayed(int? val) => _totalPlayed = val;

  void incrementTotalPlayed(int amount) => totalPlayed = totalPlayed + amount;

  bool hasTotalPlayed() => _totalPlayed != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  set status(int? val) => _status = val;

  void incrementStatus(int amount) => status = status + amount;

  bool hasStatus() => _status != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "category_name" field.
  String? _categoryName;
  String get categoryName => _categoryName ?? '';
  set categoryName(String? val) => _categoryName = val;

  bool hasCategoryName() => _categoryName != null;

  // "artist_name" field.
  String? _artistName;
  String get artistName => _artistName ?? '';
  set artistName(String? val) => _artistName = val;

  bool hasArtistName() => _artistName != null;

  // "language_name" field.
  String? _languageName;
  String get languageName => _languageName ?? '';
  set languageName(String? val) => _languageName = val;

  bool hasLanguageName() => _languageName != null;

  // "avg_rating" field.
  String? _avgRating;
  String get avgRating => _avgRating ?? '';
  set avgRating(String? val) => _avgRating = val;

  bool hasAvgRating() => _avgRating != null;

  // "total_episode" field.
  int? _totalEpisode;
  int get totalEpisode => _totalEpisode ?? 0;
  set totalEpisode(int? val) => _totalEpisode = val;

  void incrementTotalEpisode(int amount) =>
      totalEpisode = totalEpisode + amount;

  bool hasTotalEpisode() => _totalEpisode != null;

  // "total_reviews" field.
  int? _totalReviews;
  int get totalReviews => _totalReviews ?? 0;
  set totalReviews(int? val) => _totalReviews = val;

  void incrementTotalReviews(int amount) =>
      totalReviews = totalReviews + amount;

  bool hasTotalReviews() => _totalReviews != null;

  // "total_user_play" field.
  int? _totalUserPlay;
  int get totalUserPlay => _totalUserPlay ?? 0;
  set totalUserPlay(int? val) => _totalUserPlay = val;

  void incrementTotalUserPlay(int amount) =>
      totalUserPlay = totalUserPlay + amount;

  bool hasTotalUserPlay() => _totalUserPlay != null;

  // "is_bookmark" field.
  int? _isBookmark;
  int get isBookmark => _isBookmark ?? 0;
  set isBookmark(int? val) => _isBookmark = val;

  void incrementIsBookmark(int amount) => isBookmark = isBookmark + amount;

  bool hasIsBookmark() => _isBookmark != null;

  static StoryStruct fromMap(Map<String, dynamic> data) => StoryStruct(
        id: castToType<int>(data['id']),
        contentType: castToType<int>(data['content_type']),
        artistId: castToType<int>(data['artist_id']),
        categoryId: castToType<int>(data['category_id']),
        languageId: castToType<int>(data['language_id']),
        title: data['title'] as String?,
        portraitImg: data['portrait_img'] as String?,
        landscapeImg: data['landscape_img'] as String?,
        webBannerImg: data['web_banner_img'] as String?,
        description: data['description'] as String?,
        fullNovel: data['full_novel'] as String?,
        isPaidNovel: castToType<int>(data['is_paid_novel']),
        novelCoin: castToType<int>(data['novel_coin']),
        totalPlayed: castToType<int>(data['total_played']),
        status: castToType<int>(data['status']),
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        categoryName: data['category_name'] as String?,
        artistName: data['artist_name'] as String?,
        languageName: data['language_name'] as String?,
        avgRating: data['avg_rating'] as String?,
        totalEpisode: castToType<int>(data['total_episode']),
        totalReviews: castToType<int>(data['total_reviews']),
        totalUserPlay: castToType<int>(data['total_user_play']),
        isBookmark: castToType<int>(data['is_bookmark']),
      );

  static StoryStruct? maybeFromMap(dynamic data) =>
      data is Map ? StoryStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'content_type': _contentType,
        'artist_id': _artistId,
        'category_id': _categoryId,
        'language_id': _languageId,
        'title': _title,
        'portrait_img': _portraitImg,
        'landscape_img': _landscapeImg,
        'web_banner_img': _webBannerImg,
        'description': _description,
        'full_novel': _fullNovel,
        'is_paid_novel': _isPaidNovel,
        'novel_coin': _novelCoin,
        'total_played': _totalPlayed,
        'status': _status,
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'category_name': _categoryName,
        'artist_name': _artistName,
        'language_name': _languageName,
        'avg_rating': _avgRating,
        'total_episode': _totalEpisode,
        'total_reviews': _totalReviews,
        'total_user_play': _totalUserPlay,
        'is_bookmark': _isBookmark,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'content_type': serializeParam(
          _contentType,
          ParamType.int,
        ),
        'artist_id': serializeParam(
          _artistId,
          ParamType.int,
        ),
        'category_id': serializeParam(
          _categoryId,
          ParamType.int,
        ),
        'language_id': serializeParam(
          _languageId,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'portrait_img': serializeParam(
          _portraitImg,
          ParamType.String,
        ),
        'landscape_img': serializeParam(
          _landscapeImg,
          ParamType.String,
        ),
        'web_banner_img': serializeParam(
          _webBannerImg,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'full_novel': serializeParam(
          _fullNovel,
          ParamType.String,
        ),
        'is_paid_novel': serializeParam(
          _isPaidNovel,
          ParamType.int,
        ),
        'novel_coin': serializeParam(
          _novelCoin,
          ParamType.int,
        ),
        'total_played': serializeParam(
          _totalPlayed,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
        'category_name': serializeParam(
          _categoryName,
          ParamType.String,
        ),
        'artist_name': serializeParam(
          _artistName,
          ParamType.String,
        ),
        'language_name': serializeParam(
          _languageName,
          ParamType.String,
        ),
        'avg_rating': serializeParam(
          _avgRating,
          ParamType.String,
        ),
        'total_episode': serializeParam(
          _totalEpisode,
          ParamType.int,
        ),
        'total_reviews': serializeParam(
          _totalReviews,
          ParamType.int,
        ),
        'total_user_play': serializeParam(
          _totalUserPlay,
          ParamType.int,
        ),
        'is_bookmark': serializeParam(
          _isBookmark,
          ParamType.int,
        ),
      }.withoutNulls;

  static StoryStruct fromSerializableMap(Map<String, dynamic> data) =>
      StoryStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        contentType: deserializeParam(
          data['content_type'],
          ParamType.int,
          false,
        ),
        artistId: deserializeParam(
          data['artist_id'],
          ParamType.int,
          false,
        ),
        categoryId: deserializeParam(
          data['category_id'],
          ParamType.int,
          false,
        ),
        languageId: deserializeParam(
          data['language_id'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        portraitImg: deserializeParam(
          data['portrait_img'],
          ParamType.String,
          false,
        ),
        landscapeImg: deserializeParam(
          data['landscape_img'],
          ParamType.String,
          false,
        ),
        webBannerImg: deserializeParam(
          data['web_banner_img'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        fullNovel: deserializeParam(
          data['full_novel'],
          ParamType.String,
          false,
        ),
        isPaidNovel: deserializeParam(
          data['is_paid_novel'],
          ParamType.int,
          false,
        ),
        novelCoin: deserializeParam(
          data['novel_coin'],
          ParamType.int,
          false,
        ),
        totalPlayed: deserializeParam(
          data['total_played'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
        categoryName: deserializeParam(
          data['category_name'],
          ParamType.String,
          false,
        ),
        artistName: deserializeParam(
          data['artist_name'],
          ParamType.String,
          false,
        ),
        languageName: deserializeParam(
          data['language_name'],
          ParamType.String,
          false,
        ),
        avgRating: deserializeParam(
          data['avg_rating'],
          ParamType.String,
          false,
        ),
        totalEpisode: deserializeParam(
          data['total_episode'],
          ParamType.int,
          false,
        ),
        totalReviews: deserializeParam(
          data['total_reviews'],
          ParamType.int,
          false,
        ),
        totalUserPlay: deserializeParam(
          data['total_user_play'],
          ParamType.int,
          false,
        ),
        isBookmark: deserializeParam(
          data['is_bookmark'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'StoryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StoryStruct &&
        id == other.id &&
        contentType == other.contentType &&
        artistId == other.artistId &&
        categoryId == other.categoryId &&
        languageId == other.languageId &&
        title == other.title &&
        portraitImg == other.portraitImg &&
        landscapeImg == other.landscapeImg &&
        webBannerImg == other.webBannerImg &&
        description == other.description &&
        fullNovel == other.fullNovel &&
        isPaidNovel == other.isPaidNovel &&
        novelCoin == other.novelCoin &&
        totalPlayed == other.totalPlayed &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        categoryName == other.categoryName &&
        artistName == other.artistName &&
        languageName == other.languageName &&
        avgRating == other.avgRating &&
        totalEpisode == other.totalEpisode &&
        totalReviews == other.totalReviews &&
        totalUserPlay == other.totalUserPlay &&
        isBookmark == other.isBookmark;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        contentType,
        artistId,
        categoryId,
        languageId,
        title,
        portraitImg,
        landscapeImg,
        webBannerImg,
        description,
        fullNovel,
        isPaidNovel,
        novelCoin,
        totalPlayed,
        status,
        createdAt,
        updatedAt,
        categoryName,
        artistName,
        languageName,
        avgRating,
        totalEpisode,
        totalReviews,
        totalUserPlay,
        isBookmark
      ]);
}

StoryStruct createStoryStruct({
  int? id,
  int? contentType,
  int? artistId,
  int? categoryId,
  int? languageId,
  String? title,
  String? portraitImg,
  String? landscapeImg,
  String? webBannerImg,
  String? description,
  String? fullNovel,
  int? isPaidNovel,
  int? novelCoin,
  int? totalPlayed,
  int? status,
  String? createdAt,
  String? updatedAt,
  String? categoryName,
  String? artistName,
  String? languageName,
  String? avgRating,
  int? totalEpisode,
  int? totalReviews,
  int? totalUserPlay,
  int? isBookmark,
}) =>
    StoryStruct(
      id: id,
      contentType: contentType,
      artistId: artistId,
      categoryId: categoryId,
      languageId: languageId,
      title: title,
      portraitImg: portraitImg,
      landscapeImg: landscapeImg,
      webBannerImg: webBannerImg,
      description: description,
      fullNovel: fullNovel,
      isPaidNovel: isPaidNovel,
      novelCoin: novelCoin,
      totalPlayed: totalPlayed,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      categoryName: categoryName,
      artistName: artistName,
      languageName: languageName,
      avgRating: avgRating,
      totalEpisode: totalEpisode,
      totalReviews: totalReviews,
      totalUserPlay: totalUserPlay,
      isBookmark: isBookmark,
    );
