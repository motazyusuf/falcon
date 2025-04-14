import 'dart:convert';
import 'dart:ui';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';


class RemoteConfigAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final key = locale.languageCode;
    final box = await Hive.openBox('translations');
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      final jsonString = remoteConfig.getString(key);
      if (jsonString.isNotEmpty) {
        debugPrint("Got translation from remote config");
        await box.put(key, jsonString);
        return json.decode(jsonString);
      } else {
        debugPrint("Empty remote config");
        throw Exception();
      }
    } catch (_) {
      debugPrint("Checking cached");
      final cached = box.get(key);
      if (cached != null) {
        debugPrint("Got translation from hive");
        return json.decode(cached);
      }
      debugPrint("FallBack assets");
      final local = await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
      return json.decode(local);
    }
  }
}
