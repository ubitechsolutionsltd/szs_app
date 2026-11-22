// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/player/player_service.dart';

/// Controls the player from a FlutterFlow action flow. [command]: toggle, play, pause, next, previous,
/// forward30, back15, shuffle, repeat.
Future playerCommand(String command) async {
  final service = PlayerService.instance;
  switch (command) {
    case 'toggle':
      await service.toggle();
    case 'play':
      await service.play();
    case 'pause':
      await service.pause();
    case 'next':
      await service.next();
    case 'previous':
      await service.previous();
    case 'forward30':
      await service.seekRelative(const Duration(seconds: 30));
    case 'back15':
      await service.seekRelative(const Duration(seconds: -15));
    case 'shuffle':
      service.setShuffle(!service.snapshot.value.shuffle);
    case 'repeat':
      service.cycleRepeat();
  }
}
