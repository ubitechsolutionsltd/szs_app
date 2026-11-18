// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EpisodeStruct extends BaseStruct {
  EpisodeStruct({
    int? id,
    int? contentId,
    String? name,
    String? image,
    String? description,
    int? audioType,
    String? audio,
    int? audioDuration,
    int? isAudioPaid,
    int? isAudioCoin,
    int? totalAudioPlayed,
    int? videoType,
    int? videoDuration,
    int? isVideoPaid,
    int? isVideoCoin,
    int? totalVideoPlayed,
    String? book,
    int? isBookPaid,
    int? isBookCoin,
    int? totalBookPlayed,
    int? sortable,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? stopTime,
    int? isBuy,
  })  : _id = id,
        _contentId = contentId,
        _name = name,
        _image = image,
        _description = description,
        _audioType = audioType,
        _audio = audio,
        _audioDuration = audioDuration,
        _isAudioPaid = isAudioPaid,
        _isAudioCoin = isAudioCoin,
        _totalAudioPlayed = totalAudioPlayed,
        _videoType = videoType,
        _videoDuration = videoDuration,
        _isVideoPaid = isVideoPaid,
        _isVideoCoin = isVideoCoin,
        _totalVideoPlayed = totalVideoPlayed,
        _book = book,
        _isBookPaid = isBookPaid,
        _isBookCoin = isBookCoin,
        _totalBookPlayed = totalBookPlayed,
        _sortable = sortable,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _stopTime = stopTime,
        _isBuy = isBuy;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "content_id" field.
  int? _contentId;
  int get contentId => _contentId ?? 0;
  set contentId(int? val) => _contentId = val;

  void incrementContentId(int amount) => contentId = contentId + amount;

  bool hasContentId() => _contentId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "audio_type" field.
  int? _audioType;
  int get audioType => _audioType ?? 0;
  set audioType(int? val) => _audioType = val;

  void incrementAudioType(int amount) => audioType = audioType + amount;

  bool hasAudioType() => _audioType != null;

  // "audio" field.
  String? _audio;
  String get audio => _audio ?? '';
  set audio(String? val) => _audio = val;

  bool hasAudio() => _audio != null;

  // "audio_duration" field.
  int? _audioDuration;
  int get audioDuration => _audioDuration ?? 0;
  set audioDuration(int? val) => _audioDuration = val;

  void incrementAudioDuration(int amount) =>
      audioDuration = audioDuration + amount;

  bool hasAudioDuration() => _audioDuration != null;

  // "is_audio_paid" field.
  int? _isAudioPaid;
  int get isAudioPaid => _isAudioPaid ?? 0;
  set isAudioPaid(int? val) => _isAudioPaid = val;

  void incrementIsAudioPaid(int amount) => isAudioPaid = isAudioPaid + amount;

  bool hasIsAudioPaid() => _isAudioPaid != null;

  // "is_audio_coin" field.
  int? _isAudioCoin;
  int get isAudioCoin => _isAudioCoin ?? 0;
  set isAudioCoin(int? val) => _isAudioCoin = val;

  void incrementIsAudioCoin(int amount) => isAudioCoin = isAudioCoin + amount;

  bool hasIsAudioCoin() => _isAudioCoin != null;

  // "total_audio_played" field.
  int? _totalAudioPlayed;
  int get totalAudioPlayed => _totalAudioPlayed ?? 0;
  set totalAudioPlayed(int? val) => _totalAudioPlayed = val;

  void incrementTotalAudioPlayed(int amount) =>
      totalAudioPlayed = totalAudioPlayed + amount;

  bool hasTotalAudioPlayed() => _totalAudioPlayed != null;

  // "video_type" field.
  int? _videoType;
  int get videoType => _videoType ?? 0;
  set videoType(int? val) => _videoType = val;

  void incrementVideoType(int amount) => videoType = videoType + amount;

  bool hasVideoType() => _videoType != null;

  // "video_duration" field.
  int? _videoDuration;
  int get videoDuration => _videoDuration ?? 0;
  set videoDuration(int? val) => _videoDuration = val;

  void incrementVideoDuration(int amount) =>
      videoDuration = videoDuration + amount;

  bool hasVideoDuration() => _videoDuration != null;

  // "is_video_paid" field.
  int? _isVideoPaid;
  int get isVideoPaid => _isVideoPaid ?? 0;
  set isVideoPaid(int? val) => _isVideoPaid = val;

  void incrementIsVideoPaid(int amount) => isVideoPaid = isVideoPaid + amount;

  bool hasIsVideoPaid() => _isVideoPaid != null;

  // "is_video_coin" field.
  int? _isVideoCoin;
  int get isVideoCoin => _isVideoCoin ?? 0;
  set isVideoCoin(int? val) => _isVideoCoin = val;

  void incrementIsVideoCoin(int amount) => isVideoCoin = isVideoCoin + amount;

  bool hasIsVideoCoin() => _isVideoCoin != null;

  // "total_video_played" field.
  int? _totalVideoPlayed;
  int get totalVideoPlayed => _totalVideoPlayed ?? 0;
  set totalVideoPlayed(int? val) => _totalVideoPlayed = val;

  void incrementTotalVideoPlayed(int amount) =>
      totalVideoPlayed = totalVideoPlayed + amount;

  bool hasTotalVideoPlayed() => _totalVideoPlayed != null;

  // "book" field.
  String? _book;
  String get book => _book ?? '';
  set book(String? val) => _book = val;

  bool hasBook() => _book != null;

  // "is_book_paid" field.
  int? _isBookPaid;
  int get isBookPaid => _isBookPaid ?? 0;
  set isBookPaid(int? val) => _isBookPaid = val;

  void incrementIsBookPaid(int amount) => isBookPaid = isBookPaid + amount;

  bool hasIsBookPaid() => _isBookPaid != null;

  // "is_book_coin" field.
  int? _isBookCoin;
  int get isBookCoin => _isBookCoin ?? 0;
  set isBookCoin(int? val) => _isBookCoin = val;

  void incrementIsBookCoin(int amount) => isBookCoin = isBookCoin + amount;

  bool hasIsBookCoin() => _isBookCoin != null;

  // "total_book_played" field.
  int? _totalBookPlayed;
  int get totalBookPlayed => _totalBookPlayed ?? 0;
  set totalBookPlayed(int? val) => _totalBookPlayed = val;

  void incrementTotalBookPlayed(int amount) =>
      totalBookPlayed = totalBookPlayed + amount;

  bool hasTotalBookPlayed() => _totalBookPlayed != null;

  // "sortable" field.
  int? _sortable;
  int get sortable => _sortable ?? 0;
  set sortable(int? val) => _sortable = val;

  void incrementSortable(int amount) => sortable = sortable + amount;

  bool hasSortable() => _sortable != null;

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

  // "stop_time" field.
  int? _stopTime;
  int get stopTime => _stopTime ?? 0;
  set stopTime(int? val) => _stopTime = val;

  void incrementStopTime(int amount) => stopTime = stopTime + amount;

  bool hasStopTime() => _stopTime != null;

  // "is_buy" field.
  int? _isBuy;
  int get isBuy => _isBuy ?? 0;
  set isBuy(int? val) => _isBuy = val;

  void incrementIsBuy(int amount) => isBuy = isBuy + amount;

  bool hasIsBuy() => _isBuy != null;

  static EpisodeStruct fromMap(Map<String, dynamic> data) => EpisodeStruct(
        id: castToType<int>(data['id']),
        contentId: castToType<int>(data['content_id']),
        name: data['name'] as String?,
        image: data['image'] as String?,
        description: data['description'] as String?,
        audioType: castToType<int>(data['audio_type']),
        audio: data['audio'] as String?,
        audioDuration: castToType<int>(data['audio_duration']),
        isAudioPaid: castToType<int>(data['is_audio_paid']),
        isAudioCoin: castToType<int>(data['is_audio_coin']),
        totalAudioPlayed: castToType<int>(data['total_audio_played']),
        videoType: castToType<int>(data['video_type']),
        videoDuration: castToType<int>(data['video_duration']),
        isVideoPaid: castToType<int>(data['is_video_paid']),
        isVideoCoin: castToType<int>(data['is_video_coin']),
        totalVideoPlayed: castToType<int>(data['total_video_played']),
        book: data['book'] as String?,
        isBookPaid: castToType<int>(data['is_book_paid']),
        isBookCoin: castToType<int>(data['is_book_coin']),
        totalBookPlayed: castToType<int>(data['total_book_played']),
        sortable: castToType<int>(data['sortable']),
        status: castToType<int>(data['status']),
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        stopTime: castToType<int>(data['stop_time']),
        isBuy: castToType<int>(data['is_buy']),
      );

  static EpisodeStruct? maybeFromMap(dynamic data) =>
      data is Map ? EpisodeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'content_id': _contentId,
        'name': _name,
        'image': _image,
        'description': _description,
        'audio_type': _audioType,
        'audio': _audio,
        'audio_duration': _audioDuration,
        'is_audio_paid': _isAudioPaid,
        'is_audio_coin': _isAudioCoin,
        'total_audio_played': _totalAudioPlayed,
        'video_type': _videoType,
        'video_duration': _videoDuration,
        'is_video_paid': _isVideoPaid,
        'is_video_coin': _isVideoCoin,
        'total_video_played': _totalVideoPlayed,
        'book': _book,
        'is_book_paid': _isBookPaid,
        'is_book_coin': _isBookCoin,
        'total_book_played': _totalBookPlayed,
        'sortable': _sortable,
        'status': _status,
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'stop_time': _stopTime,
        'is_buy': _isBuy,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'content_id': serializeParam(
          _contentId,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'audio_type': serializeParam(
          _audioType,
          ParamType.int,
        ),
        'audio': serializeParam(
          _audio,
          ParamType.String,
        ),
        'audio_duration': serializeParam(
          _audioDuration,
          ParamType.int,
        ),
        'is_audio_paid': serializeParam(
          _isAudioPaid,
          ParamType.int,
        ),
        'is_audio_coin': serializeParam(
          _isAudioCoin,
          ParamType.int,
        ),
        'total_audio_played': serializeParam(
          _totalAudioPlayed,
          ParamType.int,
        ),
        'video_type': serializeParam(
          _videoType,
          ParamType.int,
        ),
        'video_duration': serializeParam(
          _videoDuration,
          ParamType.int,
        ),
        'is_video_paid': serializeParam(
          _isVideoPaid,
          ParamType.int,
        ),
        'is_video_coin': serializeParam(
          _isVideoCoin,
          ParamType.int,
        ),
        'total_video_played': serializeParam(
          _totalVideoPlayed,
          ParamType.int,
        ),
        'book': serializeParam(
          _book,
          ParamType.String,
        ),
        'is_book_paid': serializeParam(
          _isBookPaid,
          ParamType.int,
        ),
        'is_book_coin': serializeParam(
          _isBookCoin,
          ParamType.int,
        ),
        'total_book_played': serializeParam(
          _totalBookPlayed,
          ParamType.int,
        ),
        'sortable': serializeParam(
          _sortable,
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
        'stop_time': serializeParam(
          _stopTime,
          ParamType.int,
        ),
        'is_buy': serializeParam(
          _isBuy,
          ParamType.int,
        ),
      }.withoutNulls;

  static EpisodeStruct fromSerializableMap(Map<String, dynamic> data) =>
      EpisodeStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        contentId: deserializeParam(
          data['content_id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        audioType: deserializeParam(
          data['audio_type'],
          ParamType.int,
          false,
        ),
        audio: deserializeParam(
          data['audio'],
          ParamType.String,
          false,
        ),
        audioDuration: deserializeParam(
          data['audio_duration'],
          ParamType.int,
          false,
        ),
        isAudioPaid: deserializeParam(
          data['is_audio_paid'],
          ParamType.int,
          false,
        ),
        isAudioCoin: deserializeParam(
          data['is_audio_coin'],
          ParamType.int,
          false,
        ),
        totalAudioPlayed: deserializeParam(
          data['total_audio_played'],
          ParamType.int,
          false,
        ),
        videoType: deserializeParam(
          data['video_type'],
          ParamType.int,
          false,
        ),
        videoDuration: deserializeParam(
          data['video_duration'],
          ParamType.int,
          false,
        ),
        isVideoPaid: deserializeParam(
          data['is_video_paid'],
          ParamType.int,
          false,
        ),
        isVideoCoin: deserializeParam(
          data['is_video_coin'],
          ParamType.int,
          false,
        ),
        totalVideoPlayed: deserializeParam(
          data['total_video_played'],
          ParamType.int,
          false,
        ),
        book: deserializeParam(
          data['book'],
          ParamType.String,
          false,
        ),
        isBookPaid: deserializeParam(
          data['is_book_paid'],
          ParamType.int,
          false,
        ),
        isBookCoin: deserializeParam(
          data['is_book_coin'],
          ParamType.int,
          false,
        ),
        totalBookPlayed: deserializeParam(
          data['total_book_played'],
          ParamType.int,
          false,
        ),
        sortable: deserializeParam(
          data['sortable'],
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
        stopTime: deserializeParam(
          data['stop_time'],
          ParamType.int,
          false,
        ),
        isBuy: deserializeParam(
          data['is_buy'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'EpisodeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EpisodeStruct &&
        id == other.id &&
        contentId == other.contentId &&
        name == other.name &&
        image == other.image &&
        description == other.description &&
        audioType == other.audioType &&
        audio == other.audio &&
        audioDuration == other.audioDuration &&
        isAudioPaid == other.isAudioPaid &&
        isAudioCoin == other.isAudioCoin &&
        totalAudioPlayed == other.totalAudioPlayed &&
        videoType == other.videoType &&
        videoDuration == other.videoDuration &&
        isVideoPaid == other.isVideoPaid &&
        isVideoCoin == other.isVideoCoin &&
        totalVideoPlayed == other.totalVideoPlayed &&
        book == other.book &&
        isBookPaid == other.isBookPaid &&
        isBookCoin == other.isBookCoin &&
        totalBookPlayed == other.totalBookPlayed &&
        sortable == other.sortable &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        stopTime == other.stopTime &&
        isBuy == other.isBuy;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        contentId,
        name,
        image,
        description,
        audioType,
        audio,
        audioDuration,
        isAudioPaid,
        isAudioCoin,
        totalAudioPlayed,
        videoType,
        videoDuration,
        isVideoPaid,
        isVideoCoin,
        totalVideoPlayed,
        book,
        isBookPaid,
        isBookCoin,
        totalBookPlayed,
        sortable,
        status,
        createdAt,
        updatedAt,
        stopTime,
        isBuy
      ]);
}

EpisodeStruct createEpisodeStruct({
  int? id,
  int? contentId,
  String? name,
  String? image,
  String? description,
  int? audioType,
  String? audio,
  int? audioDuration,
  int? isAudioPaid,
  int? isAudioCoin,
  int? totalAudioPlayed,
  int? videoType,
  int? videoDuration,
  int? isVideoPaid,
  int? isVideoCoin,
  int? totalVideoPlayed,
  String? book,
  int? isBookPaid,
  int? isBookCoin,
  int? totalBookPlayed,
  int? sortable,
  int? status,
  String? createdAt,
  String? updatedAt,
  int? stopTime,
  int? isBuy,
}) =>
    EpisodeStruct(
      id: id,
      contentId: contentId,
      name: name,
      image: image,
      description: description,
      audioType: audioType,
      audio: audio,
      audioDuration: audioDuration,
      isAudioPaid: isAudioPaid,
      isAudioCoin: isAudioCoin,
      totalAudioPlayed: totalAudioPlayed,
      videoType: videoType,
      videoDuration: videoDuration,
      isVideoPaid: isVideoPaid,
      isVideoCoin: isVideoCoin,
      totalVideoPlayed: totalVideoPlayed,
      book: book,
      isBookPaid: isBookPaid,
      isBookCoin: isBookCoin,
      totalBookPlayed: totalBookPlayed,
      sortable: sortable,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      stopTime: stopTime,
      isBuy: isBuy,
    );
