import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'choose_artist_like_page_widget.dart' show ChooseArtistLikePageWidget;
import 'package:flutter/material.dart';

class ChooseArtistLikePageModel
    extends FlutterFlowModel<ChooseArtistLikePageWidget> {
  ///  Local state fields for this page.

  List<int> likedArtist = [];
  void addToLikedArtist(int item) => likedArtist.add(item);
  void removeFromLikedArtist(int item) => likedArtist.remove(item);
  void removeAtIndexFromLikedArtist(int index) => likedArtist.removeAt(index);
  void insertAtIndexInLikedArtist(int index, int item) =>
      likedArtist.insert(index, item);
  void updateLikedArtistAtIndex(int index, Function(int) updateFn) =>
      likedArtist[index] = updateFn(likedArtist[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
