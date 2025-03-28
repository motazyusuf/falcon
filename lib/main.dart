import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import 'core/routes/app_router.dart';
import 'core/routes/pages_routes.dart';
import 'modules/members/import/members_module_import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/languages',
      supportedLocales: [Locale('en'), Locale('ar')],
      fallbackLocale: Locale("en"),
      startLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: CoreSetup(
        appConfig: AppConfig(
          theme: ThemeData(
            colorScheme: MyColorScheme.falconColorScheme,
            useMaterial3: true,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: PagesRoutes.splash,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
        ),
      ),
    );
  }
}
