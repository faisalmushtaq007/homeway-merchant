import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/language_service_hive_adapter.dart';
import 'package:homemakers_merchant/utils/app_data_dir/app_data_dir.dart';

class LanguageServiceHive implements ILanguageService {
  LanguageServiceHive(this.boxName);

  final String boxName;
  late final Box<dynamic> _hiveBox;

  Box<dynamic> get hiveBox => _hiveBox;

  @override
  Future<void> init() async {
    registerHiveAdapters();
    final String appDataDir = await getAppDataDir();
    if (kDebugMode) {
      debugPrint(
          'Hive using storage path: $appDataDir and file name: $boxName');
    }
    Hive.init(appDataDir);
    await Hive.openBox<dynamic>(boxName);
    _hiveBox = Hive.box<dynamic>(boxName);
    /*if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<SaveTranslationObject>(boxName);
    }*/
  }

  void registerHiveAdapters() {
    Hive.registerAdapter(LanguageAdapter());
    if (!Hive.isAdapterRegistered(206)) {
      Hive.registerAdapter(SaveTranslationObjectAdapter());
    }
  }

  @override
  Future<T> load<T>(String key, T defaultValue) async {
    try {
      final T loaded = _hiveBox.get(key, defaultValue: defaultValue) as T;
      if (kDebugMode) {
        debugPrint('Hive type   : $key as ${defaultValue.runtimeType}');
        debugPrint('Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return loaded;
    } catch (e) {
      debugPrint('Hive load (get) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' defaultValue ....... : $defaultValue');
      // If something goes wrong we return the default value.
      return defaultValue;
    }
  }

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      await _hiveBox.put(key, value);
      if (kDebugMode) {
        debugPrint('Permission Hive type   : $key as ${value.runtimeType}');
        debugPrint('Permission Hive saved  : $key as $value');
      }
    } catch (e) {
      debugPrint('Permission Hive save (put) ERROR');
      debugPrint(' Permission Error message ...... : $e');
      debugPrint(' Permission Store key .......... : $key');
      debugPrint(' Permission Save value ......... : $value');
    }
  }
}
