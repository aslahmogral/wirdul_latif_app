// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB7oZYsWhmdVRRWZLO_9NV0ya6PGQUn96k',
    appId: '1:1069262636562:web:c444c2e26bad42b298bacb',
    messagingSenderId: '1069262636562',
    projectId: 'wirdul-latif-pro',
    authDomain: 'wirdul-latif-pro.firebaseapp.com',
    storageBucket: 'wirdul-latif-pro.firebasestorage.app',
    measurementId: 'G-XMJTHX20K1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9gyww_9rE3ETDqq2MfrfP3eUv1nA2ilE',
    appId: '1:1069262636562:android:a89868fd82d8819898bacb',
    messagingSenderId: '1069262636562',
    projectId: 'wirdul-latif-pro',
    storageBucket: 'wirdul-latif-pro.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuClt97C7bnwv4RiSHEk5QPu9FmYO_3NQ',
    appId: '1:1069262636562:ios:73a3685410e56fb098bacb',
    messagingSenderId: '1069262636562',
    projectId: 'wirdul-latif-pro',
    storageBucket: 'wirdul-latif-pro.firebasestorage.app',
    iosBundleId: 'com.example.wirdulLatif',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCuClt97C7bnwv4RiSHEk5QPu9FmYO_3NQ',
    appId: '1:1069262636562:ios:73a3685410e56fb098bacb',
    messagingSenderId: '1069262636562',
    projectId: 'wirdul-latif-pro',
    storageBucket: 'wirdul-latif-pro.firebasestorage.app',
    iosBundleId: 'com.example.wirdulLatif',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7oZYsWhmdVRRWZLO_9NV0ya6PGQUn96k',
    appId: '1:1069262636562:web:ff7cb41031e9c8c198bacb',
    messagingSenderId: '1069262636562',
    projectId: 'wirdul-latif-pro',
    authDomain: 'wirdul-latif-pro.firebaseapp.com',
    storageBucket: 'wirdul-latif-pro.firebasestorage.app',
    measurementId: 'G-E99XKQCVBJ',
  );
}
