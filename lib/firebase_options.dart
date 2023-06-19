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
    apiKey: 'AIzaSyAWcaGI0pBcYzfKk3FC4xBdOGmV9PCXkUw',
    appId: '1:548481446524:web:eccf274548459200c30ff9',
    messagingSenderId: '548481446524',
    projectId: 'cab-management-7b661',
    authDomain: 'cab-management-7b661.firebaseapp.com',
    storageBucket: 'cab-management-7b661.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWMkbOwyj4GkHmRFGdcRz1tQRNP3Ae0tA',
    appId: '1:548481446524:android:274a387da8d807abc30ff9',
    messagingSenderId: '548481446524',
    projectId: 'cab-management-7b661',
    storageBucket: 'cab-management-7b661.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdLh6wXBSjM88ZPVVMzrTCtKcuy4jw0VI',
    appId: '1:548481446524:ios:5f84388d27a8026cc30ff9',
    messagingSenderId: '548481446524',
    projectId: 'cab-management-7b661',
    storageBucket: 'cab-management-7b661.appspot.com',
    iosClientId: '548481446524-dhgqevjs6q3969h667pqlr7dqprvbpp0.apps.googleusercontent.com',
    iosBundleId: 'com.example.cabManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDdLh6wXBSjM88ZPVVMzrTCtKcuy4jw0VI',
    appId: '1:548481446524:ios:0bcb350d378098f1c30ff9',
    messagingSenderId: '548481446524',
    projectId: 'cab-management-7b661',
    storageBucket: 'cab-management-7b661.appspot.com',
    iosClientId: '548481446524-u77ct6o9n0d9vfqe2pfams2rofncpjri.apps.googleusercontent.com',
    iosBundleId: 'com.example.cabManagement.RunnerTests',
  );
}
