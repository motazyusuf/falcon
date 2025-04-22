import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/utils/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../firebase_options.dart';

class AppHelper {
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

  static Future<void> scheduleExpiryNotification(
    DateTime expiryDate,
    String memberName,
    String subscriptionName,
    int id,
  ) async
  {
    final scheduledDate = tz.TZDateTime.from(
      expiryDate,
      tz.getLocation('Africa/Cairo'),
    ).add(Duration(hours: 10, minutes: 35));
    await FlutterLocalNotificationsPlugin().zonedSchedule(
      id,
      "Subscription Expiring",
      "${memberName.capitalizeFirst}\'s $subscriptionName subscription expired today!",
      scheduledDate,
      NotificationsService.localNotificationDetails(),
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'expiry_payload',
    );
    debugPrint('Notification scheduled for: $scheduledDate');
  }

  static Future<void> cancelScheduledNotification(int notificationId) async {
    await FlutterLocalNotificationsPlugin().cancel(notificationId);
  }

  static appInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await EasyLocalization.ensureInitialized();
    await NotificationsService().initLocalNotification();
    tz.initializeTimeZones(); // Initialize the timezone database
  }
}

// static Future<void> backgroundHandler(RemoteMessage message) async {
//   Firebase.initializeApp();
//   final data = message.data;
//   // AndroidNotificationChannel channel = AndroidNotificationChannel(
//   //   'falcon_project',
//   //   'channelName',
//   //   description: 'This channel is used for important notifications.',
//   //   importance: Importance.high,
//   // );
//   final notificationPlugin = FlutterLocalNotificationsPlugin();
//   // await notificationPlugin
//   //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//   //     ?.createNotificationChannel(channel);
//
//   notificationPlugin.show(
//     message.messageId.hashCode,
//     data['title'] ?? message.notification!.title,
//     data['body'] ?? message.notification!.body,
//     const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'falconProject',
//         'channelName',
//         importance: Importance.max,
//         priority: Priority.high,
//         icon: 'ic_stat_falcon_logo',
//       ),
//       iOS: DarwinNotificationDetails(),
//     ),
//   );
// }
