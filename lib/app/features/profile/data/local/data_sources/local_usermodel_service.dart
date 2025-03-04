part of 'package:homemakers_merchant/app/features/profile/index.dart';

class LocalUserModelService implements IStorageService {
  LocalUserModelService(this.boxName);

  final String boxName;
  late final Box<dynamic> _hiveBox;

  @override
  Future<void> init() async {
    registerHiveAdapters();
    final String appDataDir = await getAppDataDir();
    log('LocalUserModel Hive using storage path: $appDataDir and file name: $boxName');
    // Init the Hive box box giving it the platform usable folder.
    Hive.init(appDataDir);
    // Open the Hive box with passed in name, we just keep it open all the
    // time in this demo app.
    await Hive.openBox<dynamic>(boxName);
    // Assign the box to our instance.
    _hiveBox = Hive.box<dynamic>(boxName);
  }

  void registerHiveAdapters() {
    Hive.registerAdapter(LocalUserModelAdapter());
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
        log('LocalUserModel Hive type   : $key as ${defaultValue.runtimeType}');
        log('LocalUserModel Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return loaded;
    } catch (e) {
      log('LocalUserModel Hive load (get) ERROR');
      log('LocalUserModel Error message ...... : $e');
      log('LocalUserModel Store key .......... : $key');
      log('LocalUserModel defaultValue ....... : $defaultValue');
      // If something goes wrong we return the default value.
      return defaultValue;
    }
  }

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      await _hiveBox.put(key, value);
      if (kDebugMode) {
        log('LocalUserModel Hive type   : $key as ${value.runtimeType}');
        log('LocalUserModel Hive saved  : $key as $value');
      }
    } catch (e) {
      log('LocalUserModel Hive save (put) ERROR');
      log('LocalUserModel Error message ...... : $e');
      log('LocalUserModel Store key .......... : $key');
      log('LocalUserModel Save value ......... : $value');
    }
  }
}

class LocalUserModelAdapter extends TypeAdapter<AppUserEntity> {
  @override
  AppUserEntity read(BinaryReader reader) {
    var data = reader.read();
    return data as AppUserEntity;
  }

  @override
  int get typeId => 221;

  @override
  void write(BinaryWriter writer, AppUserEntity obj) {
    writer.write(obj);
  }
}
