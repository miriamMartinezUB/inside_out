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
    apiKey: 'AIzaSyAlf76XeNl-Av3RlS_wYagS3MGmmOEUoCg',
    appId: '1:1005187080907:web:8aca8dbc69f6685365f14e',
    messagingSenderId: '1005187080907',
    projectId: 'inside-out-d0bd8',
    authDomain: 'inside-out-d0bd8.firebaseapp.com',
    storageBucket: 'inside-out-d0bd8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALnSkfhi71HklirqA12PrON-SSTtbRDxc',
    appId: '1:1005187080907:android:6bdae730f7768d3b65f14e',
    messagingSenderId: '1005187080907',
    projectId: 'inside-out-d0bd8',
    storageBucket: 'inside-out-d0bd8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBq5sFsO45SiQFyB8aKRihwLpAEAK2JURY',
    appId: '1:1005187080907:ios:8efd9ecf7034bd6265f14e',
    messagingSenderId: '1005187080907',
    projectId: 'inside-out-d0bd8',
    storageBucket: 'inside-out-d0bd8.appspot.com',
    iosClientId: '1005187080907-kacqd6n3hdkbmg3ktuttjlv925a0kjpc.apps.googleusercontent.com',
    iosBundleId: 'com.miriam.insideOut',
  );
}
