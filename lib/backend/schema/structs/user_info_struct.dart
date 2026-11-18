// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserInfoStruct extends BaseStruct {
  UserInfoStruct({
    String? id,
    String? prImg,
    String? fName,
    String? lName,
    String? email,
    String? password,
    String? dob,
    List<ArtistsMStruct>? likeArtist,
  })  : _id = id,
        _prImg = prImg,
        _fName = fName,
        _lName = lName,
        _email = email,
        _password = password,
        _dob = dob,
        _likeArtist = likeArtist;

  // "Id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "PrImg" field.
  String? _prImg;
  String get prImg => _prImg ?? '';
  set prImg(String? val) => _prImg = val;

  bool hasPrImg() => _prImg != null;

  // "FName" field.
  String? _fName;
  String get fName => _fName ?? '';
  set fName(String? val) => _fName = val;

  bool hasFName() => _fName != null;

  // "LName" field.
  String? _lName;
  String get lName => _lName ?? '';
  set lName(String? val) => _lName = val;

  bool hasLName() => _lName != null;

  // "Email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "Password" field.
  String? _password;
  String get password => _password ?? '';
  set password(String? val) => _password = val;

  bool hasPassword() => _password != null;

  // "Dob" field.
  String? _dob;
  String get dob => _dob ?? '';
  set dob(String? val) => _dob = val;

  bool hasDob() => _dob != null;

  // "LikeArtist" field.
  List<ArtistsMStruct>? _likeArtist;
  List<ArtistsMStruct> get likeArtist => _likeArtist ?? const [];
  set likeArtist(List<ArtistsMStruct>? val) => _likeArtist = val;

  void updateLikeArtist(Function(List<ArtistsMStruct>) updateFn) {
    updateFn(_likeArtist ??= []);
  }

  bool hasLikeArtist() => _likeArtist != null;

  static UserInfoStruct fromMap(Map<String, dynamic> data) => UserInfoStruct(
        id: data['Id'] as String?,
        prImg: data['PrImg'] as String?,
        fName: data['FName'] as String?,
        lName: data['LName'] as String?,
        email: data['Email'] as String?,
        password: data['Password'] as String?,
        dob: data['Dob'] as String?,
        likeArtist: getStructList(
          data['LikeArtist'],
          ArtistsMStruct.fromMap,
        ),
      );

  static UserInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Id': _id,
        'PrImg': _prImg,
        'FName': _fName,
        'LName': _lName,
        'Email': _email,
        'Password': _password,
        'Dob': _dob,
        'LikeArtist': _likeArtist?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Id': serializeParam(
          _id,
          ParamType.String,
        ),
        'PrImg': serializeParam(
          _prImg,
          ParamType.String,
        ),
        'FName': serializeParam(
          _fName,
          ParamType.String,
        ),
        'LName': serializeParam(
          _lName,
          ParamType.String,
        ),
        'Email': serializeParam(
          _email,
          ParamType.String,
        ),
        'Password': serializeParam(
          _password,
          ParamType.String,
        ),
        'Dob': serializeParam(
          _dob,
          ParamType.String,
        ),
        'LikeArtist': serializeParam(
          _likeArtist,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static UserInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserInfoStruct(
        id: deserializeParam(
          data['Id'],
          ParamType.String,
          false,
        ),
        prImg: deserializeParam(
          data['PrImg'],
          ParamType.String,
          false,
        ),
        fName: deserializeParam(
          data['FName'],
          ParamType.String,
          false,
        ),
        lName: deserializeParam(
          data['LName'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['Email'],
          ParamType.String,
          false,
        ),
        password: deserializeParam(
          data['Password'],
          ParamType.String,
          false,
        ),
        dob: deserializeParam(
          data['Dob'],
          ParamType.String,
          false,
        ),
        likeArtist: deserializeStructParam<ArtistsMStruct>(
          data['LikeArtist'],
          ParamType.DataStruct,
          true,
          structBuilder: ArtistsMStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'UserInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UserInfoStruct &&
        id == other.id &&
        prImg == other.prImg &&
        fName == other.fName &&
        lName == other.lName &&
        email == other.email &&
        password == other.password &&
        dob == other.dob &&
        listEquality.equals(likeArtist, other.likeArtist);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        prImg,
        fName,
        lName,
        email,
        password,
        dob,
        const ListEquality().hash(likeArtist)
      ]);
}

UserInfoStruct createUserInfoStruct({
  String? id,
  String? prImg,
  String? fName,
  String? lName,
  String? email,
  String? password,
  String? dob,
}) =>
    UserInfoStruct(
      id: id,
      prImg: prImg,
      fName: fName,
      lName: lName,
      email: email,
      password: password,
      dob: dob,
    );
