import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['sw', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  /// Text for [key] in the current language. A missing or blank translation falls back to Swahili, then
  /// English, so a screen never shows an empty label or button.
  String getText(String key) {
    final translations = kTranslationsMap[key] ?? {};
    final current = translations[locale.toString()];
    if (current != null && current.isNotEmpty) return current;
    for (final fallback in const ['sw', 'en']) {
      final text = translations[fallback];
      if (text != null && text.isNotEmpty) return text;
    }
    return '';
  }

  String getVariableText({
    String? swText = '',
    String? enText = '',
  }) =>
      [swText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    'lplgi0st': {
      'sw': 'Karibu ',
      'en': 'Karibu',
    },
    'lgb4aznq': {
      'sw': 'Tafuta',
      'en': 'Tafuta',
    },
    'tuwluj0n': {
      'sw': 'Makundi',
      'en': 'Makundi',
    },
    '61tzl2pc': {
      'sw': 'Tazama zaidi',
      'en': 'Tazama zaidi',
    },
    'awke62tg': {
      'sw': 'Zinazobamba',
      'en': 'Zinazobamba',
    },
    'kz1r6p5g': {
      'sw': 'Tazama zaidi',
      'en': 'Tazama zaidi',
    },
    'kwqsy6cx': {
      'sw': 'Waandishi',
      'en': 'Waandishi',
    },
    'x44p14fp': {
      'sw': 'Tazama zaidi',
      'en': 'Tazama zaidi',
    },
    '9zuihdkf': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // SplashPage
  {
    'dzjyko91': {
      'sw': 'Sikiliza Uelimike.',
      'en': 'Sikiliza Uelimike.',
    },
    'v8abcs7p': {
      'sw': 'Home',
      'en': 'Home',
    },
  },
  // OnboardingPage
  {
    '5imusn2p': {
      'sw': 'Ruka',
      'en': 'Ruka',
    },
    '10mo37vj': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // LoginPage
  {
    'gdn2b1x7': {
      'sw': 'Ingia',
      'en': 'Ingia',
    },
    'nn8dwuu4': {
      'sw': 'Barua pepe',
      'en': 'Barua pepe',
    },
    '4gly7jca': {
      'sw': 'Barua pepe',
      'en': 'Barua pepe',
    },
    'vtz9zqyc': {
      'sw': 'Nywila',
      'en': 'Nywila',
    },
    'rq4szjuu': {
      'sw': 'Nywila',
      'en': 'Nywila',
    },
    'jg8v9xve': {
      'sw': 'Umesahau Nywila ?',
      'en': 'Umesahau Nywila ?',
    },
    'x4nwc5r8': {
      'sw': 'Ingia',
      'en': 'Ingia',
    },
    '0exjuge8': {
      'sw': 'Au',
      'en': 'Au',
    },
    'a1mkaptj': {
      'sw': 'Tafadhali jaza barua pepe sahihi',
      'en': 'Tafadhali jaza barua pepe sahihi',
    },
    'h3holdcg': {
      'sw': 'Tafadhali jaza barua pepe sahihi',
      'en': 'Tafadhali jaza barua pepe sahihi',
    },
    'jutdc41w': {
      'sw': 'Tafadhali chaguo kutoka kwenye machaguo uliyopewa',
      'en': 'Tafadhali chaguo kutoka kwenye machaguo uliyopewa',
    },
    '381lm5sj': {
      'sw': 'Tafadhalinweka nywila sahihi',
      'en': 'Tafadhalinweka nywila sahihi',
    },
    'ydzl450v': {
      'sw': 'Tafadhali chaguo kutoka kwenye machaguo uliyopewa',
      'en': 'Tafadhali chaguo kutoka kwenye machaguo uliyopewa',
    },
    'ongo8hnn': {
      'sw': 'Hauna akaunti ?',
      'en': 'Hauna akaunti ?',
    },
    'ybm2n8lx': {
      'sw': 'Jisajili',
      'en': 'Jisajili',
    },
    '7y5md3jn': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // SignupPage
  {
    'ulmedo12': {
      'sw': 'Jisajili',
      'en': 'Jisajili',
    },
    '0t4ljk6m': {
      'sw': 'Jina kamili',
      'en': 'Jina kamili',
    },
    'qtk3q5ro': {
      'sw': 'Jina kamili',
      'en': 'Jina kamili',
    },
    'cwp6g6mz': {
      'sw': 'Nambari ya simu',
      'en': 'Nambari ya simu',
    },
    'o7brnlux': {
      'sw': 'Nambari ya simu',
      'en': 'Nambari ya simu',
    },
    's4ttj8pu': {
      'sw': 'Barua pepe',
      'en': 'Barua pepe',
    },
    '59uyb1a3': {
      'sw': 'Barua pepe',
      'en': 'Barua pepe',
    },
    'pooqs8qv': {
      'sw': 'Nywila',
      'en': 'Nywila',
    },
    'zkpe8jnx': {
      'sw': 'Nywila',
      'en': 'Nywila',
    },
    'x4pwu6ka': {
      'sw': 'Jisajili',
      'en': 'Jisajili',
    },
    '6yippc7s': {
      'sw': 'Au',
      'en': 'Au',
    },
    'fbdn8cn4': {
      'sw': 'Tafadhali ingiza jina sahihi',
      'en': 'Tafadhali ingiza jina sahihi',
    },
    'pl1az6r6': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa',
      'en': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa',
    },
    'xgp5nyy1': {
      'sw': 'Tafadhali ingiza',
      'en': 'Tafadhali ingiza jina sahihi',
    },
    'demerrz5': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa',
    },
    '9ex6rlrs': {
      'sw': 'Tafadhali ingiza barua pepe sahihi.',
      'en': 'Tafadhali ingiza barua pepe sahihi',
    },
    'osdnm01b': {
      'sw': 'Tafadhali ingiza barua pepe sahihi.',
      'en': 'Tafadhali ingiza barua pepe sahihi',
    },
    '37k9j22e': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa',
    },
    'ghr1qg5p': {
      'sw': 'Tafadhali ingiza nywila sahihi.',
      'en': 'Tafadhali ingiza nywila sahihi',
    },
    '0t64c0vx': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa',
    },
    'vk4bn3cf': {
      'sw': 'Tayari una akaunti ? ',
      'en': 'Tayari una akaunti ? ',
    },
    '19gzc2d1': {
      'sw': 'Ingia.',
      'en': 'Ingia.',
    },
    'nfo02asn': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // ForgotPassPage
  {
    'bcrgr35y': {
      'sw':
          'Andikwa barua pepe utakayotumiwa kiunganishi cha kurejesha nywila yako.',
      'en':
          'Andikwa barua pepe utakayotumiwa kiunganishi cha kurejesha nywila yako.',
    },
    'x1d7pvns': {
      'sw': 'Barua pepe',
      'en': 'Barua pepe',
    },
    'jds1z5tn': {
      'sw': 'Barua pepe',
      'en': 'Barua pepe',
    },
    'viv75x51': {
      'sw': 'Endelea',
      'en': 'Endelea',
    },
    'nqecveoe': {
      'sw': 'Tafadhali ingiza barua pepe sahihi',
      'en': 'Tafadhali ingiza barua pepe sahihi',
    },
    'ughwzogz': {
      'sw': 'Tafadhali chagua kutoka machaguo uliyopewa',
      'en': 'Tafadhali chagua kutoka machaguo uliyopewa',
    },
    'aa4jctnz': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // VerifyCodePage
  {
    '6zfweh9y': {
      'sw': 'Nambari ya uthibitisho imetumwa kwa barua pepe yako.',
      'en': '',
    },
    'smi16b8z': {
      'sw': 'Nambari ya uthibitisho imetumwa kwenye barua pepe yako.',
      'en': '',
    },
    'xnatvojx': {
      'sw': 'Tafadhali ingiza msimbo sahihi wa uthibitisho.',
      'en': '',
    },
    'g6fodzyt': {
      'sw': 'Don’t get the code? ',
      'en': '',
    },
    'bdathw2i': {
      'sw': 'Resend code',
      'en': '',
    },
    '0hus5k3h': {
      'sw': 'Continue',
      'en': '',
    },
    '16nfx8b0': {
      'sw': 'Home',
      'en': '',
    },
  },
  // ResetPassPage
  {
    'jl4yxipx': {
      'sw': 'Weka nywila yako mpya ili uingie.',
      'en': '',
    },
    'yjcptyr3': {
      'sw': 'New password',
      'en': '',
    },
    'x076kttg': {
      'sw': 'New password',
      'en': '',
    },
    '58dgt1dl': {
      'sw': 'Confirm password',
      'en': '',
    },
    'lcitwxqm': {
      'sw': 'Confirm password',
      'en': '',
    },
    '4nm3sliq': {
      'sw': 'Reset password',
      'en': '',
    },
    'spbo1zcl': {
      'sw': 'Tafadhali ingiza nywila mpya sahihi.',
      'en': '',
    },
    '77b3yijv': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': '',
    },
    'caxj8eoj': {
      'sw': 'Tafadhali ingiza nywila ya uthibitisho sahihi.',
      'en': '',
    },
    'foaj4cbi': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': '',
    },
    'd7laulri': {
      'sw': 'Home',
      'en': '',
    },
  },
  // ChooseArtistLikePage
  {
    'wsf2z5m5': {
      'sw': 'Skip',
      'en': '',
    },
    'z8ymq7ag': {
      'sw': 'Chagua waandishi unaowapenda.',
      'en': '',
    },
    'pgvdccls': {
      'sw': 'Uzoefu wako utazidi kuboreka unavyozidi kusikiliza.',
      'en': '',
    },
    'eoloksn6': {
      'sw': 'Done',
      'en': '',
    },
    'x42upbd1': {
      'sw': 'Home',
      'en': '',
    },
  },
  // NotificationPage
  {
    'cg9sd8ll': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // HomeSearchPage
  {
    '7eh0tobe': {
      'sw': '',
      'en': '',
    },
    'kvcx3p0j': {
      'sw': 'Tafuta',
      'en': 'Tafuta',
    },
    'jngadwrz': {
      'sw': 'Matokeo',
      'en': 'Matokeo',
    },
    'zwh5bqrg': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // SongDetailsPage
  {
    'zythedii': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // SimilarArtistPage
  {
    'sn9gwl1s': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // PlayListPage
  {
    '43xzl45h': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // AllCategoriesPage
  {
    '72zx7yh5': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // SubCatListPage
  {
    '61g9mfek': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // QuickPicksPage
  {
    '66gkgjec': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // ViewAlbumPage
  {
    'kjcn25l7': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // PlaylistofTheDayPage
  {
    'avp8ndwy': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // BestOfArtistPage
  {
    'wddyt9vn': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // ExplorePage
  {
    'eud5gaf0': {
      'sw': 'Unahitaji kusikiliza nini ?',
      'en': 'Unahitaji kusikiliza nini ?',
    },
    'p3ptflvq': {
      'sw': 'Makundi yote',
      'en': 'Makundi yote',
    },
    '1izax02y': {
      'sw': 'Tafuta',
      'en': 'Tafuta',
    },
  },
  // LibraryPage
  {
    'jgolgzzs': {
      'sw': 'Maktaba',
      'en': 'Maktaba',
    },
    'iaf3iuiz': {
      'sw': 'Jaza Kibubu',
      'en': 'Jaza Kibubu',
    },
    'dbv0tfqw': {
      'sw': 'Uzipendazo',
      'en': 'Uzipendazo',
    },
    'utdfpwic': {
      'sw': 'Ulizopakua',
      'en': 'Ulizopakua',
    },
    'ztt7zgno': {
      'sw': 'Maktaba',
      'en': 'Maktaba',
    },
  },
  // AddSongPage
  {
    'oixojyl4': {
      'sw': 'Tafuta',
      'en': 'Tafuta',
    },
    'i032i06g': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // SettingPage
  {
    'sonue45h': {
      'sw': 'Wasifu',
      'en': 'Wasifu',
    },
    'f3kfj34i': {
      'sw': 'Usalama',
      'en': 'Usalama',
    },
    '4l2dbb28': {
      'sw': 'Kuhusu sisi',
      'en': 'Kuhusu sisi',
    },
    '1jig2hkn': {
      'sw': 'Lugha',
      'en': 'Lugha',
    },
    'adni9znu': {
      'sw': 'Msaada',
      'en': 'Msaada',
    },
    'jpp0w391': {
      'sw': 'Mrejesho',
      'en': 'Mrejesho',
    },
    'x2z78gev': {
      'sw': 'Toka kwenye app',
      'en': 'Toka kwenye app',
    },
    '17f0vx1x': {
      'sw': 'Ingia',
      'en': 'Ingia',
    },
    'e46mrzzy': {
      'sw': 'Mpangilio',
      'en': 'Mpangilio',
    },
  },
  // MyProfilePage
  {
    'hpnw4a0q': {
      'sw': 'Jina',
      'en': 'Jina',
    },
    '78t09vij': {
      'sw': 'Simu',
      'en': 'Simu',
    },
    'ex80160f': {
      'sw': 'Wasifu',
      'en': 'Wasifu',
    },
    '3hn3y8nb': {
      'sw': 'Jaza',
      'en': 'Jaza',
    },
    '794hvx2w': {
      'sw': 'Kujiunga',
      'en': 'Kujiunga',
    },
    'gagd8vj9': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // EditProfilePage
  {
    'oyknbu1f': {
      'sw': 'First name',
      'en': '',
    },
    '5kkorlnu': {
      'sw': 'First name',
      'en': '',
    },
    '0vcg0ato': {
      'sw': 'Last name',
      'en': '',
    },
    '0ojuxiob': {
      'sw': 'Last name',
      'en': '',
    },
    'r6xo1k3j': {
      'sw': 'Email address',
      'en': '',
    },
    'r8h8mx18': {
      'sw': 'Email address',
      'en': '',
    },
    'u1dcr77e': {
      'sw': 'Tafadhali ingiza jina sahihi.',
      'en': '',
    },
    '99hnq2x6': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': '',
    },
    'scmyok19': {
      'sw': 'Tafadhali ingiza jina la familia sahihi.',
      'en': '',
    },
    'kw8w6ryv': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': '',
    },
    '4ne2jjm8': {
      'sw': 'Tafadhali ingiza barua pepe sahihi.',
      'en': '',
    },
    '7rxlkh15': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': '',
    },
    'wg04a8ua': {
      'sw': 'Save',
      'en': '',
    },
    'sk30q9me': {
      'sw': 'Home',
      'en': '',
    },
  },
  // SecurityPage
  {
    'l72igk1q': {
      'sw': 'Notifications',
      'en': '',
    },
    '77r7vwy9': {
      'sw': 'Change password',
      'en': '',
    },
    'pnzjaf2p': {
      'sw': 'Home',
      'en': '',
    },
  },
  // ChangePassPage
  {
    '3hktdhyo': {
      'sw': 'New password',
      'en': '',
    },
    '7gkibsd5': {
      'sw': 'New password',
      'en': '',
    },
    '8toq78qv': {
      'sw': 'Confirm password',
      'en': '',
    },
    's1tc1aqp': {
      'sw': 'Confirm password',
      'en': '',
    },
    't6iq9mry': {
      'sw': 'Save',
      'en': '',
    },
    'ycy43bue': {
      'sw': 'Tafadhali ingiza nywila mpya sahihi.',
      'en': '',
    },
    'mdtwkagy': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': '',
    },
    'gxydvmrr': {
      'sw': 'Tafadhali ingiza nywila ya uthibitisho sahihi.',
      'en': '',
    },
    'fmzsx83i': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa.',
      'en': '',
    },
    'lc1yxhac': {
      'sw': 'Home',
      'en': '',
    },
  },
  // AboutUsPage
  {
    'utscy6vt': {
      'sw':
          'Simulizi za Sauti ni jukwaa la kidijitali linalokuletea simulizi mbalimbali za Kiswahili kwa njia ya sauti. Lengo letu ni kufufua na kukuza utamaduni wa kusimulia hadithi za Kiswahili, huku tukirahisisha namna ya kuzifikia kupitia simu janja yako.\n\nKupitia app hii, unaweza:\n\nKusikiliza simulizi asilia za Kiswahili zilizojaa mafunzo, burudani na hekima.\n\nKupata hadithi kutoka kwa waandishi na wasimulizi tofauti.\n\nKufurahia uzoefu wa sauti unaokupa uhondo bila kusumbua macho yako.\n\nTunajivunia kukuza fasihi na utamaduni wa Kiswahili kwa kizazi cha sasa na kijacho kupitia teknolojia rahisi na ya kisasa. Simulizi za Sauti ni nyumbani pa hadithi zako.',
      'en':
          'Simulizi za Sauti ni jukwaa la kidijitali linalokuletea simulizi mbalimbali za Kiswahili kwa njia ya sauti. Lengo letu ni kufufua na kukuza utamaduni wa kusimulia hadithi za Kiswahili, huku tukirahisisha namna ya kuzifikia kupitia simu janja yako.\n\nKupitia app hii, unaweza:\n\nKusikiliza simulizi asilia za Kiswahili zilizojaa mafunzo, burudani na hekima.\n\nKupata hadithi kutoka kwa waandishi na wasimulizi tofauti.\n\nKufurahia uzoefu wa sauti unaokupa uhondo bila kusumbua macho yako.\n\nTunajivunia kukuza fasihi na utamaduni wa Kiswahili kwa kizazi cha sasa na kijacho kupitia teknolojia rahisi na ya kisasa. Simulizi za Sauti ni nyumbani pa hadithi zako.',
    },
    'dgow7v1w': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // HelpPage
  {
    '6jdqpyfo': {
      'sw': 'Simulizi za Sauti ni nini?',
      'en': 'Simulizi za Sauti ni nini?',
    },
    'ogmm0zrr': {
      'sw':
          'Simulizi za Sauti ni app ya simu inayokuwezesha kusikiliza simulizi mbalimbali za Kiswahili kwa njia ya sauti, popote ulipo na wakati wowote.',
      'en':
          'Simulizi za Sauti ni app ya simu inayokuwezesha kusikiliza simulizi mbalimbali za Kiswahili kwa njia ya sauti, popote ulipo na wakati wowote.',
    },
    'e35ntc31': {
      'sw': 'Je, nahitaji intaneti kusikiliza simulizi?',
      'en': 'Je, nahitaji intaneti kusikiliza simulizi?',
    },
    '21oynxin': {
      'sw':
          'Ndiyo, kusikiliza simulizi mtandaoni unahitaji intaneti. Lakini baadhi ya simulizi unaweza kupakua na kuyasikiliza bila intaneti.',
      'en':
          'Ndiyo, kusikiliza simulizi mtandaoni unahitaji intaneti. Lakini baadhi ya simulizi unaweza kupakua na kuyasikiliza bila intaneti.',
    },
    'om7jkz3e': {
      'sw': 'Ninawezaje kupata simulizi mpya?',
      'en': 'Ninawezaje kupata simulizi mpya?',
    },
    '8xdcr9ag': {
      'sw':
          'Simulizi mpya huongezwa mara kwa mara. Hakikisha unafungua app na kuboresha orodha ya simulizi ili kuona yaliyoongezwa.',
      'en':
          'Simulizi mpya huongezwa mara kwa mara. Hakikisha unafungua app na kuboresha orodha ya simulizi ili kuona yaliyoongezwa.',
    },
    '98xsz2gm': {
      'sw': 'kuna gharama za kutumia app hii?',
      'en': 'kuna gharama za kutumia app hii?',
    },
    '5os77yxn': {
      'sw':
          'Kusikiliza baadhi ya simulizi ni bure. Simulizi maalum au za kifurushi zinaweza kuhitaji malipo madogo kupitia njia za kawaida za kulipa mtandaoni.',
      'en':
          'Kusikiliza baadhi ya simulizi ni bure. Simulizi maalum au za kifurushi zinaweza kuhitaji malipo madogo kupitia njia za kawaida za kulipa mtandaoni.',
    },
    'g0445k83': {
      'sw': 'Nawezaje kushiriki simulizi ninazozipenda na rafiki zangu?',
      'en': 'Nawezaje kushiriki simulizi ninazozipenda na rafiki zangu?',
    },
    'dxz2dcs9': {
      'sw':
          'Ndani ya app, tumia kitufe cha kushiriki (share) ili kutuma kiungo cha simulizi kupitia WhatsApp, SMS, au mitandao ya kijamii.',
      'en':
          'Ndani ya app, tumia kitufe cha kushiriki (share) ili kutuma kiungo cha simulizi kupitia WhatsApp, SMS, au mitandao ya kijamii.',
    },
    'zijcwc8u': {
      'sw': 'Ninawezaje kuripoti tatizo?',
      'en': 'Ninawezaje kuripoti tatizo?',
    },
    'if6tqvbk': {
      'sw':
          'Unaweza kutumia sehemu ya “Mawasiliano” au “Feedback” ndani ya app, au kututumia barua pepe moja kwa moja',
      'en':
          'Unaweza kutumia sehemu ya “Mawasiliano” au “Feedback” ndani ya app, au kututumia barua pepe moja kwa moja',
    },
    'wegcolwg': {
      'sw': 'Naweza kupendekeza ziongezwe?',
      'en': 'Naweza kupendekeza ziongezwe?',
    },
    'id4jjfok': {
      'sw':
          'Ndiyo! Karibu utoe mapendekezo yako kupitia sehemu ya mawasiliano. Timu yetu itapitia na kuzingatia maombi yako.',
      'en':
          'Ndiyo! Karibu utoe mapendekezo yako kupitia sehemu ya mawasiliano. Timu yetu itapitia na kuzingatia maombi yako.',
    },
    'st00lguy': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // FeedbackPage
  {
    '101g5b8s': {
      'sw': '',
      'en': '',
    },
    'klplvg9m': {
      'sw': 'Andika maoni au mrejesho wako...',
      'en': 'Andika mrejesho wako...',
    },
    '7bp3bdra': {
      'sw': 'Tafadhali ingiza mrejesho sahihi',
      'en': 'Tafadhali ingiza mrejesho sahihi',
    },
    '5vojvdyx': {
      'sw': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa',
      'en': 'Tafadhali chagua kutoka kwenye machaguo uliyopewa',
    },
    '74eng8tt': {
      'sw': 'Wasilisha',
      'en': 'Wasilisha',
    },
    'bcd9gou4': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // FeaturedArtistsPage
  {
    'zzis3034': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // DemoPage
  {
    'nndo7bag': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // StoryDetailsPage
  {
    '1o21hc5k': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // StoryDetailsPageCopy
  {
    'wptbggyu': {
      'sw': 'Mwanzo',
      'en': 'Mwanzo',
    },
  },
  // PaymentConfirmation
  {
    'sisdm8s6': {
      'sw': 'Home',
      'en': '',
    },
  },
  // password_succsess_alrt
  {
    '9cdr0td1': {
      'sw': 'Password changed!',
      'en': '',
    },
    'm714g4la': {
      'sw':
          'Your password has been changed successfully use your new password to login',
      'en': '',
    },
    'bh30kghu': {
      'sw': 'Ok',
      'en': '',
    },
  },
  // WhenEverBottom
  {
    'uqbilfzc': {
      'sw': 'Chaguo za Haraka',
      'en': 'Chaguo za Haraka',
    },
    'odgxauyg': {
      'sw': 'Pakua',
      'en': 'Pakua',
    },
    '7fzs7t21': {
      'sw': 'Ongeza Orodha Pendwa',
      'en': 'Ongeza Orodha Pendwa',
    },
    '85udr75o': {
      'sw': 'Geuza Mpangilio',
      'en': 'Geuza Mpangilio',
    },
    '2no99jg7': {
      'sw': 'Nyingine kama hizi',
      'en': 'Nyingine kama hizi',
    },
    'qtyye74m': {
      'sw': 'Shirikisha',
      'en': 'Shirikisha',
    },
  },
  // AccountCreatedDialog
  {
    'xcjoq77j': {
      'sw': 'Akaunti imetengenezwa kikamilifu',
      'en': 'Akaunti imetengenezwa kikamilifu',
    },
    'ifwfe1wl': {
      'sw': 'Sasa unaweza kuburudika huku ukielimika upendavyo.',
      'en': 'Sasa unaweza kuburudika huku ukielimika upendavyo.',
    },
    'zrgrvxw3': {
      'sw': 'Twende sasa',
      'en': 'Twende sasa',
    },
  },
  // NoResultFoundComp
  {
    'q5aoajhk': {
      'sw': 'Hakuna Matokeo',
      'en': 'Hakuna Matokeo',
    },
    'xdgj78m1': {
      'sw': 'Jaribu kutumia herufi 3 za awali za simulizi',
      'en': 'Jaribu kutumia herufi 3 za awali za simulizi',
    },
  },
  // NoNotificationYetComp
  {
    'gpe5dtpu': {
      'sw': 'Hakuna Taarifa',
      'en': 'Hakuna Taarifa',
    },
    'y0bgn9o5': {
      'sw': 'Hakuna taarifa yeyote kwa sasa',
      'en': 'Hakuna taarifa yeyote kwa sasa',
    },
  },
  // sort_by_btm
  {
    'aew02nx5': {
      'sw': 'Sort by',
      'en': '',
    },
    'cmafpird': {
      'sw': 'Recent',
      'en': '',
    },
    '7xeca45h': {
      'sw': 'Recently added',
      'en': '',
    },
    'v9ziahjw': {
      'sw': 'Alphabetical',
      'en': '',
    },
    'wjjbutxk': {
      'sw': 'Creator',
      'en': '',
    },
  },
  // NoSongPlaylistComp
  {
    'ror2owk3': {
      'sw': 'Hakuna ulizochagua',
      'en': 'Hakuna ulizochagua',
    },
    'ekonhu1v': {
      'sw': 'Tafuta  na ongeza simulizi pendwa',
      'en': 'Tafuta  na ongeza simulizi pendwa',
    },
  },
  // LogoutAlrtDialog
  {
    'rxu0qsy2': {
      'sw': 'Toka ?',
      'en': 'Toka ?',
    },
    'dcr851fh': {
      'sw': 'Ni kweli unataka kutoka ?',
      'en': 'Ni kweli unataka kutoka ?',
    },
    'xuntpavf': {
      'sw': 'Hapana',
      'en': 'Hapana',
    },
    'j6diwfc7': {
      'sw': 'Ndio',
      'en': 'Ndio',
    },
  },
  // FeedbackSubmitAlrt
  {
    'mi20nny6': {
      'sw': 'Mrejesho umewasilishwa',
      'en': 'Mrejesho wako umewasilishwa kikamilifu',
    },
    'dqnmfycd': {
      'sw': 'Maoni yamepokelewa kikamilifu. Tutakurejea.',
      'en': 'Mrejesho wako umewasilishwa kikamilifu',
    },
    '9j6i9mj3': {
      'sw': 'Sawa',
      'en': 'Sawa',
    },
  },
  // LanguageSelectALrtDialog
  {
    '6t5vctjg': {
      'sw': 'Lugha',
      'en': 'Lugha',
    },
    'fvirzxyl': {
      'sw': 'Kiswahili',
      'en': 'Kiswahili',
    },
    '6s0s4jvz': {
      'sw': 'English',
      'en': 'English',
    },
  },
  // PasswordSuccessAlrtDialog
  {
    'enh71z8b': {
      'sw': 'Nywila Imebadilika !',
      'en': 'Nywila Imebadilika !',
    },
    'r0h1adas': {
      'sw': 'Nywila yako imebadilika kikamilifu, itumie kuingia kwenye app.',
      'en': 'Nywila yako imebadilika kikamilifu, itumie kuingia kwenye app.',
    },
    '5pfvtb4m': {
      'sw': 'Sawa',
      'en': 'Sawa',
    },
  },
  // socialAuthComponent
  {
    'omyauk4s': {
      'sw': 'Google',
      'en': 'Google',
    },
  },
  // PackageItem
  {
    'ac0zqdlz': {
      'sw': 'Bofya kufanya malipo',
      'en': 'Bofya kufanya malipo',
    },
  },
  // PackageListsComponent
  {
    'vo9pw1aw': {
      'sw': 'Vifurushi',
      'en': 'Vifurishi',
    },
    'rv2yhosj': {
      'sw': 'Vifurushi vilivyopo',
      'en': 'Chagua kifurushi kisha ulipie',
    },
  },
  // PackagePaymentSuccess
  {
    'dcwrzltf': {
      'sw': 'LIPA # (SELCOM)',
      'en': 'LIPA # (SELCOM)',
    },
    'eznefvfn': {
      'sw': 'Lipa kwa Benki au Mtandao wowote.',
      'en': 'Lipa kwa Benki au Mtandao wowote.',
    },
    'fx01qmw3': {
      'sw': 'Lipa Sasa',
      'en': 'Lipa Sasa',
    },
    'retxuu9v': {
      'sw': 'Ahirisha',
      'en': 'Funga',
    },
  },
  // CustomLoadingComponent
  {
    'p0rgp7cf': {
      'sw': 'Inapakia ...',
      'en': 'Inapakia ...',
    },
  },
  // BalanceComponent
  {
    'dxcpkfka': {
      'sw': 'Salio ',
      'en': 'Salio',
    },
  },
  // Miscellaneous
  {
    'lv2bq6px': {
      'sw': 'Large title ',
      'en': '',
    },
    'gvthp07h': {
      'sw': 'Title 1',
      'en': '',
    },
    '7cubbq2d': {
      'sw': 'Title 2',
      'en': '',
    },
    'ocli6pyv': {
      'sw': 'Title 3',
      'en': '',
    },
    'ix2pfwu7': {
      'sw': 'Headline',
      'en': '',
    },
    '2ozdagp7': {
      'sw': 'Subheadline',
      'en': '',
    },
    'i096pzld': {
      'sw': 'Body',
      'en': '',
    },
    'ltyd22sk': {
      'sw': 'Callout',
      'en': '',
    },
    '7cnbmrsr': {
      'sw': 'button large',
      'en': '',
    },
    '0gs259n8': {
      'sw': 'button small',
      'en': '',
    },
    '32o64kdd': {
      'sw': 'Footnote',
      'en': '',
    },
    '5mujlh5u': {
      'sw': 'Button',
      'en': '',
    },
    '45icto23': {
      'sw': 'Button',
      'en': '',
    },
    'l07i9ufe': {
      'sw': 'Button',
      'en': '',
    },
    'u98jzy62': {
      'sw': 'Button',
      'en': '',
    },
    '65nfg89i': {
      'sw': 'Email address',
      'en': '',
    },
    'p8mq9ul2': {
      'sw': 'Email address',
      'en': '',
    },
    'st1ig1gu': {
      'sw': 'Search here',
      'en': '',
    },
    'qwziy16v': {
      'sw': 'Search here',
      'en': '',
    },
    'rzykjx16': {
      'sw': 'First name here',
      'en': '',
    },
    '6mhmt9fe': {
      'sw': 'First name here',
      'en': '',
    },
    'p7go08ma': {
      'sw': '',
      'en': '',
    },
    'o7mmqnfj': {
      'sw': '',
      'en': '',
    },
    'x3ub8moy': {
      'sw': 'Tungependa kukutumia arifa za taarifa na masasisho.',
      'en': '',
    },
    '7cttp7t1': {
      'sw': '',
      'en': '',
    },
    'rz76rkze': {
      'sw': '',
      'en': '',
    },
    'yg7um6t7': {
      'sw': '',
      'en': '',
    },
    'q1xxzm8p': {
      'sw': '',
      'en': '',
    },
    'u3garogz': {
      'sw': '',
      'en': '',
    },
    '86e883d2': {
      'sw': '',
      'en': '',
    },
    'ni3715lv': {
      'sw': '',
      'en': '',
    },
    'bxyve1g5': {
      'sw': '',
      'en': '',
    },
    '4dqfr77n': {
      'sw': '',
      'en': '',
    },
    'd4xu56h3': {
      'sw': '',
      'en': '',
    },
    'yek5vkq9': {
      'sw': '',
      'en': '',
    },
    'ivsiaxf7': {
      'sw': '',
      'en': '',
    },
    '0lf6d3hd': {
      'sw': '',
      'en': '',
    },
    'e7tb8hxp': {
      'sw': '',
      'en': '',
    },
    'qggcfyps': {
      'sw': '',
      'en': '',
    },
    'o0314qql': {
      'sw': '',
      'en': '',
    },
    'kazb2ai6': {
      'sw': '',
      'en': '',
    },
    'l7nb55yw': {
      'sw': '',
      'en': '',
    },
    '8g0307t1': {
      'sw': '',
      'en': '',
    },
    '5ts5jtbk': {
      'sw': '',
      'en': '',
    },
    '3onoeqrq': {
      'sw': '',
      'en': '',
    },
    'q9073edi': {
      'sw': '',
      'en': '',
    },
    'jyzwn3h8': {
      'sw': '',
      'en': '',
    },
    'lvjhxg3k': {
      'sw': '',
      'en': '',
    },
    'i9jijiz2': {
      'sw': '',
      'en': '',
    },
    'cscfh5nc': {
      'sw': '',
      'en': '',
    },
    'uy69i0kj': {
      'sw': '',
      'en': '',
    },
    'ti8ezssb': {
      'sw': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
