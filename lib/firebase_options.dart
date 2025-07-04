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
    apiKey: 'AIzaSyDZ3EeiSj9HuFIcXc2ECefN7rvFD46yvb0',
    appId: '1:66999794563:web:d1b3bb2e076d580e8294b6',
    messagingSenderId: '66999794563',
    projectId: 'mindmap-19f5d',
    authDomain: 'mindmap-19f5d.firebaseapp.com',
    storageBucket: 'mindmap-19f5d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDt_uGCatyU6_M2L_5oTA_MNT620ZiE9cI',
    appId: '1:66999794563:android:475d37ed11341fd28294b6',
    messagingSenderId: '66999794563',
    projectId: 'mindmap-19f5d',
    storageBucket: 'mindmap-19f5d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAejRErMWywCJuo04quFaScxMpqi1WZCBk',
    appId: '1:66999794563:ios:c95c2cb44282b0888294b6',
    messagingSenderId: '66999794563',
    projectId: 'mindmap-19f5d',
    storageBucket: 'mindmap-19f5d.firebasestorage.app',
    iosBundleId: 'com.example.mindmap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAejRErMWywCJuo04quFaScxMpqi1WZCBk',
    appId: '1:66999794563:ios:c95c2cb44282b0888294b6',
    messagingSenderId: '66999794563',
    projectId: 'mindmap-19f5d',
    storageBucket: 'mindmap-19f5d.firebasestorage.app',
    iosBundleId: 'com.example.mindmap',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDZ3EeiSj9HuFIcXc2ECefN7rvFD46yvb0',
    appId: '1:66999794563:web:7c72bad79b87e26a8294b6',
    messagingSenderId: '66999794563',
    projectId: 'mindmap-19f5d',
    authDomain: 'mindmap-19f5d.firebaseapp.com',
    storageBucket: 'mindmap-19f5d.firebasestorage.app',
  );
}
