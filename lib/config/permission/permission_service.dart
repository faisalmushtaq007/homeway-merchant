// Abstract interface for the PermissionService used to read and save theme
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/config/permission/permission_service_hive_adapters.dart';
import 'package:homemakers_merchant/utils/app_data_dir/app_data_dir.dart';
import 'package:homemakers_merchant/utils/universal_platform/src/universal_platform.dart';
import 'package:location/location.dart' as loc;
import 'package:open_settings_plus/android/open_settings_plus_android.dart';
import 'package:open_settings_plus/ios/open_settings_plus_ios.dart';
import 'package:permission_handler/permission_handler.dart';

/// properties.
abstract interface class IPermissionService {
  final OpenSettingsPlusIOS settingsiOS = OpenSettingsPlusIOS();
  final OpenSettingsPlusAndroid settingsAndroid = OpenSettingsPlusAndroid();

  /// PermissionService implementations may override this method to perform needed
  /// initialization and setup work.
  Future<void> init();

  /// Loads a setting from the Theme service, stored with `key` string.
  Future<PermissionStatus> load(
    String key,
    PermissionStatus defaultValue,
  );

  /// Save a setting to the Theme service, using `key` as its storage key.
  Future<void> save(
    String key,
    PermissionStatus value,
  );

  /// Request permission
  Future<(Permission key, PermissionStatus value)> requestPermission(
    Permission key,
  );

  Future<(Permission key, PermissionStatus value)> checkPermission(
    Permission key,
  );

  Future<Map<Permission, PermissionStatus>> checkAllPermission(
    Map<Permission, PermissionStatus> allPermissions,
  );

  Future<Map<Permission, PermissionStatus>> requestAllPermission(
    Map<Permission, PermissionStatus> allPermissions,
  );

  /// Open App setting
  Future<void> openAppSetting({
    FutureOr<dynamic> Function(OpenSettingsPlusAndroid openSettingsPlusAndroid)?
        androidBuilder,
    FutureOr<dynamic> Function(OpenSettingsPlusIOS openSettingsPlusIOS)?
        iOSBuilder,
    FutureOr<dynamic> Function()? builder,
  });

  /// Request location service
  Future<bool> requestLocationService();
}

// Debug
const bool _debug = !kReleaseMode && true;

// Permission service Implement
class PermissionServiceHive implements IPermissionService {
  PermissionServiceHive(this.boxName);

  final String boxName;
  late final Box<dynamic> _hiveBox;

  @override
  Future<void> init() async {
    registerHiveAdapters();
    final String appDataDir = await getAppDataDir();
    if (_debug) {
      log('Permission Hive using storage path: $appDataDir and file name: $boxName');
    }
    // Init the Hive box box giving it the platform usable folder.
    Hive.init(appDataDir);
    // Open the Hive box with passed in name, we just keep it open all the
    // time in this demo app.
    await Hive.openBox<dynamic>(boxName);
    // Assign the box to our instance.
    _hiveBox = Hive.box<dynamic>(boxName);
  }

  // Register all custom Hive data adapters.
  void registerHiveAdapters() {
    Hive.registerAdapter(LocationPermissionAdapter());
    Hive.registerAdapter(LocationAlwaysPermissionAdapter());
    Hive.registerAdapter(LocationWhenInUsePermissionAdapter());
    Hive.registerAdapter(IosManageExternalStoragePermissionAdapter());
    Hive.registerAdapter(AndroidMediaLibraryStoragePermissionAdapter());
    Hive.registerAdapter(StoragePermissionAdapter());
    Hive.registerAdapter(CameraPermissionAdapter());
    Hive.registerAdapter(PhotosPermissionAdapter());
    Hive.registerAdapter(PhotosAndOnlyPermissionAdapter());
  }

