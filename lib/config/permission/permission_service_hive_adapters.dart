import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionAdapter extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 101;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

class LocationAlwaysPermissionAdapter extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 102;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

class LocationWhenInUsePermissionAdapter extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 103;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

//manageExternalStorage
//mediaLibrary
class IosManageExternalStoragePermissionAdapter
    extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 104;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

class AndroidMediaLibraryStoragePermissionAdapter
    extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 105;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

class StoragePermissionAdapter extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 106;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

class CameraPermissionAdapter extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 107;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

class PhotosPermissionAdapter extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 108;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}

class PhotosAndOnlyPermissionAdapter extends TypeAdapter<PermissionStatus> {
  @override
  PermissionStatus read(BinaryReader reader) {
    final dynamic permissionStatus = reader.read();
    return permissionStatus as PermissionStatus;
  }

  @override
  int get typeId => 109;

  @override
  void write(BinaryWriter writer, PermissionStatus obj) {
    writer.write<PermissionStatus>(obj);
  }
}
