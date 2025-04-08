import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/app/routes/app_router.dart';
import 'package:falcon_project/core/app/routes/pages_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../config/theme/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: CoreSetup(
        appConfig: AppConfig(
          theme: ApplicationThemeManager.myAppTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: PagesRoutes.task,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
        ),
      ),
    );
  }
}
