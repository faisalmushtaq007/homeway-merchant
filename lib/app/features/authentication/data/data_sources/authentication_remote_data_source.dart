part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class AuthenticationRemoteDataSource extends AuthenticationDataSource {
  final client = serviceLocator<INetworkManager<BaseResponseErrorModel>>();

  @override
  Future<ApiResultState<AppUserEntity>> getUserProfile({
    String userID = '',
  }) async {
    try {
      const String apiPath = AuthenticationConstants.getUserProfile;
      final response = await client.send<BaseResponseModel<AppUserEntity>, AppUserEntity>(
        apiPath,
        parseModel: BaseResponseModel<AppUserEntity>(),
        method: RequestType.GET,
      );
      if (response.data != null) {
        return ApiResultState<AppUserEntity>.success(data: response.data!);
      } else {
        return ApiResultState<AppUserEntity>.failure(
          reason: GetApiException().handleApiFailure(response.error?.model).message.toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<AppUserEntity>.failure(
        reason: GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<SendOtpResponseModel>> sendPhoneAuthenticationOTP({
    required BaseRequestModel<SendOtpEntity> sendOtpEntity,
  }) async {
    try {
      const String apiPath = AuthenticationConstants.sendOtp;
      final response = await client.send<BaseResponseModel<SendOtpResponseModel>, SendOtpResponseModel>(
        apiPath,
        parseModel: BaseResponseModel<SendOtpResponseModel>(),
        method: RequestType.POST,
        data: sendOtpEntity.toJson((value) => value.toJson()),
      );
      if (response.data != null) {
        return ApiResultState<SendOtpResponseModel>.success(
          data: response.data!,
        );
      } else {
        return ApiResultState<SendOtpResponseModel>.failure(
          reason: GetApiException().handleApiFailure(response.error?.model).message.toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<SendOtpResponseModel>.failure(
        reason: GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOTP({
    required BaseRequestModel<VerifyOtpEntity> verifyOtpEntity,
  }) async {
    try {
      const String apiPath = AuthenticationConstants.verifyOtp;
      final response = await client.send<BaseResponseModel<VerifyOtpResponseModel>, VerifyOtpResponseModel>(
        apiPath,
        parseModel: BaseResponseModel<VerifyOtpResponseModel>(),
        method: RequestType.POST,
        data: verifyOtpEntity.toJson((value) => value.toJson()),
      );
      if (response.data != null) {
        return ApiResultState<VerifyOtpResponseModel>.success(
          data: response.data!,
        );
      } else {
        return ApiResultState<VerifyOtpResponseModel>.failure(
          reason: GetApiException().handleApiFailure(response.error?.model).message.toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<VerifyOtpResponseModel>.failure(
        reason: GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<bool>> deleteAllAppUser({AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAppUser({required int userID, AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> editAppUser({required AppUserEntity appUserEntity, required int userID}) {
    // TODO: implement editAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AppUserEntity>>> getAllAppUser() {
    // TODO: implement getAllAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> getAppUser({required int userID, AppUserEntity? appUserEntity}) {
    // TODO: implement getAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> saveAppUser({required AppUserEntity appUserEntity}) {
    // TODO: implement saveAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity?>> getCurrentAppUser({AppUserEntity? entity}) {
    // TODO: implement getCurrentAppUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AppUserEntity>>> getAllAppUsersPagination({int pageKey = 0, int pageSize = 10, String? searchText, Map<String, dynamic> extras = const <String, dynamic>{}, String? filtering, String? sorting, Timestamp? startTime, Timestamp? endTime}) {
    // TODO: implement getAllAppUsersPagination
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AppUserEntity>>> saveAllAppUsers({required List<AppUserEntity> appUsers, bool hasUpdateAll = false}) {
    // TODO: implement saveAllAppUsers
    throw UnimplementedError();
  }
}
