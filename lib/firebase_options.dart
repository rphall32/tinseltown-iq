// Firebase configuration file for Tinseltown IQ
// Generated configuration - update with your Firebase project credentials
//
// To get these values:
// 1. Go to Firebase Console: https://console.firebase.google.com/
// 2. Select your project (or create a new one)
// 3. Go to Project Settings > General
// 4. Scroll down to "Your apps" section
// 5. Add Web app and/or Android app to get the configuration values

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default Firebase configuration options for the current platform.
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

  // ═══════════════════════════════════════════════════════════════
  // FIREBASE WEB CONFIGURATION
  // Update these values from Firebase Console > Project Settings > Web App
  // ═══════════════════════════════════════════════════════════════
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-project-id',
    authDomain: 'your-project-id.firebaseapp.com',
    storageBucket: 'your-project-id.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  // ═══════════════════════════════════════════════════════════════
  // FIREBASE ANDROID CONFIGURATION  
  // Update these values from Firebase Console > Project Settings > Android App
  // Or from google-services.json file
  // ═══════════════════════════════════════════════════════════════
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
  );

  // ═══════════════════════════════════════════════════════════════
  // FIREBASE iOS CONFIGURATION
  // Update these values from Firebase Console > Project Settings > iOS App
  // Or from GoogleService-Info.plist file
  // ═══════════════════════════════════════════════════════════════
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
    iosBundleId: 'com.tinseltowniq.film',
  );

  // ═══════════════════════════════════════════════════════════════
  // FIREBASE macOS CONFIGURATION
  // ═══════════════════════════════════════════════════════════════
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
    iosBundleId: 'com.tinseltowniq.film',
  );

  // ═══════════════════════════════════════════════════════════════
  // FIREBASE Windows CONFIGURATION
  // ═══════════════════════════════════════════════════════════════
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'YOUR_WINDOWS_API_KEY',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-project-id',
    authDomain: 'your-project-id.firebaseapp.com',
    storageBucket: 'your-project-id.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  // ═══════════════════════════════════════════════════════════════
  // CONFIGURATION STATUS CHECK
  // ═══════════════════════════════════════════════════════════════
  
  /// Returns true if Firebase is properly configured (not using placeholder values)
  static bool get isConfigured {
    final options = currentPlatform;
    return options.apiKey != 'YOUR_WEB_API_KEY' &&
           options.apiKey != 'YOUR_ANDROID_API_KEY' &&
           options.apiKey != 'YOUR_IOS_API_KEY' &&
           options.projectId != 'your-project-id';
  }
}
