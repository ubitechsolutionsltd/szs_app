import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import '/custom_code/ui/app_palette.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_profile_page_model.dart';
export 'my_profile_page_model.dart';

class MyProfilePageWidget extends StatefulWidget {
  const MyProfilePageWidget({super.key});

  static String routeName = 'MyProfilePage';
  static String routePath = '/myProfilePage';

  @override
  State<MyProfilePageWidget> createState() => _MyProfilePageWidgetState();
}

class _MyProfilePageWidgetState extends State<MyProfilePageWidget> {
  late MyProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyProfilePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _infoRow(BuildContext context, IconData icon, String label, String value) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    if (value.trim().isEmpty) return SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(color: palette.surfaceHigh, shape: BoxShape.circle),
          child: Icon(icon, color: palette.accent, size: 20.0),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: theme.bodySmall.override(
                    fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 13.0, letterSpacing: 0.0)),
            SizedBox(height: 2.0),
            Text(value,
                style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display',
                    color: palette.text,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.0)),
          ]),
        ),
      ]),
    );
  }

  Widget _buildProfile(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = FlutterFlowTheme.of(context);
    final state = FFAppState();
    final name = state.fullname.trim();

    Widget avatar = Container(
      width: 96.0,
      height: 96.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: palette.accent, shape: BoxShape.circle),
      child: Text(name.isEmpty ? 'S' : name[0].toUpperCase(),
          style: TextStyle(fontFamily: 'SF Pro Display', color: palette.onAccent, fontSize: 40.0, fontWeight: FontWeight.w800)),
    );
    if (state.userphoto.isNotEmpty) {
      final fallbackAvatar = avatar;
      avatar = ClipOval(
        child: CachedNetworkImage(
          imageUrl: state.userphoto,
          width: 96.0,
          height: 96.0,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => fallbackAvatar,
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 32.0),
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: palette.accent, width: 2.5)),
            child: avatar,
          ),
        ),
        SizedBox(height: 14.0),
        Center(
          child: Text(name.isEmpty ? 'Mgeni' : name,
              textAlign: TextAlign.center,
              style: theme.bodyMedium.override(
                  fontFamily: 'SF Pro Display',
                  color: palette.text,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4)),
        ),
        if (state.username.isNotEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(state.username,
                  style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display', color: palette.muted, fontSize: 15.0, letterSpacing: 0.0)),
            ),
          ),
        SizedBox(height: 16.0),
        Center(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: palette.text,
              side: BorderSide(color: palette.outline),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            ),
            icon: Icon(Icons.edit_outlined, size: 18.0),
            label: Text(trs('edit_profile'), style: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700)),
            onPressed: () => context.pushNamed(EditProfilePageWidget.routeName),
          ),
        ),
        SizedBox(height: 24.0),
        custom_widgets.WalletCard(),
        if ([state.fullname, state.email, state.phonenumber, state.bio, state.joinedat]
            .any((v) => v.trim().isNotEmpty)) ...[
        SizedBox(height: 24.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(AppSpace.radiusMd),
            border: Border.all(color: palette.outline, width: 0.5),
          ),
          child: Column(children: [
            _infoRow(context, Icons.person_outline_rounded, trs('qtk3q5ro'), state.fullname),
            _infoRow(context, Icons.mail_outline_rounded, trs('4gly7jca'), state.email),
            _infoRow(context, Icons.phone_outlined, trs('phone_label'), state.phonenumber),
            _infoRow(context, Icons.info_outline_rounded, trs('about_me'), state.bio),
            _infoRow(context, Icons.calendar_today_outlined, 'Alijiunga', state.joinedat),
          ]),
        ),
        ],
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
        body: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: trs('profile'),
                  backIcon: false,
                  addIcon: false,
                  onTapAdd: () async {},
                ),
              ),
              Expanded(
                child: _buildProfile(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
