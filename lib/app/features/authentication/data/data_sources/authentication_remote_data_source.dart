import 'package:homemakers_merchant/app/features/authentication/common/constants.dart';
import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/send_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/verify_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/send_otp_entity.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/verify_otp_entity.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';

import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/network/http/base_request_model.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/base_response_model.dart';
import 'package:homemakers_merchant/core/network/http/failure/get_api_exception.dart';
import 'package:homemakers_merchant/shared/states/api_result_state.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:network_manager/network_manager.dart';

part 'authentication_data_source.dart';

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
}
