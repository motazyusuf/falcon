import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:opticore/opticore.dart';
import 'package:path_provider/path_provider.dart';
import '../../firebase_options.dart';
import '../../modules/add_member/import/add_member_import.dart';
import '../../modules/splash/import/splash_import.dart';
import '../services/notification.dart';

abstract class AppHelper {

  static CancelFunc showCustomLoading() {
    return BotToast.showCustomLoading(
      toastBuilder: (func) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // Full-screen overlay
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/falcon_logo.png",
                    fit: BoxFit.cover,
                    height: 200.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: LinearProgressIndicator(color: Colors.red),
                  ),
                  // Custom color
                ],
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent, // Remove default overlay
      allowClick: false, // Prevent taps
    );
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "";
    }
    return null;
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    Firebase.initializeApp();
    final data = message.data;
    // AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'falcon_project',
    //   'channelName',
    //   description: 'This channel is used for important notifications.',
    //   importance: Importance.high,
    // );
    final notificationPlugin = FlutterLocalNotificationsPlugin();
    // await notificationPlugin
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    notificationPlugin.show(
      message.messageId.hashCode,
      data['title'] ?? message.notification!.title,
      data['body'] ?? message.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'falconProject',
          'channelName',
          importance: Importance.max,
          priority: Priority.high,
          icon: 'ic_stat_falcon_logo',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  static Future<void> appInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await EasyLocalization.ensureInitialized();
    await FirebaseApi().fcmNotifications();
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  static deepLinkListener(AppLinks appLinks) {
    appLinks.uriLinkStream.listen((uri) {
      debugPrint("received $uri");
      });
  }

  // static Future<String?> deepLinkInitialRoute() async {
  //   final Uri? initialUri = await appLinks.getInitialLink();
  //   return initialUri?.path;
  // }
}
