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
    apiKey: 'AIzaSyDMY0xStcH5YfBWtZaeDrLX0UPV_z628uI',
    appId: '1:105930140028:web:f7c3654ee8ab97ac541cf9',
    messagingSenderId: '105930140028',
    projectId: 'fooddelivery-d55e8',
    authDomain: 'fooddelivery-d55e8.firebaseapp.com',
    storageBucket: 'fooddelivery-d55e8.appspot.com',
    measurementId: 'G-JHZCZWSZKQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbc4ctDkB7PlO6BbMaTNvQTUskbo1ombg',
    appId: '1:105930140028:android:001a585d213bf8cd541cf9',
    messagingSenderId: '105930140028',
    projectId: 'fooddelivery-d55e8',
    storageBucket: 'fooddelivery-d55e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDJbWFXlH2ckWFdyXEbYHivYgIHqMhVU8',
    appId: '1:105930140028:ios:d0d34d5ed236201a541cf9',
    messagingSenderId: '105930140028',
    projectId: 'fooddelivery-d55e8',
    storageBucket: 'fooddelivery-d55e8.appspot.com',
    iosBundleId: 'com.example.food',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDMY0xStcH5YfBWtZaeDrLX0UPV_z628uI',
    appId: '1:105930140028:web:282c9be9a3f5a040541cf9',
    messagingSenderId: '105930140028',
    projectId: 'fooddelivery-d55e8',
    authDomain: 'fooddelivery-d55e8.firebaseapp.com',
    storageBucket: 'fooddelivery-d55e8.appspot.com',
    measurementId: 'G-TLZJMBLT8P',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDJbWFXlH2ckWFdyXEbYHivYgIHqMhVU8',
    appId: '1:105930140028:ios:d0d34d5ed236201a541cf9',
    messagingSenderId: '105930140028',
    projectId: 'fooddelivery-d55e8',
    storageBucket: 'fooddelivery-d55e8.appspot.com',
    iosBundleId: 'com.example.food',
  );

}