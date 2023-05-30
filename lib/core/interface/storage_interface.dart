abstract interface class IStorageService {
  ///Method [get] signature
  ///get the [key] values
  Future<dynamic> get(String key);

  ///Method [containsKey] signature
  ///get the value using the given [key]
  Future<bool> containsKey(String key);

  ///Method [put] signature
  ///Add the given [key] and [value]
  Future<void> put(String key, dynamic value);

  ///Method [remove] signature
  ///removes the value with the given [key]
  Future<void> remove(String key);

  ///Method [clear] signature
  Future<void> clear();

  Future<void> init();

  Future<void> dispose();

  /// Loads a setting from the Theme service, stored with `key` string.
  Future<T> load<T>(String key, T defaultValue);

  /// Save a setting to the Theme service, using `key` as its storage key.
  Future<void> save<T>(String key, T value);
}
