import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<MusicMStruct> filterSongList(
  String title,
  List<MusicMStruct> songList,
) {
  if (title.trim().isEmpty) return songList;

  title = title.trim().toLowerCase();

  return songList.where((item) {
    final name = item.name.toLowerCase();
    return name.contains(title);
  }).toList();
}

List<String> extractPlaylistItems(
  List<dynamic> data,
  String key,
) {
  List<String> results = [];

  if (data.isEmpty) return results;

  for (var item in data) {
    try {
      // Access key safely
      final value = item[key];
      if (value != null) {
        results.add(value.toString());
      }
    } catch (e) {
      // Skip items that are not proper objects
      continue;
    }
  }

  return results;
}

int getStringLength(String stringInput) {
  return stringInput.length;
}

String getAudioPathFromUrl(String url) {
  return url;
}

int jsonValueToInteger(dynamic value) {
  if (value == null) return 0;

  if (value is int) return value;

  if (value is String) {
    return int.tryParse(value) ?? 0;
  }

  return 0;
}

int newWalletBalance(
  int oldbalance,
  int episodePrice,
) {
  return oldbalance - episodePrice;
}

dynamic getAdjacentEpisode(
  dynamic currentEpisode,
  List<dynamic> allEpisodes,
  String command,
) {
  if (currentEpisode == null || currentEpisode is! Map || allEpisodes.isEmpty) {
    return null;
  }

  // Find index by matching ID
  final currentId = currentEpisode['id'];
  final index = allEpisodes.indexWhere(
    (ep) => ep is Map && ep['id'] == currentId,
  );

  if (index == -1) {
    return null;
  }

  // NEXT
  if (command.toLowerCase() == 'next') {
    final nextIndex = index + 1;
    if (nextIndex < allEpisodes.length) {
      return Map<String, dynamic>.from(allEpisodes[nextIndex]);
    }
  }

  // PREVIOUS
  if (command.toLowerCase() == 'prev') {
    final prevIndex = index - 1;
    if (prevIndex >= 0) {
      return Map<String, dynamic>.from(allEpisodes[prevIndex]);
    }
  }

  return null;
}

String buildIframeHtml(String iframeSrc) {
  return '''
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      body {
        margin: 0;
        padding: 0;
        overflow: hidden;
      }
      iframe {
        width: 100%;
        height: 620px;
        border: 0;
      }
    </style>
  </head>
  <body>
    <iframe src="$iframeSrc" scrolling="auto">
      <p>Unable to load the Payment Page</p>
    </iframe>
  </body>
</html>
''';
}