  @override
  Future<PermissionStatus> load(
    String key,
    PermissionStatus defaultValue,
  ) {
    try {
      final PermissionStatus loaded =
          _hiveBox.get(key, defaultValue: defaultValue) as PermissionStatus;
      if (_debug) {
        log('Permission Hive type   : $key as ${defaultValue.runtimeType}');
        log('Permission Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return Future.value(loaded);
    } catch (e) {
      log('Permission Hive load (get) ERROR');
      log('Permission Error message ...... : $e');
      log('Permission Store key .......... : $key');
      log('Permission defaultValue ....... : $defaultValue');
      // If something goes wrong we return the default value.
      return Future.value(defaultValue);
    }
  }

  @override
  Future<void> openAppSetting({
    FutureOr<dynamic> Function(OpenSettingsPlusAndroid openSettingsPlusAndroid)?
        androidBuilder,
    FutureOr<dynamic> Function(OpenSettingsPlusIOS openSettingsPlusIOS)?
        iOSBuilder,
    FutureOr<dynamic> Function()? builder,
  }) async {
    if (UniversalPlatform.isAndroid) {
      return await androidBuilder!(settingsAndroid);
    } else if (UniversalPlatform.isIOS) {
      return await iOSBuilder!(settingsiOS);
    }
    return await builder!();
  }

  @override
  Future<bool> requestLocationService() async {
    final loc.Location location = loc.Location();
    final bool serviceEnabledStatus = await location.serviceEnabled();
    if (!serviceEnabledStatus) {
      final bool requestServiceStatus = await location.requestService();
      if (!requestServiceStatus) {
        return false;
      }
      return true;
    }
    return true;
  }

  @override
  Future<(Permission key, PermissionStatus value)> requestPermission(
    Permission key,
  ) async {
    final status = await key.request();
    if (status.isGranted) {
      return (key, PermissionStatus.granted);
      //Store the status
    }
    return (key, status);
  }

  @override
  Future<(Permission, PermissionStatus)> checkPermission(
    Permission key,
  ) async {
    final status = await key.status;
    if (status.isGranted) {
      return (key, PermissionStatus.granted);
    } else if (status.isDenied &&
        UniversalPlatform.isAndroid &&
        await key.shouldShowRequestRationale) {
      final (Permission, PermissionStatus) rationalePermissionStatus =
          await requestPermission(key);
      if (rationalePermissionStatus.$2 case PermissionStatus.granted) {
        return (key, PermissionStatus.granted);
      } else {
        return (key, rationalePermissionStatus.$2);
      }
    } else if (status.isDenied) {
      // Request permission for android
      final (Permission, PermissionStatus) permissionStatus =
          await requestPermission(key);
      /*if (permissionStatus.$2 case PermissionStatus.denied) {
        if (UniversalPlatform.isAndroid &&
            await key.shouldShowRequestRationale) {
          log('Service permission shouldShowRequestRationale');
          final (Permission, PermissionStatus) rationalePermissionStatus =
              await requestPermission(key);
          if (rationalePermissionStatus.$2 case PermissionStatus.granted) {
            return (key, PermissionStatus.granted);
          } else {
            return (key, status);
          }
        } else {
          return (key, status);
        }
      }*/
      return (key, permissionStatus.$2);
    } else if (status.isPermanentlyDenied) {
      // User degrade
      return (key, PermissionStatus.permanentlyDenied);
    } else if (status.isRestricted) {
      // OS restrictions
      return (key, PermissionStatus.restricted);
    } else if (status.isLimited) {
      //limited use of the resource is granted.
      return (key, PermissionStatus.limited);
    }
    return (key, status);
  }

  @override
  Future<void> save(String key, PermissionStatus value) async {
    try {
      await _hiveBox.put(key, value);
      if (_debug) {
        log('Permission Hive type   : $key as ${value.runtimeType}');
        log('Permission Hive saved  : $key as $value');
      }
    } catch (e) {
      log('Permission Hive save (put) ERROR');
      log(' Permission Error message ...... : $e');
      log(' Permission Store key .......... : $key');
      log(' Permission Save value ......... : $value');
    }
  }

  @override
  Future<Map<Permission, PermissionStatus>> checkAllPermission(
    Map<Permission, PermissionStatus> allPermissions,
  ) {
    // TODO(prasant): implement checkAllPermission
    throw UnimplementedError();
  }

  @override
  Future<Map<Permission, PermissionStatus>> requestAllPermission(
    Map<Permission, PermissionStatus> allPermissions,
  ) {
    // TODO(prasant): implement requestAllPermission
    throw UnimplementedError();
  }

  @override
  // TODO(prasant): implement settingsAndroid
  OpenSettingsPlusAndroid get settingsAndroid => OpenSettingsPlusAndroid();

  @override
  // TODO(prasant): implement settingsiOS
  OpenSettingsPlusIOS get settingsiOS => throw OpenSettingsPlusIOS();
}
