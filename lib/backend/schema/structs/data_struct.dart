// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataStruct extends BaseStruct {
  DataStruct({
    String? paymentToken,
    String? paymentGatewayUrl,
  })  : _paymentToken = paymentToken,
        _paymentGatewayUrl = paymentGatewayUrl;

  // "payment_token" field.
  String? _paymentToken;
  String get paymentToken => _paymentToken ?? '';
  set paymentToken(String? val) => _paymentToken = val;

  bool hasPaymentToken() => _paymentToken != null;

  // "payment_gateway_url" field.
  String? _paymentGatewayUrl;
  String get paymentGatewayUrl => _paymentGatewayUrl ?? '';
  set paymentGatewayUrl(String? val) => _paymentGatewayUrl = val;

  bool hasPaymentGatewayUrl() => _paymentGatewayUrl != null;

  static DataStruct fromMap(Map<String, dynamic> data) => DataStruct(
        paymentToken: data['payment_token'] as String?,
        paymentGatewayUrl: data['payment_gateway_url'] as String?,
      );

  static DataStruct? maybeFromMap(dynamic data) =>
      data is Map ? DataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'payment_token': _paymentToken,
        'payment_gateway_url': _paymentGatewayUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'payment_token': serializeParam(
          _paymentToken,
          ParamType.String,
        ),
        'payment_gateway_url': serializeParam(
          _paymentGatewayUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static DataStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataStruct(
        paymentToken: deserializeParam(
          data['payment_token'],
          ParamType.String,
          false,
        ),
        paymentGatewayUrl: deserializeParam(
          data['payment_gateway_url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DataStruct &&
        paymentToken == other.paymentToken &&
        paymentGatewayUrl == other.paymentGatewayUrl;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([paymentToken, paymentGatewayUrl]);
}

DataStruct createDataStruct({
  String? paymentToken,
  String? paymentGatewayUrl,
}) =>
    DataStruct(
      paymentToken: paymentToken,
      paymentGatewayUrl: paymentGatewayUrl,
    );
