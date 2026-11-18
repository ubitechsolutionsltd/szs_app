// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NmStruct extends BaseStruct {
  NmStruct({
    String? title,
    String? titleHindi,
    String? titleArbic,
    String? time,
    String? timeHindi,
    String? timeArbic,
  })  : _title = title,
        _titleHindi = titleHindi,
        _titleArbic = titleArbic,
        _time = time,
        _timeHindi = timeHindi,
        _timeArbic = timeArbic;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "title_hindi" field.
  String? _titleHindi;
  String get titleHindi => _titleHindi ?? '';
  set titleHindi(String? val) => _titleHindi = val;

  bool hasTitleHindi() => _titleHindi != null;

  // "title_arbic" field.
  String? _titleArbic;
  String get titleArbic => _titleArbic ?? '';
  set titleArbic(String? val) => _titleArbic = val;

  bool hasTitleArbic() => _titleArbic != null;

  // "time" field.
  String? _time;
  String get time => _time ?? '';
  set time(String? val) => _time = val;

  bool hasTime() => _time != null;

  // "time_hindi" field.
  String? _timeHindi;
  String get timeHindi => _timeHindi ?? '';
  set timeHindi(String? val) => _timeHindi = val;

  bool hasTimeHindi() => _timeHindi != null;

  // "time_arbic" field.
  String? _timeArbic;
  String get timeArbic => _timeArbic ?? '';
  set timeArbic(String? val) => _timeArbic = val;

  bool hasTimeArbic() => _timeArbic != null;

  static NmStruct fromMap(Map<String, dynamic> data) => NmStruct(
        title: data['title'] as String?,
        titleHindi: data['title_hindi'] as String?,
        titleArbic: data['title_arbic'] as String?,
        time: data['time'] as String?,
        timeHindi: data['time_hindi'] as String?,
        timeArbic: data['time_arbic'] as String?,
      );

  static NmStruct? maybeFromMap(dynamic data) =>
      data is Map ? NmStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'title_hindi': _titleHindi,
        'title_arbic': _titleArbic,
        'time': _time,
        'time_hindi': _timeHindi,
        'time_arbic': _timeArbic,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'title_hindi': serializeParam(
          _titleHindi,
          ParamType.String,
        ),
        'title_arbic': serializeParam(
          _titleArbic,
          ParamType.String,
        ),
        'time': serializeParam(
          _time,
          ParamType.String,
        ),
        'time_hindi': serializeParam(
          _timeHindi,
          ParamType.String,
        ),
        'time_arbic': serializeParam(
          _timeArbic,
          ParamType.String,
        ),
      }.withoutNulls;

  static NmStruct fromSerializableMap(Map<String, dynamic> data) => NmStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        titleHindi: deserializeParam(
          data['title_hindi'],
          ParamType.String,
          false,
        ),
        titleArbic: deserializeParam(
          data['title_arbic'],
          ParamType.String,
          false,
        ),
        time: deserializeParam(
          data['time'],
          ParamType.String,
          false,
        ),
        timeHindi: deserializeParam(
          data['time_hindi'],
          ParamType.String,
          false,
        ),
        timeArbic: deserializeParam(
          data['time_arbic'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NmStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NmStruct &&
        title == other.title &&
        titleHindi == other.titleHindi &&
        titleArbic == other.titleArbic &&
        time == other.time &&
        timeHindi == other.timeHindi &&
        timeArbic == other.timeArbic;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([title, titleHindi, titleArbic, time, timeHindi, timeArbic]);
}

NmStruct createNmStruct({
  String? title,
  String? titleHindi,
  String? titleArbic,
  String? time,
  String? timeHindi,
  String? timeArbic,
}) =>
    NmStruct(
      title: title,
      titleHindi: titleHindi,
      titleArbic: titleArbic,
      time: time,
      timeHindi: timeHindi,
      timeArbic: timeArbic,
    );
