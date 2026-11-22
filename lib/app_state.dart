import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, VoidCallback;
import '/backend/schema/structs/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';
import '/backend/api_requests/api_manager.dart' show ApiManager;

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _isIntro = await secureStorage.getBool('ff_isIntro') ?? _isIntro;
    });
    await _safeInitAsync(() async {
      _introIndex = await secureStorage.getInt('ff_introIndex') ?? _introIndex;
    });
    await _safeInitAsync(() async {
      _isLogin = await secureStorage.getBool('ff_isLogin') ?? _isLogin;
    });
    await _safeInitAsync(() async {
      _isInfo = await secureStorage.getBool('ff_isInfo') ?? _isInfo;
    });
    await _safeInitAsync(() async {
      _catList = (await secureStorage.getStringList('ff_catList'))
              ?.map((x) {
                try {
                  return CmStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _catList;
    });
    await _safeInitAsync(() async {
      _searchedList =
          await secureStorage.getStringList('ff_searchedList') ?? _searchedList;
    });
    await _safeInitAsync(() async {
      _langIndex = await secureStorage.getInt('ff_langIndex') ?? _langIndex;
    });
    await _safeInitAsync(() async {
      _onboardList = (await secureStorage.getStringList('ff_onboardList'))
              ?.map((x) {
                try {
                  return OnboardMStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _onboardList;
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_userInfo') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_userInfo') ?? '{}';
          _userInfo =
              UserInfoStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _skipUser = await secureStorage.getBool('ff_skipUser') ?? _skipUser;
    });
    await _safeInitAsync(() async {
      _isShowBottomPlayer =
          await secureStorage.getBool('ff_isShowBottomPlayer') ??
              _isShowBottomPlayer;
    });
    await _safeInitAsync(() async {
      _username = await secureStorage.getString('ff_username') ?? _username;
    });
    await _safeInitAsync(() async {
      _password = await secureStorage.getString('ff_password') ?? _password;
    });
    await _safeInitAsync(() async {
      await _restoreAuthToken();
    });
    await _safeInitAsync(() async {
      _fullname = await secureStorage.getString('ff_fullname') ?? _fullname;
    });
    await _safeInitAsync(() async {
      _phonenumber =
          await secureStorage.getString('ff_phonenumber') ?? _phonenumber;
    });
    await _safeInitAsync(() async {
      _devicetoken =
          await secureStorage.getString('ff_devicetoken') ?? _devicetoken;
    });
    await _safeInitAsync(() async {
      _email = await secureStorage.getString('ff_email') ?? _email;
    });
    await _safeInitAsync(() async {
      _bio = await secureStorage.getString('ff_bio') ?? _bio;
    });
    await _safeInitAsync(() async {
      _userid = await secureStorage.getString('ff_userid') ?? _userid;
    });
    await _safeInitAsync(() async {
      _userphoto = await secureStorage.getString('ff_userphoto') ?? _userphoto;
    });
    await _safeInitAsync(() async {
      _joinedat = await secureStorage.getString('ff_joinedat') ?? _joinedat;
    });
    await _safeInitAsync(() async {
      _selectedTrackIndex =
          await secureStorage.getInt('ff_selectedTrackIndex') ??
              _selectedTrackIndex;
    });
    await _safeInitAsync(() async {
      _selectedTrackTitle =
          await secureStorage.getString('ff_selectedTrackTitle') ??
              _selectedTrackTitle;
    });
    await _safeInitAsync(() async {
      _selectedTrackUrl =
          await secureStorage.getString('ff_selectedTrackUrl') ??
              _selectedTrackUrl;
    });
    await _safeInitAsync(() async {
      _playerisplaying =
          await secureStorage.getBool('ff_playerisplaying') ?? _playerisplaying;
    });
    await _safeInitAsync(() async {
      _walletcoin = await secureStorage.getInt('ff_walletcoin') ?? _walletcoin;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  bool _isIntro = false;
  bool get isIntro => _isIntro;
  set isIntro(bool value) {
    _isIntro = value;
    secureStorage.setBool('ff_isIntro', value);
  }

  void deleteIsIntro({bool resetState = false}) {
    if (resetState) {
      _isIntro = false;
    }
    secureStorage.delete(key: 'ff_isIntro');
  }

  int _introIndex = 0;
  int get introIndex => _introIndex;
  set introIndex(int value) {
    _introIndex = value;
    secureStorage.setInt('ff_introIndex', value);
  }

  void deleteIntroIndex({bool resetState = false}) {
    if (resetState) {
      _introIndex = 0;
    }
    secureStorage.delete(key: 'ff_introIndex');
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool value) {
    _isLogin = value;
    secureStorage.setBool('ff_isLogin', value);
  }

  void deleteIsLogin({bool resetState = false}) {
    if (resetState) {
      _isLogin = false;
    }
    secureStorage.delete(key: 'ff_isLogin');
  }

  bool _isInfo = false;
  bool get isInfo => _isInfo;
  set isInfo(bool value) {
    _isInfo = value;
    secureStorage.setBool('ff_isInfo', value);
  }

  void deleteIsInfo({bool resetState = false}) {
    if (resetState) {
      _isInfo = false;
    }
    secureStorage.delete(key: 'ff_isInfo');
  }

  List<ArtistsMStruct> _chooseArList = [
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"0\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ucvqe2zikw23/a1.png\",\"name\":\"Byron Akins\",\"name_hindi\":\"बायरन अकिंस\",\"name_arbic\":\"بايرون أكينز\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"1\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/3hj0a7xfccuf/a2.png\",\"name\":\"Sameera ayat\",\"name_hindi\":\"समीरा आयत\",\"name_arbic\":\"سميرة ايات\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"2\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/fbqpzna8h7ao/a3.png\",\"name\":\"Zahra Arub\",\"name_hindi\":\"ज़हरा अरूब\",\"name_arbic\":\"زهراء عروب\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"3\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/vhfrtfczlmw8/a4.png\",\"name\":\"Amsah Nahas\",\"name_hindi\":\"अम्साह नहस\",\"name_arbic\":\"امسة نحاس\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"4\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/z4p12cb1d0wx/a5.png\",\"name\":\"Jameela Kouri\",\"name_hindi\":\"जमीला कोरी\",\"name_arbic\":\"جميلة كوري\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"5\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/qunbutd15cqz/a6.png\",\"name\":\"Mais Qadriyah\",\"name_hindi\":\"\\nमैस काद्रियाह\",\"name_arbic\":\"ميس قادرية\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"6\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/wlzur8wkz5f4/a7.png\",\"name\":\"Suhail Kassab\",\"name_hindi\":\"सुहैल कसाब\",\"name_arbic\":\"سهيل قصاب\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"7\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/5g2m9c3xm0od/a8.png\",\"name\":\"Yasser Wasil\",\"name_hindi\":\"यासिर वासिल\",\"name_arbic\":\"ياسر واصل\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"8\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/lw7iei0pf1oz/a9.png\",\"name\":\"Ghadah Najjar\",\"name_hindi\":\"ग़दाह नज्जर\",\"name_arbic\":\"غادة نجار\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"9\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/vl0y2bu0eenk/a10.png\",\"name\":\"Samad Salib\",\"name_hindi\":\"समद सालिब\",\"name_arbic\":\"صمد صليب\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"10\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/siuw2evw57wu/a11.png\",\"name\":\"Jilan Srour\",\"name_hindi\":\"जिलान सोउर\",\"name_arbic\":\"جيلان سرور\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"11\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/8jih43lyztds/a12.png\",\"name\":\"Din Sleiman\",\"name_hindi\":\"दीन स्लीमन\",\"name_arbic\":\"دين سليمان\",\"is_selected\":\"false\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"12\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/317lqw6cjg4e/a13.png\",\"name\":\"Rena Guglie\",\"name_hindi\":\"रेना गुगली\",\"name_arbic\":\"رينا جوجلي\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"13\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/g7r7i8jimdxa/a14.png\",\"name\":\"Azim Habib\",\"name_hindi\":\"अज़ीम हबीब\",\"name_arbic\":\"عظيم حبيب\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"14\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/cdeo52dog2us/a15.png\",\"name\":\"Maymunah\",\"name_hindi\":\"मयमुना\",\"name_arbic\":\"ميمونة\",\"is_selected\":\"false\",\"is_featured_a\":\"true\",\"is_best_artist\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"15\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/0mtx9scck61u/a16.png\",\"name\":\"Shukrah\",\"name_hindi\":\"शुक्र\",\"name_arbic\":\"شكرا\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"16\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/2krtdmcfys66/a17.png\",\"name\":\"Taroob Muhja\",\"name_hindi\":\"तरूब मुहजा\",\"name_arbic\":\"طروب مهجة\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"17\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/9k96yifm6cmp/a18.png\",\"name\":\"Aswad \",\"name_hindi\":\"असवाड\",\"name_arbic\":\"أسود\",\"is_selected\":\"false\",\"is_featured_a\":\"true\",\"is_best_artist\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"18\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/s48uq976n78x/a19.png\",\"name\":\"Alima Halima\",\"name_hindi\":\"अलीमा हलीमा\",\"name_arbic\":\"عليمة حليمة\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"19\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/b0djttsh9pde/a20.png\",\"name\":\"Hanifa Almasi\",\"name_hindi\":\"हनीफा अलमासी\",\"name_arbic\":\"حنيفة الماسي\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"20\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ej5bjnwyw952/a21.png\",\"name\":\"Azzam\",\"name_hindi\":\"आज़म\",\"name_arbic\":\"عزام\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"21\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/tzlonsp4dy99/a22.png\",\"name\":\"Aswad \",\"name_hindi\":\"असवाड\",\"name_arbic\":\"أسود\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"22\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/dln0fwfbqvo7/a23.png\",\"name\":\"Maloof\",\"name_hindi\":\"मालूफ़\",\"name_arbic\":\"معلوف\",\"is_selected\":\"false\",\"is_featured_a\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"23\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/7p2g0jnngkov/a24.png\",\"name\":\"Amani \",\"name_hindi\":\"अमानी\",\"name_arbic\":\"أماني\",\"is_selected\":\"false\",\"is_featured_a\":\"true\",\"is_best_artist\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"24\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ps9hhh73886h/ba1.png\",\"name\":\"Mahmud Zafir\",\"name_hindi\":\"महमूद जफीर\",\"name_arbic\":\"محمود ظافر\",\"is_selected\":\"false\",\"is_featured_a\":\"false\",\"is_best_artist\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"25\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/yrpdkmz9n908/ba2.png\",\"name\":\"Ain Ayeh\",\"name_hindi\":\"ऐं अयेह\",\"name_arbic\":\"عين آية\",\"is_selected\":\"false\",\"is_featured_a\":\"false\",\"is_best_artist\":\"true\"}')),
    ArtistsMStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"26\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/n6ah5bx0wkkg/ba3.png\",\"name\":\"Rabab Bayan\",\"name_hindi\":\"रबाब बयान\",\"name_arbic\":\"رباب بيان\",\"is_selected\":\"false\",\"is_featured_a\":\"false\",\"is_best_artist\":\"true\"}'))
  ];
  List<ArtistsMStruct> get chooseArList => _chooseArList;
  set chooseArList(List<ArtistsMStruct> value) {
    _chooseArList = value;
  }

  void addToChooseArList(ArtistsMStruct value) {
    chooseArList.add(value);
  }

  void removeFromChooseArList(ArtistsMStruct value) {
    chooseArList.remove(value);
  }

  void removeAtIndexFromChooseArList(int index) {
    chooseArList.removeAt(index);
  }

  void updateChooseArListAtIndex(
    int index,
    ArtistsMStruct Function(ArtistsMStruct) updateFn,
  ) {
    chooseArList[index] = updateFn(_chooseArList[index]);
  }

  void insertAtIndexInChooseArList(int index, ArtistsMStruct value) {
    chooseArList.insert(index, value);
  }

  List<CmStruct> _catList = [
    CmStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"1\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/simuliziza-sauti-i264or/assets/r1xap5pz8t7l/love.png\",\"c_name\":\"Mapenzi\",\"c_n_hindi\":\"Love\",\"c_n_arbic\":\"محبة\"}')),
    CmStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"2\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/simuliziza-sauti-i264or/assets/c770e80krgno/detective.png\",\"c_name\":\"Upelelezi\",\"c_n_hindi\":\"Detective\",\"c_n_arbic\":\"التجسس\"}')),
    CmStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"5\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/simuliziza-sauti-i264or/assets/yvcm0tve6eir/scary.png\",\"c_name\":\"Kutisha\",\"c_n_hindi\":\"Scary\",\"c_n_arbic\":\"مخيف\"}')),
    CmStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"3\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/simuliziza-sauti-i264or/assets/wetxh77ahe7i/comedians.png\",\"c_name\":\"Cheka\",\"c_n_hindi\":\"Comedy\",\"c_n_arbic\":\"كوميديا\"}')),
    CmStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"4\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/simuliziza-sauti-i264or/assets/h8uud0fynqg4/life.png\",\"c_name\":\"Maisha\",\"c_n_hindi\":\"Life\",\"c_n_arbic\":\"معيشة\"}'))
  ];
  List<CmStruct> get catList => _catList;
  set catList(List<CmStruct> value) {
    _catList = value;
    secureStorage.setStringList(
        'ff_catList', value.map((x) => x.serialize()).toList());
  }

  void deleteCatList({bool resetState = false}) {
    if (resetState) {
      _catList = [];
    }
    secureStorage.delete(key: 'ff_catList');
  }

  void addToCatList(CmStruct value) {
    catList.add(value);
    secureStorage.setStringList(
        'ff_catList', _catList.map((x) => x.serialize()).toList());
  }

  void removeFromCatList(CmStruct value) {
    catList.remove(value);
    secureStorage.setStringList(
        'ff_catList', _catList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromCatList(int index) {
    catList.removeAt(index);
    secureStorage.setStringList(
        'ff_catList', _catList.map((x) => x.serialize()).toList());
  }

  void updateCatListAtIndex(
    int index,
    CmStruct Function(CmStruct) updateFn,
  ) {
    catList[index] = updateFn(_catList[index]);
    secureStorage.setStringList(
        'ff_catList', _catList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInCatList(int index, CmStruct value) {
    catList.insert(index, value);
    secureStorage.setStringList(
        'ff_catList', _catList.map((x) => x.serialize()).toList());
  }

  List<MusicMStruct> _songList = [
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"0\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/xtn9ghqk9sky/s1.png\",\"name\":\"Tum Hi Ho\",\"name_hindi\":\"तुम ही हो\",\"name_arbic\":\"توم هاي هو\",\"sub_title\":\"Reema Cham\",\"s_t_hindi\":\"रीमा चाम\",\"s_t_arbic\":\"ريما شام\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"1\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/a79m3pa7aqo1/s2.png\",\"name\":\"Hold It Now, Hit It\",\"name_hindi\":\"इसे अभी पकड़ो, इसे मारो\",\"name_arbic\":\"أمسكها الآن، اضربها\",\"sub_title\":\"Baha al Din\",\"s_t_hindi\":\"बहा अल दीन\",\"s_t_arbic\":\"بهاء الدين\",\"is_quick_pick\":\"true\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"2\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/0i25bp5bmmjl/s3.png\",\"name\":\"The choice is yours\",\"name_hindi\":\"चुनाव तुम्हारा है\",\"name_arbic\":\"الخيار لك\",\"sub_title\":\"Suhail Hajjar\",\"s_t_hindi\":\"सुहैल हज्जर\",\"s_t_arbic\":\"سهيل حجار\",\"is_quick_pick\":\"true\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"1\",\"id\":\"3\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/2t2qgsbsq763/s4.png\",\"name\":\"Deep Cover\",\"name_hindi\":\"डीप कवर\",\"name_arbic\":\"غطاء عميق\",\"sub_title\":\"Saad Salib\",\"s_t_hindi\":\"साद सालिब\",\"s_t_arbic\":\"سعد صليب\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"1\",\"id\":\"4\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/cei4zozn6shu/s5.png\",\"name\":\"Niggas in Paris\",\"name_hindi\":\"पेरिस में निगास\",\"name_arbic\":\"الزنوج في باريس\",\"sub_title\":\"Jawahir Nader\",\"s_t_hindi\":\"जवाहिर नादेर\",\"s_t_arbic\":\"جواهر نادر\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"1\",\"id\":\"5\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/qv5aqh6id32b/s6.png\",\"name\":\"Int’l players anthem\",\"name_hindi\":\"अंतर्राष्ट्रीय खिलाड़ियों का गान\",\"name_arbic\":\"نشيد اللاعبين الدوليين\",\"sub_title\":\"Jawahir Nader\",\"s_t_hindi\":\"जवाहिर नादेर\",\"s_t_arbic\":\"جواهر نادر\",\"is_quick_pick\":\"true\",\"is_ts\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"2\",\"id\":\"6\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/343zs0n1yw86/s7.png\",\"name\":\"Roxanne roxanne\",\"name_hindi\":\"रौक्सैन रौक्सैन\",\"name_arbic\":\"روكسان روكسان\",\"sub_title\":\"Jawahir Nader\",\"s_t_hindi\":\"जवाहिर नादेर\",\"s_t_arbic\":\"جواهر نادر\",\"is_quick_pick\":\"true\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"2\",\"id\":\"7\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/fbilokh9w0xp/s8.png\",\"name\":\"Who do we trust\",\"name_hindi\":\"हम किस पर भरोसा करें\",\"name_arbic\":\"بمن نثق\",\"sub_title\":\"Jawahir Nader\",\"s_t_hindi\":\"जवाहिर नादेर\",\"s_t_arbic\":\"جواهر نادر\",\"is_quick_pick\":\"true\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"4\",\"id\":\"8\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/n263hvwu0j72/s9.png\",\"name\":\"Pehle Bhi Main\",\"name_hindi\":\"पहले भी मैं\",\"name_arbic\":\"بيهلي بهي مين\",\"sub_title\":\"Yoonus Said\",\"s_t_hindi\":\"यूनुस ने कहा\",\"s_t_arbic\":\"يونس سعيد\",\"is_quick_pick\":\"true\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"4\",\"id\":\"9\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/kad7jrqsd2co/s10.png\",\"name\":\"My mistakes \",\"name_hindi\":\"मेरी गलतियाँ\",\"name_arbic\":\"اخطائي\",\"sub_title\":\"Saad Salib\",\"s_t_hindi\":\"साद सालिब\",\"s_t_arbic\":\"سعد صليب\",\"is_quick_pick\":\"true\",\"is_ts\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"6\",\"id\":\"10\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/hcg0b2en9s7l/s11.png\",\"name\":\"Milne kiaaas\",\"name_hindi\":\"मिल्ने किआआस\",\"name_arbic\":\"ميلن كيااس\",\"sub_title\":\"Zakiyah Warqa\",\"s_t_hindi\":\"जकियाह वारका\",\"s_t_arbic\":\"زكية ورقا\",\"is_quick_pick\":\"true\",\"is_ts\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"3\",\"id\":\"11\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/fq04yv8dmi9g/s15.png\",\"name\":\"Nijame ne chebutunna\",\"name_hindi\":\"निजामे ने चेबुतुन्ना\",\"name_arbic\":\"نجمي ني تشيبوتونا\",\"sub_title\":\"Baha al Din\",\"s_t_hindi\":\"बहा अल दीन\",\"s_t_arbic\":\"بهاء الدين\",\"is_quick_pick\":\"true\",\"is_ts\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"12\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/1i1bmqg7db2q/sa1.png\",\"name\":\"Better Together\",\"name_hindi\":\"एक साथ बेहतर\",\"name_arbic\":\"معا أفضل\",\"sub_title\":\"Album (2021)\",\"s_t_hindi\":\"एल्बम (2021)\",\"s_t_arbic\":\"الألبوم (2021)\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"5\",\"id\":\"13\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/rtdk92drer2n/sa2.png\",\"name\":\"Moment By Moment\",\"name_hindi\":\"पल-पल\",\"name_arbic\":\"لحظة بلحظة\",\"sub_title\":\"Album (2018)\",\"s_t_hindi\":\"एल्बम (2018)\",\"s_t_arbic\":\"ألبوم (2018)\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"6\",\"id\":\"14\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/pfivzj2orl99/sa3.png\",\"name\":\"The weeknd poster design\",\"name_hindi\":\"सप्ताहांत पोस्टर डिज़ाइन\",\"name_arbic\":\"تصميم ملصق عطلة نهاية الأسبوع\",\"sub_title\":\"Album (2020)\",\"s_t_hindi\":\"एल्बम (2020)\",\"s_t_arbic\":\"الألبوم (2020)\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"6\",\"id\":\"15\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/qch8686yk151/sa4.png\",\"name\":\"Home is with you\",\"name_hindi\":\"घर आपके साथ है\",\"name_arbic\":\"المنزل معك\",\"sub_title\":\"Album (2024)\",\"s_t_hindi\":\"एल्बम (2024)\",\"s_t_arbic\":\"الألبوم (2024)\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"3\",\"id\":\"16\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/n25on8gxjqjx/sa5.png\",\"name\":\"Gather Together\",\"name_hindi\":\"एक साथ इकट्ठा\",\"name_arbic\":\"جمع معا\",\"sub_title\":\"Album (2000)\",\"s_t_hindi\":\"एल्बम (2000)\",\"s_t_arbic\":\"ألبوم (2000)\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"7\",\"id\":\"17\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/kc1qchkc1pvv/sa6.png\",\"name\":\"Family is forever\",\"name_hindi\":\"परिवार सदा के लिए\",\"name_arbic\":\"العائلة للابد\",\"sub_title\":\"Album (2009)\",\"s_t_hindi\":\"एल्बम (2009)\",\"s_t_arbic\":\"ألبوم (2009)\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"7\",\"id\":\"18\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/c9yx3i65nlai/r1.png\",\"name\":\"Pehle Bhi Main\",\"name_hindi\":\"पहले भी मैं\",\"name_arbic\":\"بيهلي بهي مين\",\"sub_title\":\"Yoonus Said\",\"s_t_hindi\":\"यूनुस ने कहा\",\"s_t_arbic\":\"يونس سعيد\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"false\",\"related_song\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"8\",\"id\":\"19\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/7h1wfqgam5zz/r2.png\",\"name\":\"Chaleya\",\"name_hindi\":\"चालेया\",\"name_arbic\":\"تشاليا\",\"sub_title\":\"Jawahir Nader\",\"s_t_hindi\":\"जवाहिर नादेर\",\"s_t_arbic\":\"جواهر نادر\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"false\",\"related_song\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"4\",\"id\":\"20\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/luh387yvhcip/r3.png\",\"name\":\"Akhiyaan gulaab\",\"name_hindi\":\"अखियां गुलाब\",\"name_arbic\":\"أخيان جلاب\",\"sub_title\":\"Suhail Hajjar\",\"s_t_hindi\":\"सुहैल हज्जर\",\"s_t_arbic\":\"سهيل حجار\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"false\",\"related_song\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"8\",\"id\":\"21\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/jsdxbpimxzjl/r4.png\",\"name\":\"Nijame ne chebutunna\",\"name_hindi\":\"निजामे ने चेबुतुन्ना\",\"name_arbic\":\"نجمي ني تشيبوتونا\",\"sub_title\":\"Baha al Din\",\"s_t_hindi\":\"बहा अल दीन\",\"s_t_arbic\":\"بهاء الدين\",\"is_quick_pick\":\"false\",\"is_ts\":\"true\",\"is_album\":\"false\",\"in_playlist\":\"false\",\"related_song\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"9\",\"id\":\"22\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/kwcb6w9blhkb/r5.png\",\"name\":\"Tum Hi Ho\",\"name_hindi\":\"तुम ही हो\",\"name_arbic\":\"توم هاي هو\",\"sub_title\":\"Reema Cham\",\"s_t_hindi\":\"रीमा चाम\",\"s_t_arbic\":\"ريما شام\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"false\",\"related_song\":\"true\"}'))
  ];
  List<MusicMStruct> get songList => _songList;
  set songList(List<MusicMStruct> value) {
    _songList = value;
  }

  void addToSongList(MusicMStruct value) {
    songList.add(value);
  }

  void removeFromSongList(MusicMStruct value) {
    songList.remove(value);
  }

  void removeAtIndexFromSongList(int index) {
    songList.removeAt(index);
  }

  void updateSongListAtIndex(
    int index,
    MusicMStruct Function(MusicMStruct) updateFn,
  ) {
    songList[index] = updateFn(_songList[index]);
  }

  void insertAtIndexInSongList(int index, MusicMStruct value) {
    songList.insert(index, value);
  }

  List<NmStruct> _nList = [
    NmStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"The notification bar  is the black bar.\",\"title_hindi\":\"अधिसूचना पट्टी काली पट्टी है.\",\"title_arbic\":\"شريط الإعلام هو الشريط الأسود.\",\"time\":\"Just now\",\"time_hindi\":\"बस अब\",\"time_arbic\":\"الآن\"}')),
    NmStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Can see notification history of my profile.\",\"title_hindi\":\"मेरी प्रोफ़ाइल का अधिसूचना इतिहास देख सकते हैं.\",\"title_arbic\":\"يمكن رؤية سجل الإخطارات لملفي الشخصي.\",\"time\":\"1 Min\",\"time_hindi\":\"1 मिनट\",\"time_arbic\":\"1 دقيقة\"}')),
    NmStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"How do I open notification center\",\"title_hindi\":\"मैं अधिसूचना केंद्र कैसे खोलूं?\",\"title_arbic\":\"كيف أفتح مركز الإشعارات\",\"time\":\"2 Min\",\"time_hindi\":\"2 मिनट\",\"time_arbic\":\"2 دقيقة\"}')),
    NmStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"The notification bar  is the black bar.\",\"title_hindi\":\"अधिसूचना पट्टी काली पट्टी है.\",\"title_arbic\":\"شريط الإعلام هو الشريط الأسود.\",\"time\":\"5 Min\",\"time_hindi\":\"5 मिनट\",\"time_arbic\":\"5 دقائق\"}')),
    NmStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"How do I turn off all notifications\",\"title_hindi\":\"मैं सभी सूचनाएं कैसे बंद करूं?\",\"title_arbic\":\"كيف يمكنني إيقاف جميع الإشعارات\",\"time\":\"15 Min\",\"time_hindi\":\"15 मिनट\",\"time_arbic\":\"15 دقيقة\"}')),
    NmStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"How do i reset my notification settings\",\"title_hindi\":\"मैं अपनी अधिसूचना सेटिंग कैसे रीसेट करूं?\",\"title_arbic\":\"كيف يمكنني إعادة ضبط إعدادات الإشعارات؟\",\"time\":\"20 Min\",\"time_hindi\":\"20 मिनट\",\"time_arbic\":\"20 دقيقة\"}')),
    NmStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"Can\'t I turn on notifications for an app\",\"title_hindi\":\"क्या मैं किसी ऐप के लिए नोटिफिकेशन चालू नहीं कर सकता?\",\"title_arbic\":\"لا أستطيع تشغيل الإشعارات لتطبيق ما\",\"time\":\"30 Min\",\"time_hindi\":\"30 मिनट\",\"time_arbic\":\"30 دقيقة\"}'))
  ];
  List<NmStruct> get nList => _nList;
  set nList(List<NmStruct> value) {
    _nList = value;
  }

  void addToNList(NmStruct value) {
    nList.add(value);
  }

  void removeFromNList(NmStruct value) {
    nList.remove(value);
  }

  void removeAtIndexFromNList(int index) {
    nList.removeAt(index);
  }

  void updateNListAtIndex(
    int index,
    NmStruct Function(NmStruct) updateFn,
  ) {
    nList[index] = updateFn(_nList[index]);
  }

  void insertAtIndexInNList(int index, NmStruct value) {
    nList.insert(index, value);
  }

  List<String> _searchedList = [
    'Tere Vaaste',
    'Heeriye feat Arijit Singh',
    'Abrar\'S Entry Jamal Kudu',
    'Heer Aasmani',
    'Saari Duniva Jalaa Denge',
    'What Jhumka',
    'Who do we trust'
  ];
  List<String> get searchedList => _searchedList;
  set searchedList(List<String> value) {
    _searchedList = value;
    secureStorage.setStringList('ff_searchedList', value);
  }

  void deleteSearchedList({bool resetState = false}) {
    if (resetState) {
      _searchedList = [];
    }
    secureStorage.delete(key: 'ff_searchedList');
  }

  void addToSearchedList(String value) {
    searchedList.add(value);
    secureStorage.setStringList('ff_searchedList', _searchedList);
  }

  void removeFromSearchedList(String value) {
    searchedList.remove(value);
    secureStorage.setStringList('ff_searchedList', _searchedList);
  }

  void removeAtIndexFromSearchedList(int index) {
    searchedList.removeAt(index);
    secureStorage.setStringList('ff_searchedList', _searchedList);
  }

  void updateSearchedListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    searchedList[index] = updateFn(_searchedList[index]);
    secureStorage.setStringList('ff_searchedList', _searchedList);
  }

  void insertAtIndexInSearchedList(int index, String value) {
    searchedList.insert(index, value);
    secureStorage.setStringList('ff_searchedList', _searchedList);
  }

  List<MusicMStruct> _popularalbum = [];
  List<MusicMStruct> get popularalbum => _popularalbum;
  set popularalbum(List<MusicMStruct> value) {
    _popularalbum = value;
  }

  void addToPopularalbum(MusicMStruct value) {
    popularalbum.add(value);
  }

  void removeFromPopularalbum(MusicMStruct value) {
    popularalbum.remove(value);
  }

  void removeAtIndexFromPopularalbum(int index) {
    popularalbum.removeAt(index);
  }

  void updatePopularalbumAtIndex(
    int index,
    MusicMStruct Function(MusicMStruct) updateFn,
  ) {
    popularalbum[index] = updateFn(_popularalbum[index]);
  }

  void insertAtIndexInPopularalbum(int index, MusicMStruct value) {
    popularalbum.insert(index, value);
  }

  List<MusicMStruct> _allplayList = [
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"0\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/mft6cer6qiih/ap1.png\",\"name\":\"Song by sidharth\",\"name_hindi\":\"सिद्धार्थ का गाना\",\"name_arbic\":\"أغنية لسيدهارث\",\"sub_title\":\"By Jane cooper\",\"s_t_hindi\":\"जेन कूपर द्वारा\",\"s_t_arbic\":\"بقلم جين كوبر\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"1\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/qwzwntpmrcd4/ap2.png\",\"name\":\"Hey sinamika\",\"name_hindi\":\"अरे सिनामिका\",\"name_arbic\":\"يا سيناميكا\",\"sub_title\":\"By Govind vasantha\",\"s_t_hindi\":\"गोविंद वसंत द्वारा\",\"s_t_arbic\":\"بواسطة جوفيند فاسانثا\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"2\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/nrktmu149uq6/ap3.png\",\"name\":\"Sita Ramam Movie\",\"name_hindi\":\"सीता रामम फिल्म\",\"name_arbic\":\"فيلم سيتا رمام\",\"sub_title\":\"By Shashid capoor\",\"s_t_hindi\":\"शशिद कपूर द्वारा\",\"s_t_arbic\":\"بواسطة شاشيد كابور\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"3\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ywkotvca94b0/ap4.png\",\"name\":\"Love sathiya\",\"name_hindi\":\"लव साथिया\",\"name_arbic\":\"أحب ساتيا\",\"sub_title\":\"By Lloyd deardorff\",\"s_t_hindi\":\"लॉयड डियरडॉर्फ द्वारा\",\"s_t_arbic\":\"بقلم لويد ديردورف\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"4\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/6po4qe3ikr7o/ap5.png\",\"name\":\"Song by sidharth\",\"name_hindi\":\"सिद्धार्थ का गाना\",\"name_arbic\":\"أغنية لسيدهارث\",\"sub_title\":\"By Jane cooper\",\"s_t_hindi\":\"जेन कूपर द्वारा\",\"s_t_arbic\":\"بقلم جين كوبر\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"5\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/37y2ji0z44a2/ap6.png\",\"name\":\"Song by sidharth\",\"name_hindi\":\"सिद्धार्थ का गाना\",\"name_arbic\":\"أغنية لسيدهارث\",\"sub_title\":\"By Jane cooper\",\"s_t_hindi\":\"जेन कूपर द्वारा\",\"s_t_arbic\":\"بقلم جين كوبر\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"false\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"6\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/19c35fgo0thr/ap7.png\",\"name\":\"Bhala Jhiate\",\"name_hindi\":\"भला झियाटे\",\"name_arbic\":\"بهالا جياتي\",\"sub_title\":\"By Kumar Sanu\",\"s_t_hindi\":\"कुमार शानू द्वारा\",\"s_t_arbic\":\"بقلم كومار سانو\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"7\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/2qh54p71j3d5/ap8.png\",\"name\":\"Best Of Kumar Sanu\",\"name_hindi\":\"कुमार शानू के सर्वश्रेष्ठ\",\"name_arbic\":\"أفضل من كومار سانو\",\"sub_title\":\"By Kumar Sanu\",\"s_t_hindi\":\"कुमार शानू द्वारा\",\"s_t_arbic\":\"بقلم كومار سانو\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"8\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/bp34yt19fmkx/ap9.png\",\"name\":\"Heart touching song\",\"name_hindi\":\"दिल को छू लेने वाला गाना\",\"name_arbic\":\"أغنية تلمس القلب\",\"sub_title\":\"By Shashid capoor\",\"s_t_hindi\":\"शशिद कपूर द्वारा\",\"s_t_arbic\":\"بواسطة شاشيد كابور\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"true\"}')),
    MusicMStruct.fromSerializableMap(jsonDecode(
        '{\"prid\":\"0\",\"id\":\"9\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/my1qen7uz7o2/ap10.png\",\"name\":\"Nakhra husn ka \",\"name_hindi\":\"नखरा हुस्न का\",\"name_arbic\":\"ناخرا حسن كا\",\"sub_title\":\"By Lloyd deardorff\",\"s_t_hindi\":\"लॉयड डियरडॉर्फ द्वारा\",\"s_t_arbic\":\"بقلم لويد ديردورف\",\"is_quick_pick\":\"false\",\"is_ts\":\"false\",\"is_album\":\"false\",\"in_playlist\":\"true\"}'))
  ];
  List<MusicMStruct> get allplayList => _allplayList;
  set allplayList(List<MusicMStruct> value) {
    _allplayList = value;
  }

  void addToAllplayList(MusicMStruct value) {
    allplayList.add(value);
  }

  void removeFromAllplayList(MusicMStruct value) {
    allplayList.remove(value);
  }

  void removeAtIndexFromAllplayList(int index) {
    allplayList.removeAt(index);
  }

  void updateAllplayListAtIndex(
    int index,
    MusicMStruct Function(MusicMStruct) updateFn,
  ) {
    allplayList[index] = updateFn(_allplayList[index]);
  }

  void insertAtIndexInAllplayList(int index, MusicMStruct value) {
    allplayList.insert(index, value);
  }

  List<PfudStruct> _plfudList = [
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"0\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/e8ucbtbgqhp6/p1.png\",\"name\":\"J-pop\",\"name_hindi\":\"जे-पॉप\",\"name_arbic\":\"ي البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"1\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/p34w6qsmmu75/p2.png\",\"name\":\"K-pop\",\"name_hindi\":\"के पॉप\",\"name_arbic\":\"ك البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"2\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/4jiatrvqhys4/p3.png\",\"name\":\"R-pop\",\"name_hindi\":\"आर-पॉप\",\"name_arbic\":\"ص البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"3\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/6wo1rj162hm8/p4.png\",\"name\":\"G-pop\",\"name_hindi\":\"जी-पॉप\",\"name_arbic\":\"جي البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"4\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/x58h88jvxjne/p5.png\",\"name\":\"T-pop\",\"name_hindi\":\"टी पॉप\",\"name_arbic\":\"تي البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"5\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/qlv0d9hzgbkn/p6.png\",\"name\":\"W-pop\",\"name_hindi\":\"डब्ल्यू-पॉप\",\"name_arbic\":\"دبليو البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"6\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/o0me8367dznn/p7.png\",\"name\":\"P-pop\",\"name_hindi\":\"पी पॉप\",\"name_arbic\":\"ف البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"7\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/iyuu7t8mpaf3/p8.png\",\"name\":\"V-pop\",\"name_hindi\":\"वी पॉप\",\"name_arbic\":\"الخامس البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"8\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/2l2018ibvg8t/p9.png\",\"name\":\"N-pop\",\"name_hindi\":\"एन पॉप\",\"name_arbic\":\"ن البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"9\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ztjnfxn0orvc/p10.png\",\"name\":\"M-pop\",\"name_hindi\":\"एम पॉप\",\"name_arbic\":\"م البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"10\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/ykhcllmgvf5o/p11.png\",\"name\":\"Y-pop\",\"name_hindi\":\"वाई पॉप\",\"name_arbic\":\"ي البوب\"}')),
    PfudStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"11\",\"img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/mvcia4pn8pk6/p12.png\",\"name\":\"Q-pop\",\"name_hindi\":\"क्यू पॉप\",\"name_arbic\":\"س البوب\"}'))
  ];
  List<PfudStruct> get plfudList => _plfudList;
  set plfudList(List<PfudStruct> value) {
    _plfudList = value;
  }

  void addToPlfudList(PfudStruct value) {
    plfudList.add(value);
  }

  void removeFromPlfudList(PfudStruct value) {
    plfudList.remove(value);
  }

  void removeAtIndexFromPlfudList(int index) {
    plfudList.removeAt(index);
  }

  void updatePlfudListAtIndex(
    int index,
    PfudStruct Function(PfudStruct) updateFn,
  ) {
    plfudList[index] = updateFn(_plfudList[index]);
  }

  void insertAtIndexInPlfudList(int index, PfudStruct value) {
    plfudList.insert(index, value);
  }

  List<MusicMStruct> _creatPlList = [];
  List<MusicMStruct> get creatPlList => _creatPlList;
  set creatPlList(List<MusicMStruct> value) {
    _creatPlList = value;
  }

  void addToCreatPlList(MusicMStruct value) {
    creatPlList.add(value);
  }

  void removeFromCreatPlList(MusicMStruct value) {
    creatPlList.remove(value);
  }

  void removeAtIndexFromCreatPlList(int index) {
    creatPlList.removeAt(index);
  }

  void updateCreatPlListAtIndex(
    int index,
    MusicMStruct Function(MusicMStruct) updateFn,
  ) {
    creatPlList[index] = updateFn(_creatPlList[index]);
  }

  void insertAtIndexInCreatPlList(int index, MusicMStruct value) {
    creatPlList.insert(index, value);
  }

  int _langIndex = 0;
  int get langIndex => _langIndex;
  set langIndex(int value) {
    _langIndex = value;
    secureStorage.setInt('ff_langIndex', value);
  }

  void deleteLangIndex({bool resetState = false}) {
    if (resetState) {
      _langIndex = 0;
    }
    secureStorage.delete(key: 'ff_langIndex');
  }

  List<OnboardMStruct> _onboardList = [
    OnboardMStruct.fromSerializableMap(jsonDecode(
        '{\"Id\":\"0\",\"BackImg\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/plhl26bvf3ae/backon1.png\",\"Img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/simuliziza-sauti-i264or/assets/frvanhl516ey/o1.png\",\"Title\":\"Simulizi Kiganjani kwako\",\"SubTitle\":\"Kuwa wa kwanza kupata simulizi za Kiswahili zenye kusisimua na kuelimisha kwa njia ya sauti moja kwa moja kwenye simu yako.\"}')),
    OnboardMStruct.fromSerializableMap(jsonDecode(
        '{\"Id\":\"1\",\"BackImg\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/7ywvo7iyti2a/backon2.png\",\"Img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/simuliziza-sauti-i264or/assets/lmcp8kqlqm14/o2.png\",\"Title\":\"Simulizi za kila aina\",\"SubTitle\":\"Sikiliza simulizi za mapenzi, uchawi, siasa na uchumi kutokea mahali popote ulipo upate kujifunza na kuhabarika.\"}')),
    OnboardMStruct.fromSerializableMap(jsonDecode(
        '{\"Id\":\"2\",\"BackImg\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/vq78dkn3sk67/backon3.png\",\"Img\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/tune-track-music-app-omyrkn/assets/rec25t0gsi7z/on3.png\",\"Title\":\"Sikiliza Offline\",\"SubTitle\":\"Furahia simulizi hata bila intaneti ukiwa safarini au nyumbani.Internet si changamoto tena.\"}'))
  ];
  List<OnboardMStruct> get onboardList => _onboardList;
  set onboardList(List<OnboardMStruct> value) {
    _onboardList = value;
    secureStorage.setStringList(
        'ff_onboardList', value.map((x) => x.serialize()).toList());
  }

  void deleteOnboardList({bool resetState = false}) {
    if (resetState) {
      _onboardList = [];
    }
    secureStorage.delete(key: 'ff_onboardList');
  }

  void addToOnboardList(OnboardMStruct value) {
    onboardList.add(value);
    secureStorage.setStringList(
        'ff_onboardList', _onboardList.map((x) => x.serialize()).toList());
  }

  void removeFromOnboardList(OnboardMStruct value) {
    onboardList.remove(value);
    secureStorage.setStringList(
        'ff_onboardList', _onboardList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromOnboardList(int index) {
    onboardList.removeAt(index);
    secureStorage.setStringList(
        'ff_onboardList', _onboardList.map((x) => x.serialize()).toList());
  }

  void updateOnboardListAtIndex(
    int index,
    OnboardMStruct Function(OnboardMStruct) updateFn,
  ) {
    onboardList[index] = updateFn(_onboardList[index]);
    secureStorage.setStringList(
        'ff_onboardList', _onboardList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInOnboardList(int index, OnboardMStruct value) {
    onboardList.insert(index, value);
    secureStorage.setStringList(
        'ff_onboardList', _onboardList.map((x) => x.serialize()).toList());
  }

  UserInfoStruct _userInfo = UserInfoStruct();
  UserInfoStruct get userInfo => _userInfo;
  set userInfo(UserInfoStruct value) {
    _userInfo = value;
    secureStorage.setString('ff_userInfo', value.serialize());
  }

  void deleteUserInfo({bool resetState = false}) {
    if (resetState) {
      _userInfo = UserInfoStruct();
    }
    secureStorage.delete(key: 'ff_userInfo');
  }

  void updateUserInfoStruct(Function(UserInfoStruct) updateFn) {
    updateFn(_userInfo);
    secureStorage.setString('ff_userInfo', _userInfo.serialize());
  }

  bool _skipUser = false;
  bool get skipUser => _skipUser;
  set skipUser(bool value) {
    _skipUser = value;
    secureStorage.setBool('ff_skipUser', value);
  }

  void deleteSkipUser({bool resetState = false}) {
    if (resetState) {
      _skipUser = false;
    }
    secureStorage.delete(key: 'ff_skipUser');
  }

  bool _isShowBottomPlayer = false;
  bool get isShowBottomPlayer => _isShowBottomPlayer;
  set isShowBottomPlayer(bool value) {
    _isShowBottomPlayer = value;
    secureStorage.setBool('ff_isShowBottomPlayer', value);
  }

  void deleteIsShowBottomPlayer({bool resetState = false}) {
    if (resetState) {
      _isShowBottomPlayer = false;
    }
    secureStorage.delete(key: 'ff_isShowBottomPlayer');
  }

  String _username = '';
  String get username => _username;
  set username(String value) {
    _username = value;
    secureStorage.setString('ff_username', value);
  }

  void deleteUsername({bool resetState = false}) {
    if (resetState) {
      _username = '';
    }
    secureStorage.delete(key: 'ff_username');
  }

  // Login session token issued by the backend. Replaces storing the user's password.
  String _authToken = '';
  String get authToken => _authToken;
  set authToken(String value) {
    _authToken = value;
    ApiManager.accessToken = value;
    secureStorage.setString('ff_authToken', value);
  }

  void deleteAuthToken({bool resetState = false}) {
    if (resetState) {
      _authToken = '';
      ApiManager.accessToken = null;
    }
    secureStorage.delete(key: 'ff_authToken');
  }

  Future<void> _restoreAuthToken() async {
    _authToken = await secureStorage.getString('ff_authToken') ?? _authToken;
    ApiManager.accessToken = _authToken;
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    secureStorage.setString('ff_password', value);
  }

  void deletePassword({bool resetState = false}) {
    if (resetState) {
      _password = '';
    }
    secureStorage.delete(key: 'ff_password');
  }

  String _fullname = '';
  String get fullname => _fullname;
  set fullname(String value) {
    _fullname = value;
    secureStorage.setString('ff_fullname', value);
  }

  void deleteFullname({bool resetState = false}) {
    if (resetState) {
      _fullname = '';
    }
    secureStorage.delete(key: 'ff_fullname');
  }

  String _phonenumber = '';
  String get phonenumber => _phonenumber;
  set phonenumber(String value) {
    _phonenumber = value;
    secureStorage.setString('ff_phonenumber', value);
  }

  void deletePhonenumber({bool resetState = false}) {
    if (resetState) {
      _phonenumber = '';
    }
    secureStorage.delete(key: 'ff_phonenumber');
  }

  String _devicetoken = '';
  String get devicetoken => _devicetoken;
  set devicetoken(String value) {
    _devicetoken = value;
    secureStorage.setString('ff_devicetoken', value);
  }

  void deleteDevicetoken({bool resetState = false}) {
    if (resetState) {
      _devicetoken = '';
    }
    secureStorage.delete(key: 'ff_devicetoken');
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    secureStorage.setString('ff_email', value);
  }

  void deleteEmail({bool resetState = false}) {
    if (resetState) {
      _email = '';
    }
    secureStorage.delete(key: 'ff_email');
  }

  String _bio = '';
  String get bio => _bio;
  set bio(String value) {
    _bio = value;
    secureStorage.setString('ff_bio', value);
  }

  void deleteBio({bool resetState = false}) {
    if (resetState) {
      _bio = '';
    }
    secureStorage.delete(key: 'ff_bio');
  }

  String _userid = '';
  String get userid => _userid;
  set userid(String value) {
    _userid = value;
    secureStorage.setString('ff_userid', value);
  }

  void deleteUserid({bool resetState = false}) {
    if (resetState) {
      _userid = '';
    }
    secureStorage.delete(key: 'ff_userid');
  }

  dynamic _nowPlaying;
  dynamic get nowPlaying => _nowPlaying;
  set nowPlaying(dynamic value) {
    _nowPlaying = value;
  }

  String _userphoto = '';
  String get userphoto => _userphoto;
  set userphoto(String value) {
    _userphoto = value;
    secureStorage.setString('ff_userphoto', value);
  }

  void deleteUserphoto({bool resetState = false}) {
    if (resetState) {
      _userphoto = '';
    }
    secureStorage.delete(key: 'ff_userphoto');
  }

  String _joinedat = '';
  String get joinedat => _joinedat;
  set joinedat(String value) {
    _joinedat = value;
    secureStorage.setString('ff_joinedat', value);
  }

  void deleteJoinedat({bool resetState = false}) {
    if (resetState) {
      _joinedat = '';
    }
    secureStorage.delete(key: 'ff_joinedat');
  }

  int _selectedTrackIndex = 0;
  int get selectedTrackIndex => _selectedTrackIndex;
  set selectedTrackIndex(int value) {
    _selectedTrackIndex = value;
    secureStorage.setInt('ff_selectedTrackIndex', value);
  }

  void deleteSelectedTrackIndex({bool resetState = false}) {
    if (resetState) {
      _selectedTrackIndex = 0;
    }
    secureStorage.delete(key: 'ff_selectedTrackIndex');
  }

  String _selectedTrackTitle = '';
  String get selectedTrackTitle => _selectedTrackTitle;
  set selectedTrackTitle(String value) {
    _selectedTrackTitle = value;
    secureStorage.setString('ff_selectedTrackTitle', value);
  }

  void deleteSelectedTrackTitle({bool resetState = false}) {
    if (resetState) {
      _selectedTrackTitle = '';
    }
    secureStorage.delete(key: 'ff_selectedTrackTitle');
  }

  String _selectedTrackUrl = '';
  String get selectedTrackUrl => _selectedTrackUrl;
  set selectedTrackUrl(String value) {
    _selectedTrackUrl = value;
    secureStorage.setString('ff_selectedTrackUrl', value);
  }

  void deleteSelectedTrackUrl({bool resetState = false}) {
    if (resetState) {
      _selectedTrackUrl = '';
    }
    secureStorage.delete(key: 'ff_selectedTrackUrl');
  }

  dynamic _currentStoryEpisodes;
  dynamic get currentStoryEpisodes => _currentStoryEpisodes;
  set currentStoryEpisodes(dynamic value) {
    _currentStoryEpisodes = value;
  }

  String _playercommand = 'toggle';
  String get playercommand => _playercommand;
  set playercommand(String value) {
    _playercommand = value;
  }

  bool _playerisplaying = false;
  bool get playerisplaying => _playerisplaying;
  set playerisplaying(bool value) {
    _playerisplaying = value;
    secureStorage.setBool('ff_playerisplaying', value);
  }

  void deletePlayerisplaying({bool resetState = false}) {
    if (resetState) {
      _playerisplaying = false;
    }
    secureStorage.delete(key: 'ff_playerisplaying');
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
  }

  int _walletcoin = 0;
  int get walletcoin => _walletcoin;
  set walletcoin(int value) {
    _walletcoin = value;
    secureStorage.setInt('ff_walletcoin', value);
  }

  void deleteWalletcoin({bool resetState = false}) {
    if (resetState) {
      _walletcoin = 0;
    }
    secureStorage.delete(key: 'ff_walletcoin');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async {
    final value = await read(key: key);
    return value == null ? null : value == 'true';
  }

  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        // Lists are stored as JSON. Older versions stored CSV, which never
        // starts with `["` because CSV quotes any field containing a quote.
        if (result == '[]' || result.startsWith('["')) {
          return (jsonDecode(result) as List).map((e) => e.toString()).toList();
        }
        return const CsvToListConverter(shouldParseNumbers: false)
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: jsonEncode(value));
}
