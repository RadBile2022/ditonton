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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDB0UYJRp4VEltJ3O3AC_gZBKB2OkzeWII',
    appId: '1:691029100881:web:81f1112167bf045ac3eb70',
    messagingSenderId: '691029100881',
    projectId: 'ditonton-1',
    authDomain: 'ditonton-1.firebaseapp.com',
    storageBucket: 'ditonton-1.appspot.com',
    measurementId: 'G-4NPKBZDHEN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAQ4PXR7sPjd0hUIep7HpvEmM2CjQMBs4',
    appId: '1:691029100881:android:dd30aed0fa8b184ec3eb70',
    messagingSenderId: '691029100881',
    projectId: 'ditonton-1',
    storageBucket: 'ditonton-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7pFAyZ07Et-bFMfgu929VZ5i-Ed0VLQc',
    appId: '1:691029100881:ios:bf762b7458e87336c3eb70',
    messagingSenderId: '691029100881',
    projectId: 'ditonton-1',
    storageBucket: 'ditonton-1.appspot.com',
    iosBundleId: 'com.example.ditonton',
  );
}