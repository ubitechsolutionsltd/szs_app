import '/index.dart';
import '/backend/api_requests/api_calls.dart';
import '/custom_code/ui/app_palette.dart';
import '/components/custom_center_app_bar_widget.dart';
import '/components/package_lists_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
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

  Future<void> _refreshWallet() async {
    final response = await GeneralGroup.meCall.call();
    final coin = GeneralGroup.loginCall.walletcoin(response.jsonBody);
    if (coin != null) {
      FFAppState().walletcoin = coin;
      FFAppState().update(() {});
    }
  }

  Future<void> _openTopUp() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return WebViewAware(
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.75,
              child: PackageListsComponentWidget(),
            ),
          ),
        );
      },
    ).then((value) => safeSetState(() {}));
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
      avatar = ClipOval(
        child: CachedNetworkImage(
          imageUrl: state.userphoto,
          width: 96.0,
          height: 96.0,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => avatar,
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
            label: Text('Hariri wasifu', style: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700)),
            onPressed: () => context.pushNamed(EditProfilePageWidget.routeName),
          ),
        ),
        SizedBox(height: 24.0),
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpace.radiusLg),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [palette.accent, Color.lerp(palette.accent, Colors.black, 0.55)!],
            ),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(Icons.toll_rounded, color: palette.onAccent.withValues(alpha: 0.8), size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text('Salio lako',
                    style: theme.bodyMedium.override(
                        fontFamily: 'SF Pro Display',
                        color: palette.onAccent.withValues(alpha: 0.85),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0)),
              ),
              IconButton(
                tooltip: 'Onyesha upya',
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.refresh_rounded, color: palette.onAccent),
                onPressed: _refreshWallet,
              ),
            ]),
            SizedBox(height: 4.0),
            Text('${state.walletcoin}',
                style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display',
                    color: Colors.white,
                    fontSize: 44.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.0)),
            Text('sarafu',
                style: theme.bodyMedium.override(
                    fontFamily: 'SF Pro Display', color: Colors.white70, fontSize: 14.0, letterSpacing: 0.0)),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                ),
                icon: Icon(Icons.add_circle_outline_rounded),
                label: Text('Jaza kibubu', style: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w800)),
                onPressed: _openTopUp,
              ),
            ),
          ]),
        ),
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
            _infoRow(context, Icons.person_outline_rounded, 'Jina kamili', state.fullname),
            _infoRow(context, Icons.mail_outline_rounded, 'Barua pepe', state.email),
            _infoRow(context, Icons.phone_outlined, 'Simu', state.phonenumber),
            _infoRow(context, Icons.info_outline_rounded, 'Kuhusu mimi', state.bio),
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.customCenterAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustomCenterAppBarWidget(
                  title: 'Wasifu',
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
