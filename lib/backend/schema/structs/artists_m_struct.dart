// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ArtistsMStruct extends BaseStruct {
  ArtistsMStruct({
    int? id,
    String? img,
    String? name,
    String? nameHindi,
    String? nameArbic,
    bool? isSelected,
    bool? isFeaturedA,
    bool? isBestArtist,
  })  : _id = id,
        _img = img,
        _name = name,
        _nameHindi = nameHindi,
        _nameArbic = nameArbic,
        _isSelected = isSelected,
        _isFeaturedA = isFeaturedA,
        _isBestArtist = isBestArtist;

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

  // "is_selected" field.
  bool? _isSelected;
  bool get isSelected => _isSelected ?? false;
  set isSelected(bool? val) => _isSelected = val;

  bool hasIsSelected() => _isSelected != null;

  // "is_featured_a" field.
  bool? _isFeaturedA;
  bool get isFeaturedA => _isFeaturedA ?? false;
  set isFeaturedA(bool? val) => _isFeaturedA = val;

  bool hasIsFeaturedA() => _isFeaturedA != null;

  // "is_best_artist" field.
  bool? _isBestArtist;
  bool get isBestArtist => _isBestArtist ?? false;
  set isBestArtist(bool? val) => _isBestArtist = val;

  bool hasIsBestArtist() => _isBestArtist != null;

  static ArtistsMStruct fromMap(Map<String, dynamic> data) => ArtistsMStruct(
        id: castToType<int>(data['id']),
        img: data['img'] as String?,
        name: data['name'] as String?,
        nameHindi: data['name_hindi'] as String?,
        nameArbic: data['name_arbic'] as String?,
        isSelected: data['is_selected'] as bool?,
        isFeaturedA: data['is_featured_a'] as bool?,
        isBestArtist: data['is_best_artist'] as bool?,
      );

  static ArtistsMStruct? maybeFromMap(dynamic data) =>
      data is Map ? ArtistsMStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'img': _img,
        'name': _name,
        'name_hindi': _nameHindi,
        'name_arbic': _nameArbic,
        'is_selected': _isSelected,
        'is_featured_a': _isFeaturedA,
        'is_best_artist': _isBestArtist,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
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
        'is_selected': serializeParam(
          _isSelected,
          ParamType.bool,
        ),
        'is_featured_a': serializeParam(
          _isFeaturedA,
          ParamType.bool,
        ),
        'is_best_artist': serializeParam(
          _isBestArtist,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ArtistsMStruct fromSerializableMap(Map<String, dynamic> data) =>
      ArtistsMStruct(
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
        isSelected: deserializeParam(
          data['is_selected'],
          ParamType.bool,
          false,
        ),
        isFeaturedA: deserializeParam(
          data['is_featured_a'],
          ParamType.bool,
          false,
        ),
        isBestArtist: deserializeParam(
          data['is_best_artist'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ArtistsMStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ArtistsMStruct &&
        id == other.id &&
        img == other.img &&
        name == other.name &&
        nameHindi == other.nameHindi &&
        nameArbic == other.nameArbic &&
        isSelected == other.isSelected &&
        isFeaturedA == other.isFeaturedA &&
        isBestArtist == other.isBestArtist;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        img,
        name,
        nameHindi,
        nameArbic,
        isSelected,
        isFeaturedA,
        isBestArtist
      ]);
}

ArtistsMStruct createArtistsMStruct({
  int? id,
  String? img,
  String? name,
  String? nameHindi,
  String? nameArbic,
  bool? isSelected,
  bool? isFeaturedA,
  bool? isBestArtist,
}) =>
    ArtistsMStruct(
      id: id,
      img: img,
      name: name,
      nameHindi: nameHindi,
      nameArbic: nameArbic,
      isSelected: isSelected,
      isFeaturedA: isFeaturedA,
      isBestArtist: isBestArtist,
    );
