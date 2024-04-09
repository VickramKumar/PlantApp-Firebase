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
    apiKey: 'AIzaSyBGJwuPNc9cAe0OnZQVxE3OTrJUATVROcA',
    appId: '1:169591346962:web:fa6b5f38591828165205cb',
    messagingSenderId: '169591346962',
    projectId: 'plantapp-2eaf9',
    authDomain: 'plantapp-2eaf9.firebaseapp.com',
    storageBucket: 'plantapp-2eaf9.appspot.com',
    measurementId: 'G-S75NRB78RR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ7dYQ5DiXoaF1bRcnAgkco5Jlfr3OV2U',
    appId: '1:169591346962:android:bbc32a547abc8fff5205cb',
    messagingSenderId: '169591346962',
    projectId: 'plantapp-2eaf9',
    storageBucket: 'plantapp-2eaf9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAw5ExYANwi_oghqbOHdIbNpR6xLz8fqeI',
    appId: '1:169591346962:ios:cadce9d50f8430d55205cb',
    messagingSenderId: '169591346962',
    projectId: 'plantapp-2eaf9',
    storageBucket: 'plantapp-2eaf9.appspot.com',
    iosBundleId: 'com.example.plantApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAw5ExYANwi_oghqbOHdIbNpR6xLz8fqeI',
    appId: '1:169591346962:ios:8edc668a72bd69855205cb',
    messagingSenderId: '169591346962',
    projectId: 'plantapp-2eaf9',
    storageBucket: 'plantapp-2eaf9.appspot.com',
    iosBundleId: 'com.example.plantApp.RunnerTests',
  );
}
