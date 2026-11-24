import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_logo.dart';
import '/custom_code/ui/app_tokens.dart';
import '/custom_code/ui/wave_background.dart';
import 'about_us_page_model.dart';
export 'about_us_page_model.dart';

class AboutUsPageWidget extends StatefulWidget {
  const AboutUsPageWidget({super.key});

  static String routeName = 'AboutUsPage';
  static String routePath = '/aboutUsPage';

  @override
  State<AboutUsPageWidget> createState() => _AboutUsPageWidgetState();
}

class _AboutUsPageWidgetState extends State<AboutUsPageWidget> {
  late AboutUsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutUsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final text = dark ? AppTokens.darkText : AppTokens.brandNavy;
    final body = dark ? AppTokens.darkTextSecondary : AppTokens.textPrimary;
    final accent = dark ? AppTokens.darkAccent : AppTokens.brandPrimary;

    Widget point(String key) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(trs(key),
                    style: TextStyle(fontFamily: AppTokens.fontFamily, color: body, fontSize: 15.5, height: 1.45)),
              ),
            ),
          ]),
        );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        const Align(alignment: Alignment.bottomCenter, child: FooterWave(height: 130)),
        Column(children: [
          GradientHeader(title: trs('4l2dbb28'), onBack: () => context.safePop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding + 4, 28, AppTokens.screenPadding + 4, 150),
              children: [
                Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [BoxShadow(color: AppTokens.brandPrimary.withValues(alpha: 0.35), blurRadius: 28, offset: const Offset(0, 12))],
                    ),
                    child: const AppLogo(size: 104, radius: 28),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Simulizi za Sauti',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: AppTokens.fontFamily, color: text, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
                const SizedBox(height: 4),
                Text(trs('about_tagline'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: AppTokens.fontFamily, color: accent, fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)),
                const SizedBox(height: 24),
                Text(trs('utscy6vt'),
                    style: TextStyle(fontFamily: AppTokens.fontFamily, color: body, fontSize: 16.5, height: 1.5)),
                const SizedBox(height: 22),
                point('about_point_1'),
                point('about_point_2'),
                point('about_point_3'),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
