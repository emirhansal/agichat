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
    apiKey: 'AIzaSyAsygt7RjAoedG61h9gNTbuEufGDDmD94A',
    appId: '1:1098132241708:web:cb77bf93f2bfc3d6f98089',
    messagingSenderId: '1098132241708',
    projectId: 'agichat-e6b66',
    authDomain: 'agichat-e6b66.firebaseapp.com',
    storageBucket: 'agichat-e6b66.firebasestorage.app',
    measurementId: 'G-0TME3FMCN4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC046QdrsmFIMdhPqD14DKfiuZ0ADE2w3M',
    appId: '1:1098132241708:android:5b947f4e1d62c112f98089',
    messagingSenderId: '1098132241708',
    projectId: 'agichat-e6b66',
    storageBucket: 'agichat-e6b66.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwzvehO4UpRzoOgHPVvDZtjk6UUoMehvI',
    appId: '1:1098132241708:ios:34dd647ae7d26095f98089',
    messagingSenderId: '1098132241708',
    projectId: 'agichat-e6b66',
    storageBucket: 'agichat-e6b66.firebasestorage.app',
    iosBundleId: 'com.example.agichat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwzvehO4UpRzoOgHPVvDZtjk6UUoMehvI',
    appId: '1:1098132241708:ios:34dd647ae7d26095f98089',
    messagingSenderId: '1098132241708',
    projectId: 'agichat-e6b66',
    storageBucket: 'agichat-e6b66.firebasestorage.app',
    iosBundleId: 'com.example.agichat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAsygt7RjAoedG61h9gNTbuEufGDDmD94A',
    appId: '1:1098132241708:web:0c4d9ecc894accfaf98089',
    messagingSenderId: '1098132241708',
    projectId: 'agichat-e6b66',
    authDomain: 'agichat-e6b66.firebaseapp.com',
    storageBucket: 'agichat-e6b66.firebasestorage.app',
    measurementId: 'G-8QWM2E90VD',
  );
}
