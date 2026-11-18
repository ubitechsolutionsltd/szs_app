import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
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
        _model.autologinresponse = await GeneralGroup.loginCall.call(
          type: '4',
          email: FFAppState().email,
          password: FFAppState().password,
          deviceType: '1',
          deviceToken: FFAppState().password,
          fullName: FFAppState().fullname,
          mobileNumber: FFAppState().phonenumber,
          image: currentUserPhoto,
        );

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  GeneralGroup.loginCall.message(
                    (_model.autologinresponse?.jsonBody ?? ''),
                  )!,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: FlutterFlowTheme.of(context).alternate,
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
                  color: FlutterFlowTheme.of(context).tertiary,
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 46.0, 0.0, 0.0),
          child: Stack(
            alignment: AlignmentDirectional(-1.0, -1.0),
            children: [
              Builder(
                builder: (context) {
                  final introList = FFAppState().onboardList.toList();

                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _model.pageViewController ??=
                              PageController(
                                  initialPage:
                                      max(0, min(0, introList.length - 1))),
                          onPageChanged: (_) async {
                            FFAppState().introIndex =
                                _model.pageViewCurrentIndex;
                            safeSetState(() {});
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: introList.length,
                          itemBuilder: (context, introListIndex) {
                            final introListItem = introList[introListIndex];
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 1.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          introListItem.backImg,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/plhl26bvf3ae/backon1.png',
                                        ),
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.45,
                                        fit: BoxFit.contain,
                                        alignment: Alignment(-1.0, 1.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 1.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          introListItem.img,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/pfr5ddds14yx/on1.png',
                                        ),
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.65,
                                        fit: BoxFit.contain,
                                        alignment: Alignment(-1.0, 1.0),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          AutoSizeText(
                                            valueOrDefault<String>(
                                              introListItem.title,
                                              'Karibu Simulizi za Sauti',
                                            ),
                                            maxLines: 1,
                                            minFontSize: 24.0,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'SF Pro Display',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontSize: 28.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  lineHeight: 1.5,
                                                ),
                                          ),
                                        ]
                                            .addToStart(SizedBox(width: 20.0))
                                            .addToEnd(SizedBox(width: 20.0)),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            introListItem.subTitle,
                                            'Pata simulizi za Kiswahili zenye kusisimua na kuelimisha kwa njia ya sauti moja kwa moja kwenye simu yako.',
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SF Pro Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(height: 8.0))
                                        .addToStart(SizedBox(height: 46.0)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 170.0, 0.0, 0.0),
                            child: smooth_page_indicator.SmoothPageIndicator(
                              controller: _model.pageViewController ??=
                                  PageController(
                                      initialPage:
                                          max(0, min(0, introList.length - 1))),
                              count: introList.length,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) async {
                                await _model.pageViewController!.animateToPage(
                                  i,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                                safeSetState(() {});
                              },
                              effect: smooth_page_indicator.SlideEffect(
                                spacing: 6.0,
                                radius: 16.0,
                                dotWidth: 32.0,
                                dotHeight: 7.0,
                                dotColor: Color(0xFFD6F8FF),
                                activeDotColor:
                                    FlutterFlowTheme.of(context).primary,
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (FFAppState().introIndex <= 1)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().isIntro = true;
                        FFAppState().update(() {});

                        context.goNamed(LoginPageWidget.routeName);
                      },
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '5imusn2p' /* Ruka */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SF Pro Display',
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.5,
                            ),
                      ),
                    ),
                  ]
                      .addToStart(SizedBox(width: 20.0))
                      .addToEnd(SizedBox(width: 20.0)),
                ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 200.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        if (FFAppState().introIndex <= 1) {
                          await _model.pageViewController?.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          FFAppState().isIntro = true;
                          FFAppState().update(() {});

                          context.goNamed(LoginPageWidget.routeName);
                        }
                      },
                      text: valueOrDefault<String>(
                        FFAppState().introIndex <= 1 ? 'Endelea' : 'Anza',
                        'Next',
                      ),
                      options: FFButtonOptions(
                        width: 164.0,
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'SF Pro Display',
                                  color: FlutterFlowTheme.of(context).secondary,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ]
                      .addToStart(SizedBox(width: 20.0))
                      .addToEnd(SizedBox(width: 20.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
