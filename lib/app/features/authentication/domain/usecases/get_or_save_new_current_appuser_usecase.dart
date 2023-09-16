part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetOrSaveNewCurrentAppUserUseCase extends UseCaseIO<AppUserEntity, AppUserEntity> {
  @override
  Future<AppUserEntity> call(AppUserEntity input) async {
    AppUserEntity appUserEntity = input;
    final getCurrentUserResult = await serviceLocator<GetCurrentAppUserUseCase>()(
      input: input,
    );
    return await getCurrentUserResult.when(
      remote: (data, meta) async {
        if (data != null) {
          final saveCurrentUserResult = await serviceLocator<SaveAppUserUseCase>()(
            input,
          );
          return saveCurrentUserResult.when(
            remote: (data, meta) {
              appLog.d('1');
              appLog.d('get or save user local ${data?.toMap()}');
              return appUserEntity;
            },
            localDb: (data, meta) {
              appLog.d('2');
              appLog.d('get or save user local ${data?.toMap()}');
              if (data != null) {
                serviceLocator<AppUserEntity>()
                  ..userID = data.userID
                  ..phoneNumber = data.phoneNumber
                  ..businessProfile = data.businessProfile
                  ..stores = data.stores
                  ..token = data.token
                  ..tokenCreationDateTime = data.tokenCreationDateTime
                  ..hasUserAuthenticated = data.hasUserAuthenticated
                  ..businessTypeEntity = data.businessTypeEntity
                  ..currentProfileStatus = data.currentProfileStatus
                  ..menus = data.menus
                  ..drivers = data.drivers
                  ..addons = data.addons
                  ..ratingAndReviewEntity = data.ratingAndReviewEntity
                  ..hasCurrentUser = data.hasCurrentUser
                  ..country_dial_code = data.country_dial_code
                  ..isoCode = data.isoCode
                  ..user_type = data.user_type
                  ..access_token = data.access_token
                  ..currentUserStage = data.currentUserStage
                  ..uid = data.uid
                  ..paymentBankEntity = data.paymentBankEntity
                  ..hasMultiplePaymentBanks = data.hasMultiplePaymentBanks
                  ..paymentBankEntities = data.paymentBankEntities
                  ..phoneNumberWithoutDialCode = data.phoneNumberWithoutDialCode;
                appUserEntity = data;
                return data;
              } else {
                return appUserEntity;
              }
            },
            error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
              appLog.d('3');
              appLog.e('get or save user exception: $reason');
              return appUserEntity;
            },
          );
        } else {
          // failed
          appLog.d('4');
          return appUserEntity;
        }
      },
      localDb: (data, meta) async {
        if (data != null) {
          appUserEntity = data;
          appLog.d('6');
          return data;
        } else {
          final saveCurrentUserResult = await serviceLocator<SaveAppUserUseCase>()(
            input,
          );
          return saveCurrentUserResult.when(
            remote: (data, meta) {
              appLog.d('7');
              appLog.d('get or save user local ${data?.toMap()}');
              return appUserEntity;
            },
            localDb: (data, meta) {
              appLog.d('get or save user local ${data?.toMap()}');
              if (data != null) {
                serviceLocator<AppUserEntity>()
                  ..userID = data.userID
                  ..phoneNumber = data.phoneNumber
                  ..businessProfile = data.businessProfile
                  ..stores = data.stores
                  ..token = data.token
                  ..tokenCreationDateTime = data.tokenCreationDateTime
                  ..hasUserAuthenticated = data.hasUserAuthenticated
                  ..businessTypeEntity = data.businessTypeEntity
                  ..currentProfileStatus = data.currentProfileStatus
                  ..menus = data.menus
                  ..drivers = data.drivers
                  ..addons = data.addons
                  ..ratingAndReviewEntity = data.ratingAndReviewEntity
                  ..hasCurrentUser = data.hasCurrentUser
                  ..country_dial_code = data.country_dial_code
                  ..isoCode = data.isoCode
                  ..user_type = data.user_type
                  ..access_token = data.access_token
                  ..currentUserStage = data.currentUserStage
                  ..uid = data.uid
                  ..paymentBankEntity = data.paymentBankEntity
                  ..hasMultiplePaymentBanks = data.hasMultiplePaymentBanks
                  ..paymentBankEntities = data.paymentBankEntities
                  ..phoneNumberWithoutDialCode = data.phoneNumberWithoutDialCode;
                appUserEntity = data;
                appLog.d('8');
                return data;
              } else {
                appLog.d('9');
                return appUserEntity;
              }
            },
            error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
              appLog.d('10');
              appLog.e('get or save user exception: $reason');
              return appUserEntity;
            },
          );
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.d('11');
        appLog.e('get or save user exception: $reason');
        return appUserEntity;
      },
    );

    return appUserEntity;
  }
}
