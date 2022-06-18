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
    apiKey: 'AIzaSyA-3oXlq-6fscTuA1fLz1ujaxJVcIDNmVg',
    appId: '1:11083898264:web:bdebb06e1410fbffeadfed',
    messagingSenderId: '11083898264',
    projectId: 'threep-1c9e4',
    authDomain: 'threep-1c9e4.firebaseapp.com',
    storageBucket: 'threep-1c9e4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDI9NTAcdgpHwvM7XGA6Lr27tQTV0HWWtg',
    appId: '1:11083898264:android:ac6ea22d7a5e4acceadfed',
    messagingSenderId: '11083898264',
    projectId: 'threep-1c9e4',
    storageBucket: 'threep-1c9e4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4TFc2AUt-ePhsqD5qsj1JVZ__kBkLiBc',
    appId: '1:11083898264:ios:8560415b75f65c00eadfed',
    messagingSenderId: '11083898264',
    projectId: 'threep-1c9e4',
    storageBucket: 'threep-1c9e4.appspot.com',
    iosClientId: '11083898264-mh8a2qi3u7tbfrkpaj4s306vujr37teh.apps.googleusercontent.com',
    iosBundleId: 'com.example.fireNotes',
  );
}
