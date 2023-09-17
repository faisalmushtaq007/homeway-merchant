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

  Future<ApiResultState<List<AppUserEntity>>> saveAllAppUsers({
    required List<AppUserEntity> appUsers,
    bool hasUpdateAll = false,
  });

  Future<ApiResultState<List<AppUserEntity>>> getAllAppUsersPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
}
