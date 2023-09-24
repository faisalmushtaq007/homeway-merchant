part of 'package:homemakers_merchant/app/features/authentication/index.dart';

abstract interface class AuthenticationRepository {
  Future<ResultState<SendOtpResponseModel>> sendPhoneAuthenticationOtp(
    SendOtpEntity sendOtpEntity,
  );

  Future<ResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOtp(
    VerifyOtpEntity verifyOtpEntity,
  );

  Future<DataSourceState<AppUserEntity>> saveAppUser({
    required AppUserEntity appUserEntity,
  });

  Future<DataSourceState<AppUserEntity>> editAppUser({
    required AppUserEntity appUserEntity,
    required int userID,
  });

  Future<DataSourceState<bool>> deleteAppUser({
    required int userID,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deleteAllAppUser();

  Future<DataSourceState<AppUserEntity>> getAppUser({
    required int userID,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<List<AppUserEntity>>> getAllAppUser();

  Future<DataSourceState<AppUserEntity?>> getCurrentAppUser(
      {AppUserEntity? entity});

  Future<DataSourceState<List<AppUserEntity>>> getAllUsersPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<AppUserEntity>>> saveAllUsers({
    required List<AppUserEntity> appUsers,
    bool hasUpdateAll = false,
  });
}
