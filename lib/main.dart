import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/app/localized_app.dart';
import 'package:falcon_project/utils/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await FirebaseApi().fcmNotifications();
  // if (Platform.isIOS || Platform.isMacOS) {
  //   print("It is ios");
  //   var iosToken = await FirebaseMessaging.instance.getAPNSToken();
  //   print("iOS/macOS Token: $iosToken");
  // }
  String? token = await FirebaseApi().firebaseMessaging.getToken();
  print("token:$token");
  runApp(LocalizedApp());
}

