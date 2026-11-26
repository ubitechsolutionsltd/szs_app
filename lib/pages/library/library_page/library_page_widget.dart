import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'library_page_model.dart';
export 'library_page_model.dart';

class LibraryPageWidget extends StatefulWidget {
  const LibraryPageWidget({super.key});

  static String routeName = 'LibraryPage';
  static String routePath = '/libraryPage';

  @override
  State<LibraryPageWidget> createState() => _LibraryPageWidgetState();
}

class _LibraryPageWidgetState extends State<LibraryPageWidget>
    with TickerProviderStateMixin {
  late LibraryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LibraryPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      body: const custom_widgets.LibraryView(),
    );
  }
}
