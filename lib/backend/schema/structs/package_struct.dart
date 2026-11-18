// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

///             "id": 1,
///             "name": "Kangaroo",
///             "image":
/// "https://szs.co.tz/storage/app/public/package/21_04_2025_82_680630b02617c.jpg",
///             "price": 10000,
///             "coin": 100,
///             "android_product_package": "",
///             "ios_product_package": "",
///             "status": 1,
///             "created_at": "2025-04-21T11:49:04.000000Z",
///             "updated_at": "2025-04-21T11:49:04.000000Z"
class PackageStruct extends BaseStruct {
  PackageStruct({
    int? id,
    String? name,
    String? image,
    double? price,
    int? coin,
    String? androidProductPackage,
    String? iosProductPackage,
    int? status,
    String? createdAt,
    String? updatedAt,
  })  : _id = id,
        _name = name,
        _image = image,
        _price = price,
        _coin = coin,
        _androidProductPackage = androidProductPackage,
        _iosProductPackage = iosProductPackage,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

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

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "coin" field.
  int? _coin;
  int get coin => _coin ?? 0;
  set coin(int? val) => _coin = val;

  void incrementCoin(int amount) => coin = coin + amount;

  bool hasCoin() => _coin != null;

  // "android_product_package" field.
  String? _androidProductPackage;
  String get androidProductPackage => _androidProductPackage ?? '';
  set androidProductPackage(String? val) => _androidProductPackage = val;

  bool hasAndroidProductPackage() => _androidProductPackage != null;

  // "ios_product_package" field.
  String? _iosProductPackage;
  String get iosProductPackage => _iosProductPackage ?? '';
  set iosProductPackage(String? val) => _iosProductPackage = val;

  bool hasIosProductPackage() => _iosProductPackage != null;

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

  static PackageStruct fromMap(Map<String, dynamic> data) => PackageStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        image: data['image'] as String?,
        price: castToType<double>(data['price']),
        coin: castToType<int>(data['coin']),
        androidProductPackage: data['android_product_package'] as String?,
        iosProductPackage: data['ios_product_package'] as String?,
        status: castToType<int>(data['status']),
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  static PackageStruct? maybeFromMap(dynamic data) =>
      data is Map ? PackageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'image': _image,
        'price': _price,
        'coin': _coin,
        'android_product_package': _androidProductPackage,
        'ios_product_package': _iosProductPackage,
        'status': _status,
        'created_at': _createdAt,
        'updated_at': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
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
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'coin': serializeParam(
          _coin,
          ParamType.int,
        ),
        'android_product_package': serializeParam(
          _androidProductPackage,
          ParamType.String,
        ),
        'ios_product_package': serializeParam(
          _iosProductPackage,
          ParamType.String,
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
      }.withoutNulls;

  static PackageStruct fromSerializableMap(Map<String, dynamic> data) =>
      PackageStruct(
        id: deserializeParam(
          data['id'],
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
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        coin: deserializeParam(
          data['coin'],
          ParamType.int,
          false,
        ),
        androidProductPackage: deserializeParam(
          data['android_product_package'],
          ParamType.String,
          false,
        ),
        iosProductPackage: deserializeParam(
          data['ios_product_package'],
          ParamType.String,
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
      );

  @override
  String toString() => 'PackageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackageStruct &&
        id == other.id &&
        name == other.name &&
        image == other.image &&
        price == other.price &&
        coin == other.coin &&
        androidProductPackage == other.androidProductPackage &&
        iosProductPackage == other.iosProductPackage &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        image,
        price,
        coin,
        androidProductPackage,
        iosProductPackage,
        status,
        createdAt,
        updatedAt
      ]);
}

PackageStruct createPackageStruct({
  int? id,
  String? name,
  String? image,
  double? price,
  int? coin,
  String? androidProductPackage,
  String? iosProductPackage,
  int? status,
  String? createdAt,
  String? updatedAt,
}) =>
    PackageStruct(
      id: id,
      name: name,
      image: image,
      price: price,
      coin: coin,
      androidProductPackage: androidProductPackage,
      iosProductPackage: iosProductPackage,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
