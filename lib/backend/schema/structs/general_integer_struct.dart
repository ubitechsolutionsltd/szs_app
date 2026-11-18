// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GeneralIntegerStruct extends BaseStruct {
  GeneralIntegerStruct({
    int? value,
  }) : _value = value;

  // "value" field.
  int? _value;
  int get value => _value ?? 0;
  set value(int? val) => _value = val;

  void incrementValue(int amount) => value = value + amount;

  bool hasValue() => _value != null;

  static GeneralIntegerStruct fromMap(Map<String, dynamic> data) =>
      GeneralIntegerStruct(
        value: castToType<int>(data['value']),
      );

  static GeneralIntegerStruct? maybeFromMap(dynamic data) => data is Map
      ? GeneralIntegerStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'value': serializeParam(
          _value,
          ParamType.int,
        ),
      }.withoutNulls;

  static GeneralIntegerStruct fromSerializableMap(Map<String, dynamic> data) =>
      GeneralIntegerStruct(
        value: deserializeParam(
          data['value'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'GeneralIntegerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GeneralIntegerStruct && value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([value]);
}

GeneralIntegerStruct createGeneralIntegerStruct({
  int? value,
}) =>
    GeneralIntegerStruct(
      value: value,
    );
