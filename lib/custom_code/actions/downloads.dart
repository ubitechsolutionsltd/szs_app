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
import '/custom_code/ui/episode_unlock.dart';

/// Downloads an episode (an episode map from the API) for offline listening, tagged with [subtitle] (usually
/// the story's title, so the Downloads screen can group and label it). If the episode is locked and the
/// balance already covers it, it is bought automatically first, with no confirmation — same rule as "Listen
/// now". Returns false (nothing queued) when it is still locked afterwards, or on web.
Future<bool> downloadEpisode(dynamic episode, {String subtitle = ''}) async {
  if (episode is! Map || !DownloadManager.instance.supported) return false;
  if (!await EpisodeUnlock.silentUnlock(episode)) return false;
  DownloadManager.instance.download(PlayableItem.fromEpisodeMap(episode, subtitle: subtitle));
  return true;
}

/// Downloads every episode in [episodes] (an episode-map list), auto-buying locked ones the balance covers,
/// all tagged with [subtitle] (usually the story's title).
Future<DownloadBatchResult> downloadEpisodes(List<dynamic> episodes, {String subtitle = ''}) async {
  var queued = 0, skipped = 0;
  for (final episode in episodes) {
    if (episode is! Map) continue;
    if (await downloadEpisode(episode, subtitle: subtitle)) {
      queued++;
    } else {
      skipped++;
    }
  }
  return DownloadBatchResult(queued: queued, skipped: skipped);
}

/// How many episodes a bulk download actually queued, and how many stayed locked (not logged in, or the
/// balance did not cover them) and so were left out.
class DownloadBatchResult {
  const DownloadBatchResult({required this.queued, required this.skipped});
  final int queued;
  final int skipped;
}

/// Deletes a downloaded episode.
Future removeDownload(int episodeId) async {
  await DownloadManager.instance.remove(episodeId);
}

/// Resumes every download that failed (tapping the retry button on one does the same thing). A failure caused
/// by the episode being locked is retried too, buying it first when the balance now covers it.
Future<void> resumeAllDownloads() async {
  final manager = DownloadManager.instance;
  for (final item in manager.activeDownloads) {
    final state = manager.stateOf(item.id);
    if (state.status != DownloadStatus.failed) continue;
    if (state.locked && !await EpisodeUnlock.silentUnlock(item.raw)) continue;
    manager.download(item);
  }
}
