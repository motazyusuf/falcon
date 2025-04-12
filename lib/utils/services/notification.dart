import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../helper/helper.dart';


class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  final bool _localNotificationIsInitialized = false;

  get localNotificationIsInitialized => _localNotificationIsInitialized;

  Future<void> fcmNotifications() async {
    FirebaseMessaging.onBackgroundMessage(AppHelper.backgroundHandler);
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationPlugin.show(message.ttl ?? 0, message.notification!.title,
          message.notification!.body, localNotificationDetails());
    });
  }

// local notification
  Future<void> initLocalNotification() async {
    if (_localNotificationIsInitialized) return;

    const initAndroid = AndroidInitializationSettings('ic_stat_falcon_logo');
    const initIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    const initSettings =
    InitializationSettings(android: initAndroid, iOS: initIOS);

    await notificationPlugin.initialize(initSettings);
  }

  localNotificationDetails() {
    return const NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          "falcon_project",
          "channelName",
          importance: Importance.max,
          priority: Priority.high,
          icon: 'ic_stat_falcon_logo',
        ));
  }
}
