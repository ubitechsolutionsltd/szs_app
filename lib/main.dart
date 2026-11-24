import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/firebase/firebase_config.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_theme.dart';
import '/custom_code/ui/glass.dart';
import '/custom_code/ui/theme_mode_store.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
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

  await ThemeModeStore.init();

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
  // Swahili is the app's default; the language the user picked in Settings wins once stored.
  Locale? _locale = FFLocalizations.getStoredLocale() ?? const Locale('sw');

  ThemeMode _themeMode = ThemeModeStore.current;

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

    ThemeModeStore.notifier.addListener(() {
      if (mounted && ThemeModeStore.notifier.value != _themeMode) {
        safeSetState(() => _themeMode = ThemeModeStore.notifier.value);
      }
    });
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

  void setThemeMode(ThemeMode mode) {
    ThemeModeStore.save(mode);
    safeSetState(() {
      _themeMode = mode;
    });
  }

  ThemeMode get themeMode => _themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: trs('stories_label'),
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
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      builder: (context, child) => AuroraBackground(child: child ?? const SizedBox.shrink()),
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Persistent "now playing" bar (hidden when nothing is loaded).
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
            child: custom_widgets.MiniPlayerBar(),
          ),
          AppBottomNav(
            currentIndex: currentIndex < 0 ? 0 : currentIndex,
            onSelected: (i) => safeSetState(() {
              _currentPage = null;
              _currentPageName = tabs.keys.toList()[i];
            }),
            items: [
              AppNavItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: FFLocalizations.of(context).getText('9zuihdkf' /* Mwanzo */),
              ),
              AppNavItem(
                icon: Icons.search_rounded,
                selectedIcon: Icons.search_rounded,
                label: FFLocalizations.of(context).getText('1izax02y' /* Tafuta */),
              ),
              AppNavItem(
                icon: Icons.library_music_outlined,
                selectedIcon: Icons.library_music_rounded,
                label: FFLocalizations.of(context).getText('ztt7zgno' /* Maktaba */),
              ),
              AppNavItem(
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings_rounded,
                label: FFLocalizations.of(context).getText('e46mrzzy' /* Mpangilio */),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
