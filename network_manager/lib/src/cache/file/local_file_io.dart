import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:network_manager/src/interface/index.dart';
import 'package:network_manager/src/model/index.dart';
import 'package:network_manager/src/utility/json_encode_util.dart';
import 'package:path_provider/path_provider.dart';

part 'file.dart';

IFileManager createFileAdapter() => _LocalFileIO();

class _LocalFileIO extends IFileManager {
  /// The `_fileManager` variable is an instance of the `_FileManager` class. It is
  /// used to perform file-related operations such as reading and writing data to
  /// files, clearing cache directories, and removing individual cache items. It
  /// encapsulates the logic for interacting with the file system.
  final _FileManager _fileManager = _FileManager.instance;

  /// The `getUserRequestDataOnString(String key)` method is used to retrieve user
  /// request data from a file as a string. It takes a `key` parameter to identify the
  /// data to be retrieved. The method returns a `Future<String?>` which represents the
  /// user request data as a string, or `null` if the data is not found.
  @override
  Future<String?> getUserRequestDataOnString(String key) {
    return _fileManager.readOnlyKeyData(key);
  }

  /// The `writeUserRequestDataWithTime` method is responsible for writing user request data to a file
  /// with an expiration time. It takes in a `key` to identify the data, a `model` which is the data to be
  /// stored, and a `time` which is the duration until the data expires.
  @override
  Future<bool> writeUserRequestDataWithTime(
    String key,
    String model,
    Duration? time,
  ) async {
    if (time == null) {
      return false;
    } else {
      final localModel =
          LocalModel(model: model, time: DateTime.now().add(time));
      await _fileManager.writeLocalModelInFile(key, localModel);
      return true;
    }
  }

  /// The `removeUserRequestCache()` method is responsible for removing all user request
  /// cache data. It calls the `_fileManager.clearAllDirectoryItems()` method to clear all
  /// items in the cache directory. After clearing the cache, it returns `true` to indicate
  /// that the operation was successful.
  @override
  Future<bool> removeUserRequestCache(String key) async {
    await _fileManager.clearAllDirectoryItems();
    return true;
  }

  /// The `removeUserRequestSingleCache(String key)` method is responsible for removing a
  /// single user request cache data. It takes a `key` parameter to identify the data to be
  /// removed.
  @override
  Future<bool> removeUserRequestSingleCache(String key) async {
    await _fileManager.removeSingleItem(key);
    return true;
  }
}
