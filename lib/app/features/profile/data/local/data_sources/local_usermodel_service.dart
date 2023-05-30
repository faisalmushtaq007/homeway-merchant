import 'package:homemakers_merchant/app/features/profile/domain/entities/user_model.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/interface/storage_interface.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/utils/app_data_dir/app_data_dir.dart';

class LocalUserModelService implements IStorageService {
  LocalUserModelService(this.boxName);

  final String boxName;
  late final Box<dynamic> _hiveBox;

  @override
  Future<void> init() async {
    final String appDataDir = await getAppDataDir();
    log('Hive using storage path: $appDataDir and file name: $boxName');
    // Init the Hive box box giving it the platform usable folder.
    Hive.init(appDataDir);
    // Open the Hive box with passed in name, we just keep it open all the
    // time in this demo app.
    await Hive.openBox<UserModel>(boxName);
    // Assign the box to our instance.
    _hiveBox = Hive.box<UserModel>(boxName);
  }

  @override
  Future<void> clear() async {
    await _hiveBox.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _hiveBox.containsKey(key);
  }

  @override
  Future<void> dispose() async {
    await _hiveBox.clear();
  }

  @override
  Future<dynamic> get(String key) {
    dynamic response;
    if (_hiveBox.containsKey(key)) response = _hiveBox.get(key);
    return Future.value(response);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    await _hiveBox.put(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _hiveBox.delete(key);
  }

  @override
  Future<T> load<T>(String key, T defaultValue) async {
    try {
      final T loaded = _hiveBox.get(key, defaultValue: defaultValue) as T;

      if (kDebugMode) {
        log('Permission Hive type   : $key as ${defaultValue.runtimeType}');
        log('Permission Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return Future.value(loaded);
    } catch (e) {
      log('Permission Hive load (get) ERROR');
      log(' Permission Error message ...... : $e');
      log(' Permission Store key .......... : $key');
      log(' Permission defaultValue ....... : $defaultValue');
      // If something goes wrong we return the default value.
      return Future.value(defaultValue);
    }
  }

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      await _hiveBox.put(key, value);
      if (kDebugMode) {
        log('Hive type   : $key as ${value.runtimeType}');
        log('Hive saved  : $key as $value');
      }
    } catch (e) {
      log('Hive save (put) ERROR');
      log(' Error message ...... : $e');
      log(' Store key .......... : $key');
      log(' Save value ......... : $value');
    }
  }
}
