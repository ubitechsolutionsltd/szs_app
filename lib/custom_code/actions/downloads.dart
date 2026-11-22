// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/player/download_manager.dart';
import '/custom_code/player/player_core.dart';

/// Downloads an episode (an episode map from the API) for offline listening. No-op if it is locked or on web.
Future downloadEpisode(dynamic episode) async {
  if (episode is! Map) return;
  DownloadManager.instance.download(PlayableItem.fromEpisodeMap(episode));
}

/// Deletes a downloaded episode.
Future removeDownload(int episodeId) async {
  await DownloadManager.instance.remove(episodeId);
}
