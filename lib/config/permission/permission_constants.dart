import 'package:permission_handler/permission_handler.dart';

class PermissionStore {
  static String buttonTextDefault = 'Allow';
  static String buttonTextSuccess = 'Continue';
  static String buttonTextPermanentlyDenied = 'Settings';
  static String titleDefault = 'Permission Needed';
  static String displayMessageDefault =
      'To serve you the best user experience we need few permission. Please allow it.';
  static String displayMessageSuccess =
      'Success, all permissions are granted. Please click the below button to continue.';
  static String displayMessageDenied =
      'To serve you the best user experience we need few permission but it seems like you denied.';
  static String displayMessagePermanentlyDenied =
      'To serve you the best user experience we need few permission but it seems like you permanently denied it. Please goto settings and enable it manually to proceed further.';

/*  static List<Permission> permissionList = [
    Permission.storage,
    Permission.camera,
    Permission.locationWhenInUse
  ];*/
// Key used to read and save the location value.
  static const String location = 'location';
  // Default value for the location, also used to reset settings.
  static const PermissionStatus defaultLocation = PermissionStatus.denied;

  //Location when in use
  static const String locationWhenInUse = 'locationWhenInUse';
  static const PermissionStatus defaultLocationWhenInUse =
      PermissionStatus.denied;

  static const String camera = 'camera';
  static const PermissionStatus defaultCamera = PermissionStatus.denied;

  static const String storage = 'storage';
  static const PermissionStatus defaultStorage = PermissionStatus.denied;

  static const String writeExternalStorage = 'writeExternalStorage';
  static const PermissionStatus defaultWriteExternalStorage =
      PermissionStatus.denied;

  static const String readExternalStorage = 'readExternalStorage';
  static const PermissionStatus defaultReadExternalStorage =
      PermissionStatus.denied;

  static const String gallery = 'gallery';
  static const PermissionStatus defaultGallery = PermissionStatus.denied;

  static const String photos = 'photos';
  static const PermissionStatus defaultPhotos = PermissionStatus.denied;
}
