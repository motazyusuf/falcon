import 'package:app_links/app_links.dart';
import 'package:falcon_project/core/app/localized_app.dart';
import 'package:falcon_project/utils/helper/helper.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppHelper.appInit();
  final appLinks = AppLinks();
  AppHelper.deepLinkListener(appLinks);
  final initialUri = await appLinks.getInitialLink();
  runApp(LocalizedApp(initRoute: initialUri?.path,));
}
