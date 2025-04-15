import 'package:falcon_project/modules/analytics/import/analytics_module_import.dart';
import 'package:falcon_project/modules/main_layout/widget/my_bottom_bar.dart';
import 'package:falcon_project/modules/members/import/members_module_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '../../core/app/routes/pages_routes.dart';
import '../../core/config/ui/assets.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  MembersModuleBloc membersBloc = MembersModuleBloc();

  bool get isAnalyticsScreenActive => currentIndex == 1;

  List<Widget> get modules => [
    AllMembersScreen(key: allMembersKey, bloc: membersBloc),
    // Always stays alive
    isAnalyticsScreenActive
        ? AnalyticsScreen(
          bloc: AnalyticsModuleBloc(MembersModuleBloc.allMembers),
        )
        : const SizedBox.shrink(),
    // Released when not active
  ];

  final GlobalKey<AllMembersScreenState> allMembersKey =
      GlobalKey<AllMembersScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70.h,
        title: CircleAvatar(
          radius: 45.r,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(AppAssets.logo), // Replace with your logo
        ),
        centerTitle: true,
      ),
      body: IndexedStack(index: currentIndex, children: modules),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        onPressed: () async {
          debugPrint("Taped");
          // Initialize timezone (ensure this is also done once in main())
          tz.initializeTimeZones();
          final String timeZoneName = 'Africa/Cairo';
          final tz.Location cairoTimeZone = tz.getLocation(timeZoneName);

          final tz.TZDateTime nowCairo = tz.TZDateTime.now(cairoTimeZone);
          final tz.TZDateTime scheduledDate = nowCairo.add(
            const Duration(seconds: 5),
          );

          const AndroidNotificationDetails androidNotificationDetails =
              AndroidNotificationDetails(
                "falconProject",
                "channelName",
                importance: Importance.max,
                priority: Priority.high,
                icon: 'ic_stat_falcon_logo',
              );

          const DarwinNotificationDetails iOSNotificationDetails =
              DarwinNotificationDetails(
                presentSound: true,
                presentAlert: true,
                presentBadge: true,
              );

          const NotificationDetails notificationDetails = NotificationDetails(
            android: androidNotificationDetails,
            iOS: iOSNotificationDetails,
          );

          const UILocalNotificationDateInterpretation
          uiLocalNotificationDateInterpretation =
              UILocalNotificationDateInterpretation.absoluteTime;

          await FlutterLocalNotificationsPlugin().zonedSchedule(
            0,
            "title",
            "body",
            scheduledDate,
            notificationDetails,
            uiLocalNotificationDateInterpretation:
                uiLocalNotificationDateInterpretation,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            // Use inexact mode
            payload: 'on_tap_scheduled_payload',
          );

          print(
            'Notification scheduled for: $scheduledDate (Cairo Time) on tap',
          );
          // await FlutterLocalNotificationsPlugin().show(1, "title", "body", notificationDetails);
        },

        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyBottomBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
      ),
    );
  }
}

// actions: [
//   InkWell(
// splashColor: Colors.transparent,
// highlightColor: Colors.transparent,
//     onTap: () {
//       Locale currentLocale = context.locale;
//       Locale newLocale =
//           currentLocale.languageCode == 'en'
//               ? Locale('ar')
//               : Locale('en');
//       EasyLocalization.of(context)!.setLocale(newLocale);
//     },
//     child: Padding(
//       padding: EdgeInsets.all(8.w),
//       child: Icon(Icons.language, size: 25.r, color: context.colorScheme.secondaryContainer,),
//     ),
//   ),
// ],
//-------------------------------------------
// {
//   int? result = await context.pushNamed(PagesRoutes.addMember);
//   if(result!=null){
//     print(">>>>>>>>>>>>>>>$result<<<<<<<<<<<<<<");
//     setState(() {
//       currentIndex = result;
//     });
//     allMembersKey.currentState?.triggerLocalSetState();
//   }
// }
