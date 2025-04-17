import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/app/localized_app.dart';
import 'package:falcon_project/utils/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await NotificationsService().initLocalNotification();
  tz.initializeTimeZones(); // Initialize the timezone database
  // if (Platform.isIOS || Platform.isMacOS) {
  //   print("It is ios");
  //   var iosToken = await FirebaseMessaging.instance.getAPNSToken();
  //   print("iOS/macOS Token: $iosToken");
  // }
  // String? token = await NotificationsService().firebaseMessaging.getToken();
  // print("token:$token");
  await dotenv.load(fileName: '.env.dev');
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISH']!;

  runApp(LocalizedApp());
}

