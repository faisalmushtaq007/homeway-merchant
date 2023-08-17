part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetOrSaveNewCurrentAppUserUseCase extends UseCaseIO<AppUserEntity, AppUserEntity> {
  @override
  Future<AppUserEntity> call(AppUserEntity input) async {
    AppUserEntity appUserEntity = AppUserEntity();
    final getCurrentUserResult = await serviceLocator<GetCurrentAppUserUseCase>()(
      input: input,
    );
    await getCurrentUserResult.when(
      remote: (data, meta) async {
        if (data != null) {
          final saveCurrentUserResult = await serviceLocator<SaveAppUserUseCase>()(
            input,
          );
          saveCurrentUserResult.when(
            remote: (data, meta) {
              appLog.d('get or save user local ${data?.toMap()}');
            },
            localDb: (data, meta) {
              appLog.d('get or save user local ${data?.toMap()}');
              if (data != null) {
                serviceLocator<AppUserEntity>().copyWith(
                  userID: data.userID,
                  phoneNumber: data.phoneNumber,
                  businessProfile: data.businessProfile,
                  stores: data.stores,
                  token: data.token,
                  tokenCreationDateTime: data.tokenCreationDateTime,
                  hasUserAuthenticated: data.hasUserAuthenticated,
                  businessTypeEntity: data.businessTypeEntity,
                  currentProfileStatus: data.currentProfileStatus,
                  menus: data.menus,
                  drivers: data.drivers,
                  addons: data.addons,
                  ratingAndReviewEntity: data.ratingAndReviewEntity,
                  hasCurrentUser: data.hasCurrentUser,
                  country_dial_code: data.country_dial_code,
                  isoCode: data.isoCode,
                  user_type: data.user_type,
                );
                appUserEntity = data;
              }
            },
            error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
              appLog.e('get or save user exception: $reason');
            },
          );
          appUserEntity = data;
        } else {
          // failed
        }
      },
      localDb: (data, meta) async {
        if (data != null) {
          appUserEntity = data;
        } else {
          final saveCurrentUserResult = await serviceLocator<SaveAppUserUseCase>()(
            input,
          );
          saveCurrentUserResult.when(
            remote: (data, meta) {
              appLog.d('get or save user local ${data?.toMap()}');
            },
            localDb: (data, meta) {
              appLog.d('get or save user local ${data?.toMap()}');
              if (data != null) {
                serviceLocator<AppUserEntity>().copyWith(
                  userID: data.userID,
                  phoneNumber: data.phoneNumber,
                  businessProfile: data.businessProfile,
                  stores: data.stores,
                  token: data.token,
                  tokenCreationDateTime: data.tokenCreationDateTime,
                  hasUserAuthenticated: data.hasUserAuthenticated,
                  businessTypeEntity: data.businessTypeEntity,
                  currentProfileStatus: data.currentProfileStatus,
                  menus: data.menus,
                  drivers: data.drivers,
                  addons: data.addons,
                  ratingAndReviewEntity: data.ratingAndReviewEntity,
                  hasCurrentUser: data.hasCurrentUser,
                  country_dial_code: data.country_dial_code,
                  isoCode: data.isoCode,
                  user_type: data.user_type,
                );
                appUserEntity = data;
              }
            },
            error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
              appLog.e('get or save user exception: $reason');
            },
          );
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.e('get or save user exception: $reason');
      },
    );

    return appUserEntity;
  }
}
