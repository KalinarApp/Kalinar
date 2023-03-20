import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode || Platform.isWindows) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(false);
  }

  FirebaseUIAuth.configureProviders([GoogleProvider(clientId: "718959006853-ena00d420kfimet6gj1dsf72f026jui6.apps.googleusercontent.com")]);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  ErrorWidget.builder = (FlutterErrorDetails error) {
    Zone.current.handleUncaughtError(error.exception, error.stack!);
    return ErrorWidget(error.exception);
  };
}

Future _firebaseMessagingBackgroundMessage(RemoteMessage message) async {}

Future initializeMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
      alert: true, announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundMessage);
}
