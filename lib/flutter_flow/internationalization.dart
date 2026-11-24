import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale) {
    _currentCode = locale.languageCode;
  }

  final Locale locale;

  static String _currentCode = 'sw';

  /// Language code of the most recently loaded locale (used by [trs], which needs no BuildContext).
  static String get currentCode => _currentCode;

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
  String getText(String key, {Map<String, String>? args}) =>
      _lookup(key, locale.languageCode, args);

  static String _lookup(String key, String code, Map<String, String>? args) {
    final translations = kTranslationsMap[key] ?? const {};
    var text = translations[code];
    if (text == null || text.isEmpty) {
      for (final fallback in const ['sw', 'en']) {
        final t = translations[fallback];
        if (t != null && t.isNotEmpty) {
          text = t;
          break;
        }
      }
    }
    text ??= '';
    args?.forEach((name, value) => text = text!.replaceAll('{$name}', value));
    return text!;
  }

  /// Translate [key] without a BuildContext, using the language that was loaded last.
  static String translate(String key, {Map<String, String>? args}) =>
      _lookup(key, _currentCode, args);

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

/// All user-facing text, Swahili (sw) and English (en). Edit translations here, in one place.
/// Keys with 8 random characters come from the original FlutterFlow export; readable keys are newer.
final kTranslationsMap = <String, Map<String, String>>{
  '0exjuge8': {'sw': 'Au', 'en': 'or'},
  '0hus5k3h': {'sw': 'Endelea', 'en': 'Continue'},
  '0ojuxiob': {'sw': 'Jina la ukoo', 'en': 'Last name'},
  '0vcg0ato': {'sw': 'Jina la ukoo', 'en': 'Last name'},
  '17f0vx1x': {'sw': 'Ingia', 'en': 'Log in'},
  '19gzc2d1': {'sw': 'Ingia.', 'en': 'Log in.'},
  '1izax02y': {'sw': 'Tafuta', 'en': 'Search'},
  '1jig2hkn': {'sw': 'Lugha', 'en': 'Language'},
  '21oynxin': {'sw': 'Ndiyo, kusikiliza mtandaoni kunahitaji intaneti. Hata hivyo, unaweza kupakua simulizi na kuzisikiliza bila intaneti.', 'en': 'Yes, streaming needs an internet connection. However, you can download stories and listen to them offline.'},
  '2no99jg7': {'sw': 'Nyingine kama hizi', 'en': 'More like this'},
  '381lm5sj': {'sw': 'Tafadhali weka nywila sahihi.', 'en': 'Please enter a valid password.'},
  '3hktdhyo': {'sw': 'Nywila mpya', 'en': 'New password'},
  '4gly7jca': {'sw': 'Barua pepe', 'en': 'Email'},
  '4l2dbb28': {'sw': 'Kuhusu sisi', 'en': 'About us'},
  '4nm3sliq': {'sw': 'Weka nywila mpya', 'en': 'Reset password'},
  '59uyb1a3': {'sw': 'Barua pepe', 'en': 'Email'},
  '5imusn2p': {'sw': 'Ruka', 'en': 'Skip'},
  '5kkorlnu': {'sw': 'Jina la kwanza', 'en': 'First name'},
  '5os77yxn': {'sw': 'Baadhi ya simulizi ni bure, na nyingine zinahitaji sarafu. Unaweza kujaza kibubu chako kwa kununua kifurushi.', 'en': 'Some stories are free and others need coins. You can top up your wallet by buying a package.'},
  '5pfvtb4m': {'sw': 'Sawa', 'en': 'OK'},
  '61tzl2pc': {'sw': 'Tazama zaidi', 'en': 'See more'},
  '6jdqpyfo': {'sw': 'Simulizi za Sauti ni nini?', 'en': 'What is Simulizi za Sauti?'},
  '6s0s4jvz': {'sw': 'English', 'en': 'English'},
  '6t5vctjg': {'sw': 'Lugha', 'en': 'Language'},
  '6yippc7s': {'sw': 'Au', 'en': 'or'},
  '6zfweh9y': {'sw': 'Nambari ya uthibitisho imetumwa kwenye barua pepe yako.', 'en': 'The verification code was sent to your email.'},
  '74eng8tt': {'sw': 'Wasilisha', 'en': 'Submit'},
  '77r7vwy9': {'sw': 'Badilisha nywila', 'en': 'Change password'},
  '7bp3bdra': {'sw': 'Tafadhali ingiza mrejesho sahihi.', 'en': 'Please enter valid feedback.'},
  '7fzs7t21': {'sw': 'Ongeza kwenye Pendwa', 'en': 'Add to favourites'},
  '7gkibsd5': {'sw': 'Nywila mpya', 'en': 'New password'},
  '7xeca45h': {'sw': 'Zilizoongezwa karibuni', 'en': 'Recently added'},
  '85udr75o': {'sw': 'Geuza mpangilio', 'en': 'Reverse order'},
  '8toq78qv': {'sw': 'Thibitisha nywila', 'en': 'Confirm password'},
  '8xdcr9ag': {'sw': 'Simulizi mpya huongezwa mara kwa mara. Fuatilia sehemu ya “Zinazobamba” kwenye Mwanzo ili kuzipata kwanza.', 'en': 'New stories are added regularly. Check “Trending” on Home to find them first.'},
  '98xsz2gm': {'sw': 'Je, kuna gharama za kutumia app hii?', 'en': 'Does the app cost anything to use?'},
  '9cdr0td1': {'sw': 'Nywila imebadilishwa!', 'en': 'Password changed!'},
  '9ex6rlrs': {'sw': 'Tafadhali ingiza barua pepe sahihi.', 'en': 'Please enter a valid email.'},
  '9j6i9mj3': {'sw': 'Sawa', 'en': 'OK'},
  '9zuihdkf': {'sw': 'Mwanzo', 'en': 'Home'},
  'a1mkaptj': {'sw': 'Tafadhali ingiza barua pepe sahihi.', 'en': 'Please enter a valid email.'},
  'adni9znu': {'sw': 'Msaada', 'en': 'Help'},
  'aew02nx5': {'sw': 'Panga kwa', 'en': 'Sort by'},
  'awke62tg': {'sw': 'Zinazobamba', 'en': 'Trending'},
  'bcrgr35y': {'sw': 'Andika barua pepe utakayotumiwa kiungo cha kurejesha nywila yako.', 'en': 'Enter the email we should send your password reset link to.'},
  'bdathw2i': {'sw': 'Tuma nambari tena', 'en': 'Resend code'},
  'bh30kghu': {'sw': 'Sawa', 'en': 'OK'},
  'caxj8eoj': {'sw': 'Tafadhali thibitisha nywila yako.', 'en': 'Please confirm your password.'},
  'cmafpird': {'sw': 'Za hivi karibuni', 'en': 'Most recent'},
  'dcr851fh': {'sw': 'Je, una uhakika unataka kutoka?', 'en': 'Are you sure you want to log out?'},
  'dcwrzltf': {'sw': 'LIPA # (SELCOM)', 'en': 'PAY # (SELCOM)'},
  'dqnmfycd': {'sw': 'Mrejesho wako umepokelewa. Tutakurejea.', 'en': 'Your feedback has been received. We will get back to you.'},
  'dxcpkfka': {'sw': 'Salio', 'en': 'Balance'},
  'dxz2dcs9': {'sw': 'Tumia kitufe cha “Shirikisha” kwenye ukurasa wa simulizi kutuma kiungo kwa marafiki zako.', 'en': 'Use the “Share” button on a story page to send a link to your friends.'},
  'e35ntc31': {'sw': 'Je, nahitaji intaneti kusikiliza simulizi?', 'en': 'Do I need internet to listen to stories?'},
  'e46mrzzy': {'sw': 'Mipangilio', 'en': 'Settings'},
  'ekonhu1v': {'sw': 'Tafuta na ongeza simulizi pendwa', 'en': 'Search and add your favourite stories'},
  'enh71z8b': {'sw': 'Nywila imebadilishwa!', 'en': 'Password changed!'},
  'eoloksn6': {'sw': 'Maliza', 'en': 'Done'},
  'eznefvfn': {'sw': 'Lipa kwa benki au mtandao wowote wa simu.', 'en': 'Pay with any bank or mobile network.'},
  'f3kfj34i': {'sw': 'Usalama', 'en': 'Security'},
  'fbdn8cn4': {'sw': 'Tafadhali ingiza jina sahihi.', 'en': 'Please enter a valid name.'},
  'fvirzxyl': {'sw': 'Kiswahili', 'en': 'Kiswahili'},
  'fx01qmw3': {'sw': 'Lipa sasa', 'en': 'Pay now'},
  'g0445k83': {'sw': 'Nawezaje kushiriki simulizi ninazozipenda na marafiki zangu?', 'en': 'How do I share stories I like with my friends?'},
  'g6fodzyt': {'sw': 'Hujapata nambari? ', 'en': 'Didn’t get the code? '},
  'gdn2b1x7': {'sw': 'Ingia', 'en': 'Log in'},
  'ghr1qg5p': {'sw': 'Tafadhali ingiza nywila sahihi.', 'en': 'Please enter a valid password.'},
  'gpe5dtpu': {'sw': 'Hakuna taarifa', 'en': 'No notifications'},
  'gxydvmrr': {'sw': 'Tafadhali thibitisha nywila yako.', 'en': 'Please confirm your password.'},
  'h3holdcg': {'sw': 'Tafadhali ingiza barua pepe sahihi.', 'en': 'Please enter a valid email.'},
  'id4jjfok': {'sw': 'Ndiyo! Tutumie mapendekezo yako kupitia “Mrejesho” na tutayazingatia.', 'en': 'Yes! Send us your suggestions through “Feedback” and we will consider them.'},
  'if6tqvbk': {'sw': 'Tumia sehemu ya “Mrejesho” kwenye Mipangilio kuripoti tatizo lolote.', 'en': 'Use “Feedback” in Settings to report any problem.'},
  'ifwfe1wl': {'sw': 'Sasa unaweza kuburudika huku ukielimika upendavyo.', 'en': 'Now you can enjoy being entertained and informed as you please.'},
  'j6diwfc7': {'sw': 'Ndiyo', 'en': 'Yes'},
  'jds1z5tn': {'sw': 'Barua pepe', 'en': 'Email'},
  'jg8v9xve': {'sw': 'Umesahau nywila?', 'en': 'Forgot password?'},
  'jpp0w391': {'sw': 'Mrejesho', 'en': 'Feedback'},
  'klplvg9m': {'sw': 'Andika maoni au mrejesho wako...', 'en': 'Write your feedback...'},
  'kwqsy6cx': {'sw': 'Waandishi', 'en': 'Authors'},
  'kz1r6p5g': {'sw': 'Tazama zaidi', 'en': 'See more'},
  'l72igk1q': {'sw': 'Arifa', 'en': 'Notifications'},
  'lcitwxqm': {'sw': 'Thibitisha nywila', 'en': 'Confirm password'},
  'm714g4la': {'sw': 'Nywila yako imebadilishwa. Itumie kuingia kwenye app.', 'en': 'Your password has been changed. Use it to log in to the app.'},
  'mi20nny6': {'sw': 'Mrejesho umewasilishwa', 'en': 'Feedback submitted'},
  'nn8dwuu4': {'sw': 'Barua pepe', 'en': 'Email'},
  'nqecveoe': {'sw': 'Tafadhali ingiza barua pepe sahihi.', 'en': 'Please enter a valid email.'},
  'o7brnlux': {'sw': 'Nambari ya simu', 'en': 'Phone number'},
  'odgxauyg': {'sw': 'Pakua', 'en': 'Download'},
  'ogmm0zrr': {'sw': 'Simulizi za Sauti ni app ya simulizi za Kiswahili za kusikiliza. Utapata hadithi za mapenzi, uchawi, upelelezi na nyingine nyingi kutoka kwa waandishi mbalimbali.', 'en': 'Simulizi za Sauti is an app for listening to Swahili stories. You will find romance, magic, detective and many other stories from different authors.'},
  'oixojyl4': {'sw': 'Tafuta', 'en': 'Search'},
  'om7jkz3e': {'sw': 'Ninawezaje kupata simulizi mpya?', 'en': 'How do I find new stories?'},
  'omyauk4s': {'sw': 'Google', 'en': 'Google'},
  'ongo8hnn': {'sw': 'Huna akaunti?', 'en': 'Don’t have an account?'},
  'osdnm01b': {'sw': 'Tafadhali ingiza barua pepe sahihi.', 'en': 'Please enter a valid email.'},
  'oyknbu1f': {'sw': 'Jina la kwanza', 'en': 'First name'},
  'p0rgp7cf': {'sw': 'Inapakia...', 'en': 'Loading...'},
  'pgvdccls': {'sw': 'Uzoefu wako utaboreka kadri unavyosikiliza zaidi.', 'en': 'Your experience gets better the more you listen.'},
  'q5aoajhk': {'sw': 'Hakuna matokeo', 'en': 'No results'},
  'qtk3q5ro': {'sw': 'Jina kamili', 'en': 'Full name'},
  'qtyye74m': {'sw': 'Shirikisha', 'en': 'Share'},
  'r0h1adas': {'sw': 'Nywila yako imebadilishwa. Itumie kuingia kwenye app.', 'en': 'Your password has been changed. Use it to log in to the app.'},
  'r6xo1k3j': {'sw': 'Barua pepe', 'en': 'Email'},
  'r8h8mx18': {'sw': 'Barua pepe', 'en': 'Email'},
  'retxuu9v': {'sw': 'Ahirisha', 'en': 'Later'},
  'ror2owk3': {'sw': 'Hakuna ulizohifadhi', 'en': 'Nothing saved yet'},
  'rq4szjuu': {'sw': 'Nywila', 'en': 'Password'},
  'rxu0qsy2': {'sw': 'Toka?', 'en': 'Log out?'},
  's1tc1aqp': {'sw': 'Thibitisha nywila', 'en': 'Confirm password'},
  'scmyok19': {'sw': 'Tafadhali ingiza jina la ukoo sahihi.', 'en': 'Please enter a valid last name.'},
  'spbo1zcl': {'sw': 'Tafadhali ingiza nywila mpya sahihi.', 'en': 'Please enter a valid new password.'},
  't6iq9mry': {'sw': 'Hifadhi', 'en': 'Save'},
  'tuwluj0n': {'sw': 'Makundi', 'en': 'Categories'},
  'u1dcr77e': {'sw': 'Tafadhali ingiza jina sahihi.', 'en': 'Please enter a valid name.'},
  'ulmedo12': {'sw': 'Jisajili', 'en': 'Sign up'},
  'uqbilfzc': {'sw': 'Chaguo za haraka', 'en': 'Quick options'},
  'utscy6vt': {'sw': 'Simulizi za Sauti ni jukwaa la kidijitali linalokuletea simulizi mbalimbali za Kiswahili kwa njia ya sauti.', 'en': 'Simulizi za Sauti is a digital platform that brings you a variety of Swahili stories in audio.'},
  'v9ziahjw': {'sw': 'Kwa alfabeti', 'en': 'Alphabetical'},
  'viv75x51': {'sw': 'Endelea', 'en': 'Continue'},
  'vk4bn3cf': {'sw': 'Tayari una akaunti? ', 'en': 'Already have an account? '},
  'vtz9zqyc': {'sw': 'Nywila', 'en': 'Password'},
  'wegcolwg': {'sw': 'Naweza kupendekeza simulizi ziongezwe?', 'en': 'Can I suggest stories to be added?'},
  'wg04a8ua': {'sw': 'Hifadhi', 'en': 'Save'},
  'wjjbutxk': {'sw': 'Mwandishi', 'en': 'Author'},
  'wsf2z5m5': {'sw': 'Ruka', 'en': 'Skip'},
  'x076kttg': {'sw': 'Nywila mpya', 'en': 'New password'},
  'x1d7pvns': {'sw': 'Barua pepe', 'en': 'Email'},
  'x2z78gev': {'sw': 'Toka kwenye app', 'en': 'Log out'},
  'x44p14fp': {'sw': 'Tazama zaidi', 'en': 'See more'},
  'x4nwc5r8': {'sw': 'Ingia', 'en': 'Log in'},
  'x4pwu6ka': {'sw': 'Jisajili', 'en': 'Sign up'},
  'xcjoq77j': {'sw': 'Akaunti imetengenezwa kikamilifu', 'en': 'Account created successfully'},
  'xdgj78m1': {'sw': 'Jaribu kutumia herufi 3 za mwanzo za simulizi', 'en': 'Try the first 3 letters of a story title'},
  'xgp5nyy1': {'sw': 'Tafadhali ingiza jina sahihi.', 'en': 'Please enter a valid name.'},
  'xnatvojx': {'sw': 'Tafadhali ingiza msimbo sahihi wa uthibitisho.', 'en': 'Please enter a valid verification code.'},
  'xuntpavf': {'sw': 'Hapana', 'en': 'No'},
  'y0bgn9o5': {'sw': 'Hakuna taarifa yoyote kwa sasa', 'en': 'You have no notifications right now'},
  'ybm2n8lx': {'sw': 'Jisajili', 'en': 'Sign up'},
  'ycy43bue': {'sw': 'Tafadhali ingiza nywila mpya sahihi.', 'en': 'Please enter a valid new password.'},
  'z8ymq7ag': {'sw': 'Chagua waandishi unaowapenda.', 'en': 'Choose the authors you like.'},
  'zijcwc8u': {'sw': 'Ninawezaje kuripoti tatizo?', 'en': 'How do I report a problem?'},
  'zkpe8jnx': {'sw': 'Nywila', 'en': 'Password'},
  'zrgrvxw3': {'sw': 'Twende sasa', 'en': 'Let’s go'},
  'ztt7zgno': {'sw': 'Maktaba', 'en': 'Library'},
  'about_app_name': {'sw': 'Simulizi za Sauti', 'en': 'Simulizi za Sauti'},
  'about_author': {'sw': 'Kuhusu mwandishi', 'en': 'About the author'},
  'about_me': {'sw': 'Kuhusu mimi', 'en': 'About me'},
  'about_point_1': {'sw': 'Kusikiliza simulizi asilia za Kiswahili.', 'en': 'Listen to original Swahili stories.'},
  'about_point_2': {'sw': 'Kupata hadithi kutoka kwa waandishi na wasimulizi tofauti.', 'en': 'Discover stories from different authors and narrators.'},
  'about_point_3': {'sw': 'Kufurahia uzoefu wa sauti unaokupa uhondo bila kusumbua macho yako.', 'en': 'Enjoy an audio experience that entertains without straining your eyes.'},
  'about_tagline': {'sw': 'Maisha ni Hadithi', 'en': 'Life is a Story'},
  'about_us_title': {'sw': 'Kuhusu sisi', 'en': 'About us'},
  'add_to_playlist': {'sw': 'Ongeza kwenye orodha', 'en': 'Add to playlist'},
  'added_fav': {'sw': 'Imeongezwa kwenye Pendwa.', 'en': 'Added to favourites.'},
  'added_to_playlist': {'sw': 'Imeongezwa kwenye orodha', 'en': 'Added to playlist'},
  'author_load_fail': {'sw': 'Imeshindikana kupakia ukurasa wa mwandishi.', 'en': 'Could not load the author page.'},
  'back': {'sw': 'Rudi nyuma', 'en': 'Back'},
  'back15': {'sw': 'Rudi sekunde 15', 'en': 'Back 15 seconds'},
  'balance_label': {'sw': 'Salio lako', 'en': 'Your balance'},
  'buy_failed': {'sw': 'Imeshindwa kununua. Jaribu tena baadaye.', 'en': 'Could not complete the purchase. Please try again later.'},
  'cancel': {'sw': 'Ghairi', 'en': 'Cancel'},
  'choose_package': {'sw': 'Chagua kifurushi cha sarafu', 'en': 'Choose a coin package'},
  'close': {'sw': 'Funga', 'en': 'Close'},
  'close_player': {'sw': 'Funga', 'en': 'Close'},
  'coins_n': {'sw': '{n} sarafu', 'en': '{n} coins'},
  'connect_failed': {'sw': 'Imeshindikana kuunganisha. Angalia mtandao wako na ujaribu tena.', 'en': 'Could not connect. Check your internet and try again.'},
  'create': {'sw': 'Unda', 'en': 'Create'},
  'current_language': {'sw': 'Kiswahili', 'en': 'English'},
  'delete': {'sw': 'Futa', 'en': 'Delete'},
  'delete_all': {'sw': 'Futa zote', 'en': 'Delete all'},
  'delete_all_msg': {'sw': 'Simulizi zote ulizopakua zitafutwa kwenye simu hii.', 'en': 'All downloaded stories will be removed from this phone.'},
  'delete_all_q': {'sw': 'Futa zote?', 'en': 'Delete all?'},
  'dl_failed_tap': {'sw': 'Imeshindikana. Gusa kujaribu tena.', 'en': 'Failed. Tap to try again.'},
  'dl_hint': {'sw': 'Gusa “Pakua” kwenye simulizi ili kusikiliza bila mtandao.', 'en': 'Tap “Download” on a story to listen offline.'},
  'dl_started': {'sw': 'Kupakua kumeanza.', 'en': 'Download started.'},
  'dl_started_n': {'sw': 'Kupakua kwa vipindi {n} kumeanza.', 'en': 'Downloading {n} episodes has started.'},
  'dl_unavail': {'sw': 'Kupakua hakupatikani', 'en': 'Downloads unavailable'},
  'dl_web': {'sw': 'Kupakua hakupatikani kwenye kivinjari. Tumia programu ya simu.', 'en': 'Downloads aren’t available in the browser. Use the mobile app.'},
  'dl_web2': {'sw': 'Kupakua simulizi hakupatikani kwenye wavuti. Tumia app ya simu.', 'en': 'Downloading stories isn’t available on the web. Use the mobile app.'},
  'download_short': {'sw': 'Chini', 'en': 'Download'},
  'downloaded': {'sw': 'Imepakuliwa', 'en': 'Downloaded'},
  'downloading': {'sw': 'Inapakua', 'en': 'Downloading'},
  'downloads_tab': {'sw': 'Ulizopakua', 'en': 'Downloads'},
  'edit_profile': {'sw': 'Hariri wasifu', 'en': 'Edit profile'},
  'end_of_episode': {'sw': 'Mwisho wa kipindi', 'en': 'End of episode'},
  'episodes': {'sw': 'Vipindi', 'en': 'Episodes'},
  'err_failed': {'sw': 'Imeshindikana kucheza. Jaribu tena.', 'en': 'Could not play. Please try again.'},
  'err_locked': {'sw': 'Simulizi hii imefungwa. Ifungue kwanza ili kuisikiliza.', 'en': 'This story is locked. Unlock it first to listen.'},
  'err_next_locked': {'sw': 'Sehemu zinazofuata zimefungwa. Zifungue ili kuendelea.', 'en': 'The next parts are locked. Unlock them to continue.'},
  'err_offline': {'sw': 'Hakuna mtandao. Pakua simulizi ili kusikiliza bila mtandao.', 'en': 'No connection. Download stories to listen offline.'},
  'error_load': {'sw': 'Imeshindikana kupakia. Angalia mtandao wako.', 'en': 'Could not load. Check your connection.'},
  'error_title': {'sw': 'Kuna tatizo', 'en': 'Something went wrong'},
  'failed_retry': {'sw': 'Imeshindikana. Jaribu tena.', 'en': 'Something went wrong. Please try again.'},
  'favourites_tab': {'sw': 'Uzipendazo', 'en': 'Favourites'},
  'feedback_title': {'sw': 'Maoni', 'en': 'Feedback'},
  'follow': {'sw': 'Fuatilia', 'en': 'Follow'},
  'following': {'sw': 'Unafuatilia', 'en': 'Following'},
  'forward15': {'sw': 'Ruka sekunde 15', 'en': 'Forward 15 seconds'},
  'greet_afternoon': {'sw': 'Habari za mchana', 'en': 'Good afternoon'},
  'greet_evening': {'sw': 'Habari za jioni', 'en': 'Good evening'},
  'greet_morning': {'sw': 'Habari za asubuhi', 'en': 'Good morning'},
  'guest': {'sw': 'Mgeni', 'en': 'Guest'},
  'guest_account': {'sw': 'Mgeni', 'en': 'Guest'},
  'guest_login_hint': {'sw': 'Ingia ili kufikia akaunti yako', 'en': 'Log in to access your account'},
  'hero_empty': {'sw': 'Simulizi mpya zitaonekana hapa hivi karibuni.', 'en': 'New stories will appear here soon.'},
  'hero_load_fail': {'sw': 'Imeshindikana kupakia simulizi. Angalia mtandao wako.', 'en': 'Could not load stories. Check your connection.'},
  'hide': {'sw': 'Ficha', 'en': 'Hide'},
  'his_stories': {'sw': 'Simulizi zake', 'en': 'Their stories'},
  'listen_now': {'sw': 'Sikiliza Sasa', 'en': 'Listen now'},
  'locked': {'sw': 'Imefungwa', 'en': 'Locked'},
  'login_failed': {'sw': 'Imeshindikana kuingia.', 'en': 'Login failed.'},
  'login_first': {'sw': 'Tafadhali ingia kwanza ili kuendelea.', 'en': 'Please log in first to continue.'},
  'login_ok': {'sw': 'Umeingia kikamilifu.', 'en': 'Logged in successfully.'},
  'login_sub': {'sw': 'Karibu tena. Ingia ili uendelee kusikiliza simulizi zako.', 'en': 'Welcome back. Log in to keep listening to your stories.'},
  'login_to_buy': {'sw': 'Tafadhali ingia kwanza ili kununua kipindi hiki.', 'en': 'Please log in first to buy this episode.'},
  'login_to_follow': {'sw': 'Tafadhali ingia kwanza ili kumfuatilia mwandishi.', 'en': 'Please log in first to follow this author.'},
  'login_to_save': {'sw': 'Tafadhali ingia kwanza ili kuhifadhi kwenye Pendwa.', 'en': 'Please log in first to save to favourites.'},
  'login_to_see': {'sw': 'Ingia ili kuona maktaba yako', 'en': 'Log in to see your library'},
  'minutes_n': {'sw': 'Dakika {n}', 'en': '{n} minutes'},
  'my_profile': {'sw': 'Wasifu wangu', 'en': 'My profile'},
  'new_password_title': {'sw': 'Nywila Mpya', 'en': 'New password'},
  'new_playlist': {'sw': 'Orodha mpya', 'en': 'New playlist'},
  'next': {'sw': 'Inayofuata', 'en': 'Next'},
  'no_categories': {'sw': 'Makundi bado hayapatikani.', 'en': 'Categories are not available yet.'},
  'no_category': {'sw': 'Bila kundi', 'en': 'No category'},
  'no_downloads': {'sw': 'Hujapakua simulizi bado', 'en': 'No downloads yet'},
  'no_episodes': {'sw': 'Hakuna vipindi bado', 'en': 'No episodes yet'},
  'no_episodes_sub': {'sw': 'Vipindi vya simulizi hii vitaonekana hapa.', 'en': 'Episodes of this story will appear here.'},
  'no_name': {'sw': 'Bila jina', 'en': 'Untitled'},
  'no_results_for': {'sw': 'Hatukupata simulizi inayolingana na “{q}”.', 'en': 'We couldn’t find a story matching “{q}”.'},
  'no_saved_title': {'sw': 'Hakuna ulizohifadhi', 'en': 'Nothing saved yet'},
  'no_stories_now': {'sw': 'Hakuna simulizi za kuonyesha kwa sasa.', 'en': 'No stories to show right now.'},
  'no_stories_yet': {'sw': 'Hakuna simulizi bado.', 'en': 'No stories yet.'},
  'nothing_playing': {'sw': 'Bado hakuna kinachocheza', 'en': 'Nothing is playing yet'},
  'nothing_to_download': {'sw': 'Hakuna cha kupakua kwa sasa.', 'en': 'Nothing to download right now.'},
  'notifications': {'sw': 'Taarifa', 'en': 'Notifications'},
  'now_playing': {'sw': 'Unasikiliza', 'en': 'Now playing'},
  'onboard_0_sub': {'sw': 'Kuwa wa kwanza kupata simulizi za Kiswahili zenye kusisimua na kuelimisha kwa njia ya sauti moja kwa moja kwenye simu yako.', 'en': 'Be the first to enjoy exciting and educational Swahili stories in audio, right on your phone.'},
  'onboard_0_title': {'sw': 'Simulizi Kiganjani kwako', 'en': 'Stories in the palm of your hand'},
  'onboard_1_sub': {'sw': 'Sikiliza simulizi za mapenzi, uchawi, siasa na uchumi popote ulipo ili ujifunze na kuhabarika.', 'en': 'Listen to stories about love, magic, politics and the economy wherever you are, and learn as you go.'},
  'onboard_1_title': {'sw': 'Simulizi za kila aina', 'en': 'Stories of every kind'},
  'onboard_2_sub': {'sw': 'Furahia simulizi hata bila intaneti ukiwa safarini au nyumbani. Intaneti si changamoto tena.', 'en': 'Enjoy stories even without internet, on the road or at home. No connection, no problem.'},
  'onboard_2_title': {'sw': 'Sikiliza Offline', 'en': 'Listen offline'},
  'open_player': {'sw': 'Fungua kicheza kikuu', 'en': 'Open full player'},
  'package_word': {'sw': 'Kifurushi', 'en': 'Package'},
  'pause': {'sw': 'Simamisha', 'en': 'Pause'},
  'payment_info_fail': {'sw': 'Imeshindwa kupata taarifa za malipo', 'en': 'Could not get payment details'},
  'payment_link_fail': {'sw': 'Imeshindwa kupata kiungo cha malipo', 'en': 'Could not get the payment link'},
  'payment_secure': {'sw': 'Malipo ni salama kupitia Selcom', 'en': 'Payments are secure through Selcom'},
  'per_coin': {'sw': 'TZS {price} kwa sarafu', 'en': 'TZS {price} per coin'},
  'phone_label': {'sw': 'Simu', 'en': 'Phone'},
  'play': {'sw': 'Cheza', 'en': 'Play'},
  'play_error_short': {'sw': 'Imeshindikana kucheza.', 'en': 'Could not play.'},
  'playlist': {'sw': 'Orodha', 'en': 'Playlist'},
  'playlist_name': {'sw': 'Jina la orodha', 'en': 'Playlist name'},
  'popular': {'sw': 'Zinazopendwa', 'en': 'Popular'},
  'popular_cats': {'sw': 'Makundi maarufu', 'en': 'Popular categories'},
  'previous': {'sw': 'Iliyopita', 'en': 'Previous'},
  'profile': {'sw': 'Wasifu', 'en': 'Profile'},
  'queue': {'sw': 'Foleni', 'en': 'Queue'},
  'queue_empty': {'sw': 'Foleni ni tupu', 'en': 'The queue is empty'},
  'refresh': {'sw': 'Onyesha upya', 'en': 'Refresh'},
  'remove': {'sw': 'Ondoa', 'en': 'Remove'},
  'removed_fav': {'sw': 'Imeondolewa kwenye Pendwa.', 'en': 'Removed from favourites.'},
  'repeat': {'sw': 'Rudia', 'en': 'Repeat'},
  'reset_sub': {'sw': 'Weka nywila mpya ili uendelee kusikiliza simulizi zako.', 'en': 'Set a new password to keep listening to your stories.'},
  'reset_title': {'sw': 'Rejesha Nywila', 'en': 'Reset password'},
  'results': {'sw': 'Matokeo', 'en': 'Results'},
  'retry': {'sw': 'Jaribu tena', 'en': 'Try again'},
  'save_story': {'sw': 'Hifadhi', 'en': 'Save'},
  'saved': {'sw': 'Imehifadhiwa', 'en': 'Saved'},
  'saved_empty_hint': {'sw': 'Tafuta na hifadhi simulizi pendwa ili uzipate hapa kwa haraka.', 'en': 'Search and save your favourite stories to find them here quickly.'},
  'saved_hint': {'sw': 'Hifadhi simulizi unazozipenda na zitaonekana hapa.', 'en': 'Save stories you love and they will appear here.'},
  'saved_tab': {'sw': 'Ulizohifadhi', 'en': 'Saved'},
  'search_a11y': {'sw': 'Tafuta simulizi au mwandishi', 'en': 'Search stories or authors'},
  'search_hint_home': {'sw': 'Tafuta simulizi, mwandishi…', 'en': 'Search stories, authors…'},
  'search_prompt': {'sw': 'Unatafuta simulizi gani?', 'en': 'What story are you looking for?'},
  'search_stories': {'sw': 'Tafuta simulizi', 'en': 'Search stories'},
  'sem_balance': {'sw': 'Salio lako: {n}. Jaza kibubu', 'en': 'Your balance: {n}. Top up wallet'},
  'sem_now_playing': {'sw': 'Kinachocheza sasa: {title}', 'en': 'Now playing: {title}'},
  'share_generic': {'sw': 'Sikiliza simulizi na hadithi za kusisimua kwa Kiswahili kwenye Simulizi za Sauti: ', 'en': 'Listen to exciting Swahili stories on Simulizi za Sauti: '},
  'share_story': {'sw': '{title} na {artist}\nSikiliza kwenye Simulizi za Sauti: ', 'en': '{title} by {artist}\nListen on Simulizi za Sauti: '},
  'show': {'sw': 'Onyesha', 'en': 'Show'},
  'shuffle': {'sw': 'Changanya', 'en': 'Shuffle'},
  'signup_sub': {'sw': 'Fungua akaunti yako ili usikilize simulizi za Kiswahili.', 'en': 'Create your account to listen to Swahili stories.'},
  'sleep_timer': {'sw': 'Kipima muda', 'en': 'Sleep timer'},
  'speed': {'sw': 'Kasi', 'en': 'Speed'},
  'start': {'sw': 'Anza', 'en': 'Get started'},
  'stories_label': {'sw': 'Simulizi', 'en': 'Stories'},
  'tech_problem': {'sw': 'Tatizo la Kiufundi', 'en': 'Technical problem'},
  'tech_try_later': {'sw': 'Kuna tatizo la kiufundi. Jaribu tena baadaye.', 'en': 'A technical problem occurred. Please try again later.'},
  'theme': {'sw': 'Mandhari', 'en': 'Theme'},
  'theme_dark': {'sw': 'Giza', 'en': 'Dark'},
  'theme_light': {'sw': 'Mwanga', 'en': 'Light'},
  'theme_system': {'sw': 'Mfumo', 'en': 'System'},
  'timer_short': {'sw': 'Muda', 'en': 'Timer'},
  'top_up': {'sw': 'Jaza kibubu', 'en': 'Top up wallet'},
  'try_again_words': {'sw': 'Jaribu maneno mengine', 'en': 'Try other words'},
  'try_other': {'sw': 'Jaribu maneno mengine', 'en': 'Try other words'},
  'turn_off': {'sw': 'Zima', 'en': 'Turn off'},
  'unavailable_now': {'sw': 'Haipatikani kwa sasa.', 'en': 'Not available right now.'},
  'unlock_first': {'sw': 'Fungua kwanza ili upakue.', 'en': 'Unlock it first to download.'},
  'verify_title': {'sw': 'Thibitisha Msimbo', 'en': 'Verify code'},
  'wallet_coins': {'sw': 'sarafu', 'en': 'coins'},
  'welcome': {'sw': 'Karibu', 'en': 'Welcome'},
};

/// Context-free shortcut for [FFLocalizations.translate], e.g. trs('retry').
String trs(String key, {Map<String, String>? args}) =>
    FFLocalizations.translate(key, args: args);

extension TranslateContext on BuildContext {
  /// context.tr('retry'): translated text that updates when the language changes.
  String tr(String key, {Map<String, String>? args}) =>
      FFLocalizations.of(this).getText(key, args: args);
}
