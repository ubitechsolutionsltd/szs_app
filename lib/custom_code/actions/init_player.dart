// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/player/audio_handler.dart';
import '/custom_code/player/player_service.dart';
import '/custom_code/player/playlist_store.dart';

/// Run once at app start (FlutterFlow: Settings > Initial custom action, or call it before runApp).
/// Never throws: if background playback is not set up natively the app still plays in the foreground.
Future initPlayer() async {
  try {
    await PlayerService.instance.init();
    await PlaylistStore.instance.init();
    await BackgroundAudio.start(PlayerService.instance);
  } catch (e) {
    debugPrint('initPlayer failed: $e');
  }
}
