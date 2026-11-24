import '/custom_code/ui/app_logo.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/wave_background.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'splash_page_model.dart';
export 'splash_page_model.dart';

class SplashPageWidget extends StatefulWidget {
  const SplashPageWidget({super.key});

  static String routeName = 'SplashPage';
  static String routePath = '/splashPage';

  @override
  State<SplashPageWidget> createState() => _SplashPageWidgetState();
}

class _SplashPageWidgetState extends State<SplashPageWidget>
    with TickerProviderStateMixin {
  late SplashPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(
          milliseconds: 2200,
        ),
      );
      if (FFAppState().isIntro == true) {
        if (FFAppState().isLogin == true) {
          if (FFAppState().isInfo == true) {
            context.goNamed(HomePageWidget.routeName);
          } else {
            context.goNamed(HomePageWidget.routeName);
          }
        } else {
          // Browsing is open to everyone; login is only required for actions
          // that need an account (bookmarking, following, buying an episode).
          FFAppState().skipUser = true;
          context.goNamed(HomePageWidget.routeName);
        }
      } else {
        context.goNamed(OnboardingPageWidget.routeName);
      }
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 2000.0.ms,
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
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTokens.brandPrimary,
      body: WaveBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.22),
                          blurRadius: 30.0,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const AppLogo(size: 116.0, radius: 34.0),
                  ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
                  const SizedBox(height: 22.0),
                  Text(
                    'Simulizi za Sauti',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppTokens.fontFamily,
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                  const SizedBox(height: 8.0),
                  Text(
                    trs('about_tagline'),
                    style: TextStyle(
                      fontFamily: AppTokens.fontFamily,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.4,
                    ),
                  ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                  const SizedBox(height: 48.0),
                  const SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      backgroundColor: Color(0x33FFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
