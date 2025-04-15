import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/config/translations/remote_config_asset_loader.dart';
import 'package:flutter/material.dart';
import 'app.dart';

class LocalizedApp extends StatelessWidget {
  const LocalizedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/languages',
      supportedLocales: [Locale('en'), Locale('ar')],
      assetLoader: RemoteConfigAssetLoader(),
      child: MyApp(),
    );
  }
}
