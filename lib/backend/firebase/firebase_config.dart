import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA8gs9emdIwKl1K-u16Vksei5QZm8Gnev8",
            authDomain: "simuliziza-sauti-i264or.firebaseapp.com",
            projectId: "simuliziza-sauti-i264or",
            storageBucket: "simuliziza-sauti-i264or.firebasestorage.app",
            messagingSenderId: "1067128048333",
            appId: "1:1067128048333:web:2189704a8b74b358637784",
            measurementId: "G-3D7H78KPCX"));
  } else {
    await Firebase.initializeApp();
  }
}
