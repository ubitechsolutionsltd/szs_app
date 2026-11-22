import '/backend/schema/structs/index.dart';
import '/custom_code/ui/glass.dart';
import '/custom_code/ui/app_logo.dart';
import '/custom_code/ui/app_palette.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'onboarding_page_model.dart';
export 'onboarding_page_model.dart';

class OnboardingPageWidget extends StatefulWidget {
  const OnboardingPageWidget({super.key});

  static String routeName = 'OnboardingPage';
  static String routePath = '/onboardingPage';

  @override
  State<OnboardingPageWidget> createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<OnboardingPageWidget> {
  late OnboardingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().userid != '') {
        // Sessions from before token login have no token: the server answers 401 and the user logs in again.
        _model.autologinresponse = await GeneralGroup.meCall.call();

        if ((_model.autologinresponse?.succeeded ?? true) == true) {
          if (GeneralGroup.loginCall.statusCode(
                (_model.autologinresponse?.jsonBody ?? ''),
              ) ==
              200) {
            FFAppState().isLogin = true;
            FFAppState().walletcoin = GeneralGroup.loginCall.walletcoin(
              (_model.autologinresponse?.jsonBody ?? ''),
            )!;
            FFAppState().update(() {});
            return;
          } else {
            FFAppState().isLogin = false;
            FFAppState().authToken = '';
            FFAppState().update(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  GeneralGroup.loginCall.message(
                    (_model.autologinresponse?.jsonBody ?? ''),
                  )!,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: Colors.white,
                  ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).error,
              ),
            );
            return;
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Oops ! Technical Error. Try Again.',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: Colors.white,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }

        context.pushNamed(HomePageWidget.routeName);

        return;
      } else {
        return;
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _finishIntro() {
    FFAppState().isIntro = true;
    FFAppState().update(() {});
    context.goNamed(LoginPageWidget.routeName);
  }

  /// One onboarding slide: artwork on a glass card (a branded fallback when the image cannot load), then text.
  Widget _slide(BuildContext context, OnboardMStruct item) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);

    Widget fallback = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [palette.accent, Color.lerp(palette.accent, Colors.black, 0.45)!],
        ),
      ),
      child: Center(child: Icon(Icons.headphones_rounded, color: Colors.white, size: 96.0)),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 0.0),
      child: Column(
        children: [
          Expanded(
            child: Glass(
              radius: 32.0,
              strong: true,
              padding: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: SizedBox.expand(
                  child: item.img.isEmpty
                      ? fallback
                      : Image.network(
                          item.img,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => fallback,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(height: 28.0),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: theme.bodyMedium.override(
              fontFamily: 'SF Pro Display',
              color: palette.text,
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              lineHeight: 1.15,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            item.subTitle,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: theme.bodyMedium.override(
              fontFamily: 'SF Pro Display',
              color: palette.muted,
              fontSize: 16.0,
              letterSpacing: 0.0,
              lineHeight: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final introList = FFAppState().onboardList.toList();
    final isLast = FFAppState().introIndex > 1;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 12.0, 12.0, 0.0),
          child: Row(
            children: [
              AppLogo(size: 40.0, radius: 12.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Simulizi za Sauti',
                  style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.text,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              if (!isLast)
                TextButton(
                  onPressed: _finishIntro,
                  child: Text(
                    FFLocalizations.of(context).getText('5imusn2p' /* Ruka */),
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: palette.muted,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: PageView.builder(
            controller: _model.pageViewController ??= PageController(initialPage: 0),
            onPageChanged: (_) async {
              FFAppState().introIndex = _model.pageViewCurrentIndex;
              safeSetState(() {});
            },
            itemCount: introList.length,
            itemBuilder: (context, index) => _slide(context, introList[index]),
          ),
        ),
        SizedBox(height: 18.0),
        smooth_page_indicator.SmoothPageIndicator(
          controller: _model.pageViewController ??= PageController(initialPage: 0),
          count: introList.length,
          onDotClicked: (i) async {
            await _model.pageViewController!.animateToPage(
              i,
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            );
            safeSetState(() {});
          },
          effect: smooth_page_indicator.ExpandingDotsEffect(
            spacing: 6.0,
            radius: 8.0,
            dotWidth: 8.0,
            dotHeight: 8.0,
            expansionFactor: 3.5,
            dotColor: palette.outline,
            activeDotColor: palette.accent,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 22.0, 24.0, 24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56.0,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: palette.accent,
                foregroundColor: palette.onAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              ),
              onPressed: () async {
                if (!isLast) {
                  await _model.pageViewController?.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  _finishIntro();
                }
              },
              child: Text(
                isLast ? 'Anza' : 'Endelea',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SafeArea(child: _buildBody(context)),
      ),
    );
  }
}
