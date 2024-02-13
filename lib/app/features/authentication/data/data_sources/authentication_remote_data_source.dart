part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class AuthenticationRemoteDataSource extends AuthenticationDataSource {
  final client = serviceLocator<IRestApiManager>();

  @override
  Future<ApiResultState<AppUserEntity>> getUserProfile({
    String userID = '',
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<SendOtpResponseModel>> sendPhoneAuthenticationOTP({
    required SendOtpEntity sendOtpEntity,
  }) async {
    try {
      final response = await client.send(
        AuthenticationConstants.sendOtp,
        method: RequestType.POST,
        data: sendOtpEntity.toJson(),
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<SendOtpResponseModel>.success(
          data: SendOtpResponseModel.fromJson(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<SendOtpResponseModel>.failure(
          reason: GetApiException()
              .handleApiFailure(
                error?.model,
                statusCode: error?.statusCode,
              )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<SendOtpResponseModel>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOTP({
    required VerifyOtpEntity verifyOtpEntity,
  }) async {
    try {
      final response = await client.send(
        AuthenticationConstants.verifyOtp,
        method: RequestType.POST,
        data: verifyOtpEntity.toVerifyOtp(),
      );
      final result = response.data;
      if (result != null) {
        return ApiResultState<VerifyOtpResponseModel>.success(
          data: VerifyOtpResponseModel.fromJson(response.data?.data),
        );
      } else {
        return ApiResultState<VerifyOtpResponseModel>.failure(
          reason: GetApiException()
              .handleApiFailure(
                response.error?.model,
                statusCode: response.error?.statusCode,
              )
              .message
              .toString(),
          error: response.error,
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<VerifyOtpResponseModel>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<bool>> deleteAllAppUser(
      {AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAppUser(
      {required int userID, AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> editAppUser(
      {required AppUserEntity appUserEntity, required int userID}) {
    // TODO: implement editAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AppUserEntity>>> getAllAppUser() {
    // TODO: implement getAllAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> getAppUser(
      {required int userID, AppUserEntity? appUserEntity}) {
    // TODO: implement getAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> saveAppUser(
      {required AppUserEntity appUserEntity}) {
    // TODO: implement saveAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity?>> getCurrentAppUser(
      {AppUserEntity? entity}) {
    // TODO: implement getCurrentAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AppUserEntity>>> getAllAppUsersPagination(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      Map<String, dynamic> extras = const <String, dynamic>{},
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) {
    // TODO: implement getAllAppUsersPagination
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AppUserEntity>>> saveAllAppUsers(
      {required List<AppUserEntity> appUsers, bool hasUpdateAll = false}) {
    // TODO: implement saveAllAppUsers
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AuthenticationStatusModel>> getCurrentUserStatus() async{
    try {
      final response = await client.send(
        AuthenticationConstants.getUserStatus,
        method: RequestType.GET,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<AuthenticationStatusModel>.success(
          data: AuthenticationStatusModel.fromMap(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<AuthenticationStatusModel>.failure(
          reason: GetApiException()
              .handleApiFailure(
            error?.model,
            statusCode: error?.statusCode,
          )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<AuthenticationStatusModel>.failure(
        reason:
        GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<String>> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }
}
