// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBVTfPCw78ILkZ5nW5H02tgO8SHroXrDGI',
    appId: '1:674794837429:web:3d14d7db3a9b8e85d2b5fc',
    messagingSenderId: '674794837429',
    projectId: 'ecomfix',
    authDomain: 'ecomfix.firebaseapp.com',
    storageBucket: 'ecomfix.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBCzhKwE9JLb9-_AMjgvfxQWVHlAXhenQ',
    appId: '1:674794837429:android:133d6e2ec09eb310d2b5fc',
    messagingSenderId: '674794837429',
    projectId: 'ecomfix',
    storageBucket: 'ecomfix.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0dYNOLR8_akeb7FC_Cr7yGsTQFHxMQXc',
    appId: '1:674794837429:ios:2d34b9a4dff23b27d2b5fc',
    messagingSenderId: '674794837429',
    projectId: 'ecomfix',
    storageBucket: 'ecomfix.appspot.com',
    iosBundleId: 'com.example.ecomfix',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0dYNOLR8_akeb7FC_Cr7yGsTQFHxMQXc',
    appId: '1:674794837429:ios:53895432029228b4d2b5fc',
    messagingSenderId: '674794837429',
    projectId: 'ecomfix',
    storageBucket: 'ecomfix.appspot.com',
    iosBundleId: 'com.example.ecomfix.RunnerTests',
  );
}
