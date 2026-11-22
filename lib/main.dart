import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/firebase/firebase_config.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/ui/app_palette.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await FFLocalizations.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  await actions.initPlayer();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = FFLocalizations.getStoredLocale();

  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.path;
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = simuliziFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
    FFLocalizations.storeLocale(language);
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simulizi',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('sw'),
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'ExplorePage': ExplorePageWidget(),
      'LibraryPage': LibraryPageWidget(),
      'SettingPage': SettingPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    final palette = AppPalette.of(context);

    return Scaffold(
      backgroundColor: palette.background,
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: ColoredBox(
        color: palette.background,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Persistent "now playing" bar (hidden when nothing is loaded).
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
            child: custom_widgets.MiniPlayerBar(),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: palette.surface,
              border: Border(top: BorderSide(color: palette.outline, width: 0.5)),
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                height: 66.0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                indicatorColor: palette.accent.withValues(alpha: 0.18),
                labelTextStyle: WidgetStateProperty.resolveWith(
                  (states) => FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'SF Pro Display',
                        color: states.contains(WidgetState.selected)
                            ? palette.accent
                            : palette.muted,
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: states.contains(WidgetState.selected)
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                ),
                iconTheme: WidgetStateProperty.resolveWith(
                  (states) => IconThemeData(
                    size: 24.0,
                    color: states.contains(WidgetState.selected)
                        ? palette.accent
                        : palette.muted,
                  ),
                ),
              ),
              child: NavigationBar(
                selectedIndex: currentIndex < 0 ? 0 : currentIndex,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                onDestinationSelected: (i) => safeSetState(() {
                  _currentPage = null;
                  _currentPageName = tabs.keys.toList()[i];
                }),
                destinations: <NavigationDestination>[
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home_rounded),
                    label: FFLocalizations.of(context).getText(
                      '9zuihdkf' /* Mwanzo */,
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search_rounded),
                    selectedIcon: Icon(Icons.search_rounded),
                    label: FFLocalizations.of(context).getText(
                      '1izax02y' /* Tafuta */,
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.library_music_outlined),
                    selectedIcon: Icon(Icons.library_music_rounded),
                    label: FFLocalizations.of(context).getText(
                      'ztt7zgno' /* Maktaba */,
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings_rounded),
                    label: FFLocalizations.of(context).getText(
                      'e46mrzzy' /* Mpangilio */,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
