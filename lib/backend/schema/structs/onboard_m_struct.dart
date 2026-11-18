// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OnboardMStruct extends BaseStruct {
  OnboardMStruct({
    int? id,
    String? backImg,
    String? img,
    String? title,
    String? subTitle,
  })  : _id = id,
        _backImg = backImg,
        _img = img,
        _title = title,
        _subTitle = subTitle;

  // "Id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "BackImg" field.
  String? _backImg;
  String get backImg => _backImg ?? '';
  set backImg(String? val) => _backImg = val;

  bool hasBackImg() => _backImg != null;

  // "Img" field.
  String? _img;
  String get img => _img ?? '';
  set img(String? val) => _img = val;

  bool hasImg() => _img != null;

  // "Title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "SubTitle" field.
  String? _subTitle;
  String get subTitle => _subTitle ?? '';
  set subTitle(String? val) => _subTitle = val;

  bool hasSubTitle() => _subTitle != null;

  static OnboardMStruct fromMap(Map<String, dynamic> data) => OnboardMStruct(
        id: castToType<int>(data['Id']),
        backImg: data['BackImg'] as String?,
        img: data['Img'] as String?,
        title: data['Title'] as String?,
        subTitle: data['SubTitle'] as String?,
      );

  static OnboardMStruct? maybeFromMap(dynamic data) =>
      data is Map ? OnboardMStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Id': _id,
        'BackImg': _backImg,
        'Img': _img,
        'Title': _title,
        'SubTitle': _subTitle,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Id': serializeParam(
          _id,
          ParamType.int,
        ),
        'BackImg': serializeParam(
          _backImg,
          ParamType.String,
        ),
        'Img': serializeParam(
          _img,
          ParamType.String,
        ),
        'Title': serializeParam(
          _title,
          ParamType.String,
        ),
        'SubTitle': serializeParam(
          _subTitle,
          ParamType.String,
        ),
      }.withoutNulls;

  static OnboardMStruct fromSerializableMap(Map<String, dynamic> data) =>
      OnboardMStruct(
        id: deserializeParam(
          data['Id'],
          ParamType.int,
          false,
        ),
        backImg: deserializeParam(
          data['BackImg'],
          ParamType.String,
          false,
        ),
        img: deserializeParam(
          data['Img'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['Title'],
          ParamType.String,
          false,
        ),
        subTitle: deserializeParam(
          data['SubTitle'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OnboardMStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OnboardMStruct &&
        id == other.id &&
        backImg == other.backImg &&
        img == other.img &&
        title == other.title &&
        subTitle == other.subTitle;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, backImg, img, title, subTitle]);
}

OnboardMStruct createOnboardMStruct({
  int? id,
  String? backImg,
  String? img,
  String? title,
  String? subTitle,
}) =>
    OnboardMStruct(
      id: id,
      backImg: backImg,
      img: img,
      title: title,
      subTitle: subTitle,
    );
