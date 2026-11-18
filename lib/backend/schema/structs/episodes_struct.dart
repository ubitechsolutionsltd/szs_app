// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EpisodesStruct extends BaseStruct {
  EpisodesStruct({
    List<EpisodeStruct>? episode,
  }) : _episode = episode;

  // "episode" field.
  List<EpisodeStruct>? _episode;
  List<EpisodeStruct> get episode => _episode ?? const [];
  set episode(List<EpisodeStruct>? val) => _episode = val;

  void updateEpisode(Function(List<EpisodeStruct>) updateFn) {
    updateFn(_episode ??= []);
  }

  bool hasEpisode() => _episode != null;

  static EpisodesStruct fromMap(Map<String, dynamic> data) => EpisodesStruct(
        episode: getStructList(
          data['episode'],
          EpisodeStruct.fromMap,
        ),
      );

  static EpisodesStruct? maybeFromMap(dynamic data) =>
      data is Map ? EpisodesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'episode': _episode?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'episode': serializeParam(
          _episode,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static EpisodesStruct fromSerializableMap(Map<String, dynamic> data) =>
      EpisodesStruct(
        episode: deserializeStructParam<EpisodeStruct>(
          data['episode'],
          ParamType.DataStruct,
          true,
          structBuilder: EpisodeStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'EpisodesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EpisodesStruct &&
        listEquality.equals(episode, other.episode);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([const ListEquality().hash(episode)]);
}

EpisodesStruct createEpisodesStruct() => EpisodesStruct();
