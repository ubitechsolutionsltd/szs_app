// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionStruct extends BaseStruct {
  TransactionStruct({
    int? userId,
    int? packageId,
    String? description,
    String? transactionId,
    int? status,
    String? price,
    int? coin,
    String? updatedAt,
    String? createdAt,
    int? id,
  })  : _userId = userId,
        _packageId = packageId,
        _description = description,
        _transactionId = transactionId,
        _status = status,
        _price = price,
        _coin = coin,
        _updatedAt = updatedAt,
        _createdAt = createdAt,
        _id = id;

  // "user_id" field.
  int? _userId;
  int get userId => _userId ?? 0;
  set userId(int? val) => _userId = val;

  void incrementUserId(int amount) => userId = userId + amount;

  bool hasUserId() => _userId != null;

  // "package_id" field.
  int? _packageId;
  int get packageId => _packageId ?? 0;
  set packageId(int? val) => _packageId = val;

  void incrementPackageId(int amount) => packageId = packageId + amount;

  bool hasPackageId() => _packageId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "transaction_id" field.
  String? _transactionId;
  String get transactionId => _transactionId ?? '';
  set transactionId(String? val) => _transactionId = val;

  bool hasTransactionId() => _transactionId != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  set status(int? val) => _status = val;

  void incrementStatus(int amount) => status = status + amount;

  bool hasStatus() => _status != null;

  // "price" field.
  String? _price;
  String get price => _price ?? '';
  set price(String? val) => _price = val;

  bool hasPrice() => _price != null;

  // "coin" field.
  int? _coin;
  int get coin => _coin ?? 0;
  set coin(int? val) => _coin = val;

  void incrementCoin(int amount) => coin = coin + amount;

  bool hasCoin() => _coin != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  static TransactionStruct fromMap(Map<String, dynamic> data) =>
      TransactionStruct(
        userId: castToType<int>(data['user_id']),
        packageId: castToType<int>(data['package_id']),
        description: data['description'] as String?,
        transactionId: data['transaction_id'] as String?,
        status: castToType<int>(data['status']),
        price: data['price'] as String?,
        coin: castToType<int>(data['coin']),
        updatedAt: data['updated_at'] as String?,
        createdAt: data['created_at'] as String?,
        id: castToType<int>(data['id']),
      );

  static TransactionStruct? maybeFromMap(dynamic data) => data is Map
      ? TransactionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user_id': _userId,
        'package_id': _packageId,
        'description': _description,
        'transaction_id': _transactionId,
        'status': _status,
        'price': _price,
        'coin': _coin,
        'updated_at': _updatedAt,
        'created_at': _createdAt,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_id': serializeParam(
          _userId,
          ParamType.int,
        ),
        'package_id': serializeParam(
          _packageId,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'transaction_id': serializeParam(
          _transactionId,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.int,
        ),
        'price': serializeParam(
          _price,
          ParamType.String,
        ),
        'coin': serializeParam(
          _coin,
          ParamType.int,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
      }.withoutNulls;

  static TransactionStruct fromSerializableMap(Map<String, dynamic> data) =>
      TransactionStruct(
        userId: deserializeParam(
          data['user_id'],
          ParamType.int,
          false,
        ),
        packageId: deserializeParam(
          data['package_id'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        transactionId: deserializeParam(
          data['transaction_id'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.int,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.String,
          false,
        ),
        coin: deserializeParam(
          data['coin'],
          ParamType.int,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'TransactionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TransactionStruct &&
        userId == other.userId &&
        packageId == other.packageId &&
        description == other.description &&
        transactionId == other.transactionId &&
        status == other.status &&
        price == other.price &&
        coin == other.coin &&
        updatedAt == other.updatedAt &&
        createdAt == other.createdAt &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([
        userId,
        packageId,
        description,
        transactionId,
        status,
        price,
        coin,
        updatedAt,
        createdAt,
        id
      ]);
}

TransactionStruct createTransactionStruct({
  int? userId,
  int? packageId,
  String? description,
  String? transactionId,
  int? status,
  String? price,
  int? coin,
  String? updatedAt,
  String? createdAt,
  int? id,
}) =>
    TransactionStruct(
      userId: userId,
      packageId: packageId,
      description: description,
      transactionId: transactionId,
      status: status,
      price: price,
      coin: coin,
      updatedAt: updatedAt,
      createdAt: createdAt,
      id: id,
    );
