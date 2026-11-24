import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_search_page_model.dart';
export 'home_search_page_model.dart';

class HomeSearchPageWidget extends StatefulWidget {
  const HomeSearchPageWidget({super.key});

  static String routeName = 'HomeSearchPage';
  static String routePath = '/homeSearchPage';

  @override
  State<HomeSearchPageWidget> createState() => _HomeSearchPageWidgetState();
}

class _HomeSearchPageWidgetState extends State<HomeSearchPageWidget>
    with TickerProviderStateMixin {
  late HomeSearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeSearchPageModel());

    _model.searchFieldTextController ??= TextEditingController();
    _model.searchFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'songContainerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
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
      body: const custom_widgets.SearchView(autofocus: true, showBack: true),
    );
  }
}
