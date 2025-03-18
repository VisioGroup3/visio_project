import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC9TDdPwkizFvCsYWTLfjZookYo4vQ5JCI",
            authDomain: "visio-6sum1m.firebaseapp.com",
            projectId: "visio-6sum1m",
            storageBucket: "visio-6sum1m.firebasestorage.app",
            messagingSenderId: "757551046475",
            appId: "1:757551046475:web:3ad115e9332ea7632712ce"));
  } else {
    await Firebase.initializeApp();
  }
}
