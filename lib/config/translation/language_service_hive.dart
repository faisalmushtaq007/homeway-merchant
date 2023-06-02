import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
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
      log('Language Hive using storage path: $appDataDir and file name: $boxName');
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
    Hive.registerAdapter(SourceLanguageAdapter());
    Hive.registerAdapter(TargetLanguageAdapter());
  }

  @override
  Future<T> load<T>(String key, T defaultValue) async {
    try {
      final T loaded = _hiveBox.get(key, defaultValue: defaultValue) as T;
      if (kDebugMode) {
        log('Language Hive type   : $key as ${defaultValue.runtimeType}');
        log('Language Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return loaded;
    } catch (e) {
      log('Language Hive load (get) ERROR');
      log('Language Error message ...... : $e');
      log('Language Store key .......... : $key');
      log('Language defaultValue ....... : $defaultValue');
      // If something goes wrong we return the default value.
      return defaultValue;
    }
  }

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      await _hiveBox.put(key, value);
      if (kDebugMode) {
        log('Language Hive type   : $key as ${value.runtimeType}');
        log('Language Hive saved  : $key as $value');
      }
    } catch (e) {
      log('Language Hive save (put) ERROR');
      log('Language Error message ...... : $e');
      log('Language Store key .......... : $key');
      log('Language Save value ......... : $value');
    }
  }
}
