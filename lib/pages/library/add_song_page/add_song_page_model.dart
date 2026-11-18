import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_song_page_widget.dart' show AddSongPageWidget;
import 'package:flutter/material.dart';

class AddSongPageModel extends FlutterFlowModel<AddSongPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomCenterAppBar component.
  late CustomCenterAppBarModel customCenterAppBarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    customCenterAppBarModel =
        createModel(context, () => CustomCenterAppBarModel());
  }

  @override
  void dispose() {
    customCenterAppBarModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
