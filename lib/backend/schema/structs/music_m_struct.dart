// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MusicMStruct extends BaseStruct {
  MusicMStruct({
    int? prid,
    int? id,
    String? img,
    String? name,
    String? nameHindi,
    String? nameArbic,
    String? subTitle,
    String? sTHindi,
    String? sTArbic,
    bool? isQuickPick,
    bool? isTs,
    bool? isAlbum,
    bool? inPlaylist,
    bool? relatedSong,
  })  : _prid = prid,
        _id = id,
        _img = img,
        _name = name,
        _nameHindi = nameHindi,
        _nameArbic = nameArbic,
        _subTitle = subTitle,
        _sTHindi = sTHindi,
        _sTArbic = sTArbic,
        _isQuickPick = isQuickPick,
        _isTs = isTs,
        _isAlbum = isAlbum,
        _inPlaylist = inPlaylist,
        _relatedSong = relatedSong;

  // "prid" field.
  int? _prid;
  int get prid => _prid ?? 0;
  set prid(int? val) => _prid = val;

  void incrementPrid(int amount) => prid = prid + amount;

  bool hasPrid() => _prid != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "img" field.
  String? _img;
  String get img => _img ?? '';
  set img(String? val) => _img = val;

  bool hasImg() => _img != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "name_hindi" field.
  String? _nameHindi;
  String get nameHindi => _nameHindi ?? '';
  set nameHindi(String? val) => _nameHindi = val;

  bool hasNameHindi() => _nameHindi != null;

  // "name_arbic" field.
  String? _nameArbic;
  String get nameArbic => _nameArbic ?? '';
  set nameArbic(String? val) => _nameArbic = val;

  bool hasNameArbic() => _nameArbic != null;

  // "sub_title" field.
  String? _subTitle;
  String get subTitle => _subTitle ?? '';
  set subTitle(String? val) => _subTitle = val;

  bool hasSubTitle() => _subTitle != null;

  // "s_t_hindi" field.
  String? _sTHindi;
  String get sTHindi => _sTHindi ?? '';
  set sTHindi(String? val) => _sTHindi = val;

  bool hasSTHindi() => _sTHindi != null;

  // "s_t_arbic" field.
  String? _sTArbic;
  String get sTArbic => _sTArbic ?? '';
  set sTArbic(String? val) => _sTArbic = val;

  bool hasSTArbic() => _sTArbic != null;

  // "is_quick_pick" field.
  bool? _isQuickPick;
  bool get isQuickPick => _isQuickPick ?? false;
  set isQuickPick(bool? val) => _isQuickPick = val;

  bool hasIsQuickPick() => _isQuickPick != null;

  // "is_ts" field.
  bool? _isTs;
  bool get isTs => _isTs ?? false;
  set isTs(bool? val) => _isTs = val;

  bool hasIsTs() => _isTs != null;

  // "is_album" field.
  bool? _isAlbum;
  bool get isAlbum => _isAlbum ?? false;
  set isAlbum(bool? val) => _isAlbum = val;

  bool hasIsAlbum() => _isAlbum != null;

  // "in_playlist" field.
  bool? _inPlaylist;
  bool get inPlaylist => _inPlaylist ?? false;
  set inPlaylist(bool? val) => _inPlaylist = val;

  bool hasInPlaylist() => _inPlaylist != null;

  // "related_song" field.
  bool? _relatedSong;
  bool get relatedSong => _relatedSong ?? false;
  set relatedSong(bool? val) => _relatedSong = val;

  bool hasRelatedSong() => _relatedSong != null;

  static MusicMStruct fromMap(Map<String, dynamic> data) => MusicMStruct(
        prid: castToType<int>(data['prid']),
        id: castToType<int>(data['id']),
        img: data['img'] as String?,
        name: data['name'] as String?,
        nameHindi: data['name_hindi'] as String?,
        nameArbic: data['name_arbic'] as String?,
        subTitle: data['sub_title'] as String?,
        sTHindi: data['s_t_hindi'] as String?,
        sTArbic: data['s_t_arbic'] as String?,
        isQuickPick: data['is_quick_pick'] as bool?,
        isTs: data['is_ts'] as bool?,
        isAlbum: data['is_album'] as bool?,
        inPlaylist: data['in_playlist'] as bool?,
        relatedSong: data['related_song'] as bool?,
      );

  static MusicMStruct? maybeFromMap(dynamic data) =>
      data is Map ? MusicMStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'prid': _prid,
        'id': _id,
        'img': _img,
        'name': _name,
        'name_hindi': _nameHindi,
        'name_arbic': _nameArbic,
        'sub_title': _subTitle,
        's_t_hindi': _sTHindi,
        's_t_arbic': _sTArbic,
        'is_quick_pick': _isQuickPick,
        'is_ts': _isTs,
        'is_album': _isAlbum,
        'in_playlist': _inPlaylist,
        'related_song': _relatedSong,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'prid': serializeParam(
          _prid,
          ParamType.int,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'img': serializeParam(
          _img,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'name_hindi': serializeParam(
          _nameHindi,
          ParamType.String,
        ),
        'name_arbic': serializeParam(
          _nameArbic,
          ParamType.String,
        ),
        'sub_title': serializeParam(
          _subTitle,
          ParamType.String,
        ),
        's_t_hindi': serializeParam(
          _sTHindi,
          ParamType.String,
        ),
        's_t_arbic': serializeParam(
          _sTArbic,
          ParamType.String,
        ),
        'is_quick_pick': serializeParam(
          _isQuickPick,
          ParamType.bool,
        ),
        'is_ts': serializeParam(
          _isTs,
          ParamType.bool,
        ),
        'is_album': serializeParam(
          _isAlbum,
          ParamType.bool,
        ),
        'in_playlist': serializeParam(
          _inPlaylist,
          ParamType.bool,
        ),
        'related_song': serializeParam(
          _relatedSong,
          ParamType.bool,
        ),
      }.withoutNulls;

  static MusicMStruct fromSerializableMap(Map<String, dynamic> data) =>
      MusicMStruct(
        prid: deserializeParam(
          data['prid'],
          ParamType.int,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        img: deserializeParam(
          data['img'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        nameHindi: deserializeParam(
          data['name_hindi'],
          ParamType.String,
          false,
        ),
        nameArbic: deserializeParam(
          data['name_arbic'],
          ParamType.String,
          false,
        ),
        subTitle: deserializeParam(
          data['sub_title'],
          ParamType.String,
          false,
        ),
        sTHindi: deserializeParam(
          data['s_t_hindi'],
          ParamType.String,
          false,
        ),
        sTArbic: deserializeParam(
          data['s_t_arbic'],
          ParamType.String,
          false,
        ),
        isQuickPick: deserializeParam(
          data['is_quick_pick'],
          ParamType.bool,
          false,
        ),
        isTs: deserializeParam(
          data['is_ts'],
          ParamType.bool,
          false,
        ),
        isAlbum: deserializeParam(
          data['is_album'],
          ParamType.bool,
          false,
        ),
        inPlaylist: deserializeParam(
          data['in_playlist'],
          ParamType.bool,
          false,
        ),
        relatedSong: deserializeParam(
          data['related_song'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'MusicMStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MusicMStruct &&
        prid == other.prid &&
        id == other.id &&
        img == other.img &&
        name == other.name &&
        nameHindi == other.nameHindi &&
        nameArbic == other.nameArbic &&
        subTitle == other.subTitle &&
        sTHindi == other.sTHindi &&
        sTArbic == other.sTArbic &&
        isQuickPick == other.isQuickPick &&
        isTs == other.isTs &&
        isAlbum == other.isAlbum &&
        inPlaylist == other.inPlaylist &&
        relatedSong == other.relatedSong;
  }

  @override
  int get hashCode => const ListEquality().hash([
        prid,
        id,
        img,
        name,
        nameHindi,
        nameArbic,
        subTitle,
        sTHindi,
        sTArbic,
        isQuickPick,
        isTs,
        isAlbum,
        inPlaylist,
        relatedSong
      ]);
}

MusicMStruct createMusicMStruct({
  int? prid,
  int? id,
  String? img,
  String? name,
  String? nameHindi,
  String? nameArbic,
  String? subTitle,
  String? sTHindi,
  String? sTArbic,
  bool? isQuickPick,
  bool? isTs,
  bool? isAlbum,
  bool? inPlaylist,
  bool? relatedSong,
}) =>
    MusicMStruct(
      prid: prid,
      id: id,
      img: img,
      name: name,
      nameHindi: nameHindi,
      nameArbic: nameArbic,
      subTitle: subTitle,
      sTHindi: sTHindi,
      sTArbic: sTArbic,
      isQuickPick: isQuickPick,
      isTs: isTs,
      isAlbum: isAlbum,
      inPlaylist: inPlaylist,
      relatedSong: relatedSong,
    );
