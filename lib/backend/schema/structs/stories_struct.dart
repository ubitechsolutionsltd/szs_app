// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Group of Stories
class StoriesStruct extends BaseStruct {
  StoriesStruct({
    List<StoryStruct>? stories,
  }) : _stories = stories;

  // "stories" field.
  List<StoryStruct>? _stories;
  List<StoryStruct> get stories => _stories ?? const [];
  set stories(List<StoryStruct>? val) => _stories = val;

  void updateStories(Function(List<StoryStruct>) updateFn) {
    updateFn(_stories ??= []);
  }

  bool hasStories() => _stories != null;

  static StoriesStruct fromMap(Map<String, dynamic> data) => StoriesStruct(
        stories: getStructList(
          data['stories'],
          StoryStruct.fromMap,
        ),
      );

  static StoriesStruct? maybeFromMap(dynamic data) =>
      data is Map ? StoriesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'stories': _stories?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'stories': serializeParam(
          _stories,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static StoriesStruct fromSerializableMap(Map<String, dynamic> data) =>
      StoriesStruct(
        stories: deserializeStructParam<StoryStruct>(
          data['stories'],
          ParamType.DataStruct,
          true,
          structBuilder: StoryStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'StoriesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is StoriesStruct &&
        listEquality.equals(stories, other.stories);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([const ListEquality().hash(stories)]);
}

StoriesStruct createStoriesStruct() => StoriesStruct();
