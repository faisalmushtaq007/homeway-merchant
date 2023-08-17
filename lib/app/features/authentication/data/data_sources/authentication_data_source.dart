part of 'package:homemakers_merchant/app/features/authentication/index.dart';

abstract class AuthenticationDataSource {
  Future<ApiResultState<SendOtpResponseModel>> sendPhoneAuthenticationOTP({required BaseRequestModel<SendOtpEntity> sendOtpEntity});

  Future<ApiResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOTP({required BaseRequestModel<VerifyOtpEntity> verifyOtpEntity});

  Future<ApiResultState<AppUserEntity>> getUserProfile({String userID = ''});

  Future<ApiResultState<AppUserEntity>> saveAppUser({
    required AppUserEntity appUserEntity,
  });

  Future<ApiResultState<AppUserEntity>> editAppUser({
    required AppUserEntity appUserEntity,
    required int userID,
  });

  Future<ApiResultState<bool>> deleteAppUser({
    required int userID,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<bool>> deleteAllAppUser({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<AppUserEntity>> getAppUser({
    required int userID,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<List<AppUserEntity>>> getAllAppUser();

  Future<ApiResultState<AppUserEntity?>> getCurrentAppUser({AppUserEntity? entity});
}
