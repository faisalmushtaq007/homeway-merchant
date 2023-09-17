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
    serviceLocator<AppUserEntity>()
      ..userID = _userModel.userID
      ..phoneNumber = _userModel.phoneNumber
      ..businessProfile = _userModel.businessProfile
      ..stores = _userModel.stores
      ..token = _userModel.token
      ..tokenCreationDateTime = _userModel.tokenCreationDateTime
      ..hasUserAuthenticated = _userModel.hasUserAuthenticated
      ..businessTypeEntity = _userModel.businessTypeEntity
      ..currentProfileStatus = _userModel.currentProfileStatus
      ..menus = _userModel.menus
      ..drivers = _userModel.drivers
      ..addons = _userModel.addons
      ..ratingAndReviewEntity = _userModel.ratingAndReviewEntity
      ..hasCurrentUser = _userModel.hasCurrentUser
      ..country_dial_code = _userModel.country_dial_code
      ..isoCode = _userModel.isoCode
      ..user_type = _userModel.user_type
      ..access_token = _userModel.access_token
      ..currentUserStage = _userModel.currentUserStage
      ..uid = _userModel.uid
      ..paymentBankEntity = _userModel.paymentBankEntity
      ..hasMultiplePaymentBanks = _userModel.hasMultiplePaymentBanks
      ..paymentBankEntities = _userModel.paymentBankEntities
      ..phoneNumberWithoutDialCode = _userModel.phoneNumberWithoutDialCode;
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
    unawaited(_userModelStorageService.save(GlobalApp.userAccessTokenKey, value));
  }
}
