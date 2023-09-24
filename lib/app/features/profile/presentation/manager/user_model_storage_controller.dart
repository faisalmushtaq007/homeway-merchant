part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UserModelStorageController with ChangeNotifier {
  UserModelStorageController(this._userModelStorageService);

  // Make the PermissionService private so it cannot be used directly.
  final IStorageService _userModelStorageService;

  Future<void> loadAll() async {
    _userModel = await _userModelStorageService.load<AppUserEntity>(
      GlobalApp.userModelKey,
      GlobalApp.defaultUserModel,
    );
    _accessToken = await _userModelStorageService.load<String>(
      GlobalApp.userAccessTokenKey,
      GlobalApp.defaultUserAccessToken,
    );
  }

  Future<void> resetAllToDefaults({
    /// If false,user model & scheme index are not reset.
    bool resetMode = true,
    // If false, notifyListeners is not called.
    bool doNotify = true,
  }) async {
    setUserModel(GlobalApp.defaultUserModel, false);
    setUserAccessToken(GlobalApp.defaultUserAccessToken, false);
    // Only notify at end, if asked to do so, to do so is default.
    if (doNotify) notifyListeners();
  }

  // Private value, getter and setter for the AppUserEntity
  late AppUserEntity _userModel;
  // Getter for the current AppUserEntity.
  AppUserEntity get userModel => _userModel;
  // Set and persist new AppUserEntity value.
  void setUserModel(AppUserEntity? value, [bool notify = true]) {
    // No work if null value passed.
    if (value == null) return;
    // Do not perform any work if new and old value are identical.
    if (value == _userModel) return;
    // Otherwise, assign new value to private property.
    _userModel = value;
    // reassign the currentUserModel to singleton AppUserEntity
    //serviceLocator<AppUserEntity>().fromJson(value.toMap());

    // Inform all listeners a change has occurred, if notify flag is true.
    if (notify) notifyListeners();
    // Persist the change to whatever storage is used with the ThemeService.
    unawaited(_userModelStorageService.save(GlobalApp.userModelKey, value));
  }

  // Private value, getter and setter for the token
  late String _accessToken;
  // Getter for the current token.
  String get accessToken => _accessToken;
  // Set and persist new AppUserEntity value.
  void setUserAccessToken(String? value, [bool notify = true]) {
    // No work if null value passed.
    if (value == null) return;
    // Do not perform any work if new and old value are identical.
    if (value == _accessToken) return;
    // Otherwise, assign new value to private property.
    _accessToken = value;
    // Update the token value
    serviceLocator<AppUserEntity>().token = value;
    serviceLocator<AppUserEntity>().access_token = value;
    // Inform all listeners a change has occurred, if notify flag is true.
    if (notify) notifyListeners();
    // Persist the change to whatever storage is used with the ThemeService.
    unawaited(
        _userModelStorageService.save(GlobalApp.userAccessTokenKey, value));
  }
}
