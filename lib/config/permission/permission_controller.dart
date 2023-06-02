import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permission_constants.dart';

class PermissionController with ChangeNotifier {
  PermissionController(this._permissionService);

  // Make the PermissionService private so it cannot be used directly.
  final IPermissionService _permissionService;

  Future<void> loadAll() async {
    _locationPermission = await _permissionService.load(
      PermissionStore.location,
      PermissionStore.defaultLocation,
    );
    _locationWhenInUsePermission = await _permissionService.load(
      PermissionStore.locationWhenInUse,
      PermissionStore.defaultLocationWhenInUse,
    );
    _cameraPermission = await _permissionService.load(
      PermissionStore.camera,
      PermissionStore.defaultCamera,
    );
  }

  Future<void> resetAllToDefaults({
    /// If false, theme mode & scheme index are not reset.
    bool resetMode = true,
    // If false, notifyListeners is not called.
    bool doNotify = true,
  }) async {
    setLocationPermission(PermissionStore.defaultLocation, false);
    setLocationWhenInUsePermission(
        PermissionStore.defaultLocationWhenInUse, false);
    setCameraPermission(PermissionStore.defaultCamera, false);
    // Only notify at end, if asked to do so, to do so is default.
    if (doNotify) notifyListeners();
  }

  late PermissionStatus _locationPermission;
  PermissionStatus get locationPermission => _locationPermission;
  void setLocationPermission(PermissionStatus value, [bool notify = true]) {
    if (value == _locationPermission) return;
    _locationPermission = value;
    if (notify) notifyListeners();
    unawaited(_permissionService.save(PermissionStore.location, value));
  }

  late PermissionStatus _locationWhenInUsePermission;
  PermissionStatus get locationWhenInUsePermission =>
      _locationWhenInUsePermission;
  void setLocationWhenInUsePermission(
    PermissionStatus value, [
    bool notify = true,
  ]) {
    if (value == _locationWhenInUsePermission) return;
    _locationWhenInUsePermission = value;
    if (notify) notifyListeners();
    unawaited(
      _permissionService.save(PermissionStore.locationWhenInUse, value),
    );
  }

  late PermissionStatus _cameraPermission;
  PermissionStatus get cameraPermission => _cameraPermission;
  void setCameraPermission(PermissionStatus value, [bool notify = true]) {
    if (value == _cameraPermission) return;
    _cameraPermission = value;
    if (notify) notifyListeners();
    unawaited(_permissionService.save(PermissionStore.location, value));
  }
}
