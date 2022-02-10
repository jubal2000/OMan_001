import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: "AIzaSyBhuFu_G7rtnyhxS0d1U5IuP6mPlmmUKPI",
        authDomain: "oman-01.firebaseapp.com",
        databaseURL: "https://oman-01-default-rtdb.firebaseio.com",
        projectId: "oman-01",
        storageBucket: "oman-01.appspot.com",
        messagingSenderId: "787744327503",
        appId: "1:787744327503:web:4547219f3599970e42273a",
        measurementId: "G-6BE7MLKMHH"
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:787744327503:android:51f37cdfe08d048f42273a',
        apiKey: 'AIzaSyCawDYld0KwdvQHTB_3h5gP1QEdaPajNWY',
        projectId: 'oman-01',
        messagingSenderId: '787744327503',
        iosBundleId: 'com.thenewways.oman-001',
        iosClientId:
        '787744327503-e7pi88k1mf9tob0cft2qufps2245ccmn.apps.googleusercontent.com',
        androidClientId:
        '787744327503-e7pi88k1mf9tob0cft2qufps2245ccmn.apps.googleusercontent.com',
        storageBucket: 'oman-01.appspot.com',
        databaseURL: 'https://oman-01-default-rtdb.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:787744327503:android:51f37cdfe08d048f42273a',
        apiKey: 'AIzaSyCvHmQjjtI7ewCXHDO7jEcWOH-VcL4JUuE',
        projectId: 'oman-01',
        messagingSenderId: '787744327503',
      );
    }
  }
}
