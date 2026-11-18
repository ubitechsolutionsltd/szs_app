// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CmStruct extends BaseStruct {
  CmStruct({
    int? id,
    String? img,
    String? cName,
    String? cNHindi,
    String? cNArbic,
  })  : _id = id,
        _img = img,
        _cName = cName,
        _cNHindi = cNHindi,
        _cNArbic = cNArbic;

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

  // "c_name" field.
  String? _cName;
  String get cName => _cName ?? '';
  set cName(String? val) => _cName = val;

  bool hasCName() => _cName != null;

  // "c_n_hindi" field.
  String? _cNHindi;
  String get cNHindi => _cNHindi ?? '';
  set cNHindi(String? val) => _cNHindi = val;

  bool hasCNHindi() => _cNHindi != null;

  // "c_n_arbic" field.
  String? _cNArbic;
  String get cNArbic => _cNArbic ?? '';
  set cNArbic(String? val) => _cNArbic = val;

  bool hasCNArbic() => _cNArbic != null;

  static CmStruct fromMap(Map<String, dynamic> data) => CmStruct(
        id: castToType<int>(data['id']),
        img: data['img'] as String?,
        cName: data['c_name'] as String?,
        cNHindi: data['c_n_hindi'] as String?,
        cNArbic: data['c_n_arbic'] as String?,
      );

  static CmStruct? maybeFromMap(dynamic data) =>
      data is Map ? CmStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'img': _img,
        'c_name': _cName,
        'c_n_hindi': _cNHindi,
        'c_n_arbic': _cNArbic,
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
        'c_name': serializeParam(
          _cName,
          ParamType.String,
        ),
        'c_n_hindi': serializeParam(
          _cNHindi,
          ParamType.String,
        ),
        'c_n_arbic': serializeParam(
          _cNArbic,
          ParamType.String,
        ),
      }.withoutNulls;

  static CmStruct fromSerializableMap(Map<String, dynamic> data) => CmStruct(
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
        cName: deserializeParam(
          data['c_name'],
          ParamType.String,
          false,
        ),
        cNHindi: deserializeParam(
          data['c_n_hindi'],
          ParamType.String,
          false,
        ),
        cNArbic: deserializeParam(
          data['c_n_arbic'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CmStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CmStruct &&
        id == other.id &&
        img == other.img &&
        cName == other.cName &&
        cNHindi == other.cNHindi &&
        cNArbic == other.cNArbic;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, img, cName, cNHindi, cNArbic]);
}

CmStruct createCmStruct({
  int? id,
  String? img,
  String? cName,
  String? cNHindi,
  String? cNArbic,
}) =>
    CmStruct(
      id: id,
      img: img,
      cName: cName,
      cNHindi: cNHindi,
      cNArbic: cNArbic,
    );
