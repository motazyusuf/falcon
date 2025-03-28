import 'package:falcon_project/core/routes/pages_routes.dart';
import 'package:falcon_project/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

import '../../modules/members/import/members_module_import.dart';
import '../../splash.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => Splash(),
          settings: settings,
        );
      case PagesRoutes.home:
        return MaterialPageRoute(
          builder: (context) => MembersModuleScreen(bloc: MembersModuleBloc()),
          settings: settings,
        );
      case PagesRoutes.mainLayout:
        return MaterialPageRoute(
          builder: (context) => MainLayout(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (context) => const Placeholder());
    }
  }
}
