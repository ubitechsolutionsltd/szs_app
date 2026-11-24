import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_tokens.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'help_page_model.dart';
export 'help_page_model.dart';

class HelpPageWidget extends StatefulWidget {
  const HelpPageWidget({super.key});

  static String routeName = 'HelpPage';
  static String routePath = '/helpPage';

  @override
  State<HelpPageWidget> createState() => _HelpPageWidgetState();
}

class _HelpPageWidgetState extends State<HelpPageWidget> {
  late HelpPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// (question key, answer key) pairs in the translation table.
  static const _faq = [
    ('6jdqpyfo', 'ogmm0zrr'),
    ('e35ntc31', '21oynxin'),
    ('om7jkz3e', '8xdcr9ag'),
    ('98xsz2gm', '5os77yxn'),
    ('g0445k83', 'dxz2dcs9'),
    ('zijcwc8u', 'if6tqvbk'),
    ('wegcolwg', 'id4jjfok'),
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HelpPageModel());
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
      body: Column(children: [
        GradientHeader(title: trs('adni9znu'), onBack: () => context.safePop()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppTokens.screenPadding, 22, AppTokens.screenPadding, 28),
            children: [
              for (var i = 0; i < _faq.length; i++)
                FaqCard(question: trs(_faq[i].$1), answer: trs(_faq[i].$2), initiallyOpen: i == 0),
            ],
          ),
        ),
      ]),
    );
  }
}
