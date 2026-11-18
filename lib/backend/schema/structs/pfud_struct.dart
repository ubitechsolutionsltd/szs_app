// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PfudStruct extends BaseStruct {
  PfudStruct({
    int? id,
    String? img,
    String? name,
    String? nameHindi,
    String? nameArbic,
  })  : _id = id,
        _img = img,
        _name = name,
        _nameHindi = nameHindi,
        _nameArbic = nameArbic;

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

  static PfudStruct fromMap(Map<String, dynamic> data) => PfudStruct(
        id: castToType<int>(data['id']),
        img: data['img'] as String?,
        name: data['name'] as String?,
        nameHindi: data['name_hindi'] as String?,
        nameArbic: data['name_arbic'] as String?,
      );

  static PfudStruct? maybeFromMap(dynamic data) =>
      data is Map ? PfudStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'img': _img,
        'name': _name,
        'name_hindi': _nameHindi,
        'name_arbic': _nameArbic,
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
      }.withoutNulls;

  static PfudStruct fromSerializableMap(Map<String, dynamic> data) =>
      PfudStruct(
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
      );

  @override
  String toString() => 'PfudStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PfudStruct &&
        id == other.id &&
        img == other.img &&
        name == other.name &&
        nameHindi == other.nameHindi &&
        nameArbic == other.nameArbic;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, img, name, nameHindi, nameArbic]);
}

PfudStruct createPfudStruct({
  int? id,
  String? img,
  String? name,
  String? nameHindi,
  String? nameArbic,
}) =>
    PfudStruct(
      id: id,
      img: img,
      name: name,
      nameHindi: nameHindi,
      nameArbic: nameArbic,
    );
