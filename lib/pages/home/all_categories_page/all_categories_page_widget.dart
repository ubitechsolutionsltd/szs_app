import '/custom_code/widgets/index.dart' as custom_widgets;
import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'all_categories_page_model.dart';
export 'all_categories_page_model.dart';

class AllCategoriesPageWidget extends StatefulWidget {
  const AllCategoriesPageWidget({super.key});

  static String routeName = 'AllCategoriesPage';
  static String routePath = '/allCategoriesPage';

  @override
  State<AllCategoriesPageWidget> createState() =>
      _AllCategoriesPageWidgetState();
}

class _AllCategoriesPageWidgetState extends State<AllCategoriesPageWidget>
    with TickerProviderStateMixin {
  late AllCategoriesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllCategoriesPageModel());

    animationsMap.addAll({
      'catContainerThreeOnPageLoadAnimation': AnimationInfo(
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: trs('tuwluj0n'),
                  backIcon: false,
                  addIcon: false,
                  onTapAdd: () async {},
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    custom_widgets.CategoryGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
