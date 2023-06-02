import 'package:homemakers_merchant/app/features/authentication/common/constants.dart';
import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/send_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/verify_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/send_otp_entity.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/verify_otp_entity.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_model.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/base_response_model.dart';
import 'package:homemakers_merchant/core/network/http/failure/get_api_exception.dart';
import 'package:homemakers_merchant/shared/states/api_result_state.dart';
import 'package:network_manager/network_manager.dart';

part 'authentication_data_source.dart';

class AuthenticationRemoteDataSource extends AuthenticationDataSource {
  final client = serviceLocator<INetworkManager>();

  @override
  Future<ApiResultState<UserModel>> getUserProfile({
    String userID = '',
  }) async {
    try {
      const String apiPath = AuthenticationConstants.getUserProfile;
      final response =
          await client.send<BaseResponseModel<UserModel>, UserModel>(
        apiPath,
        parseModel: BaseResponseModel<UserModel>,
        method: RequestType.GET,
      );
      if (response.data != null) {
        return ApiResultState<UserModel>.success(data: response.data!);
      } else {
        GetApiException().handleApiFailure(response.error?.model);
        return ApiResultState.failure(
          reason: GetApiException()
              .handleApiFailure(response.error?.model)
              .message
              .toString(),
        );
      }
    } catch (e) {
      return ApiResultState.failure(
        reason: GetApiException().handleHttpApiException(e).message,
      );
    }
  }

  @override
  Future<ApiResultState<SendOtpResponseModel>> sendPhoneAuthenticationOTP({
    required SendOtpEntity sendOtpEntity,
  }) async {
    try {
      const String apiPath = AuthenticationConstants.sendOtp;
      final response = await client
          .send<BaseResponseModel<SendOtpResponseModel>, SendOtpResponseModel>(
        apiPath,
        parseModel: BaseResponseModel<SendOtpResponseModel>,
        method: RequestType.GET,
      );
      if (response.data != null) {
        return ApiResultState<SendOtpResponseModel>.success(
          data: response.data!,
        );
      } else {
        GetApiException().handleApiFailure(response.error?.model);
        return ApiResultState.failure(
          reason: GetApiException()
              .handleApiFailure(response.error?.model)
              .message
              .toString(),
        );
      }
    } catch (e) {
      return ApiResultState.failure(
        reason: GetApiException().handleHttpApiException(e).message,
      );
    }
  }

  @override
  Future<ApiResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOTP({
    required VerifyOtpEntity verifyOtpEntity,
  }) async {
    try {
      const String apiPath = AuthenticationConstants.verifyOtp;
      final response = await client.send<
          BaseResponseModel<VerifyOtpResponseModel>, VerifyOtpResponseModel>(
        apiPath,
        parseModel: BaseResponseModel<VerifyOtpResponseModel>,
        method: RequestType.GET,
      );
      if (response.data != null) {
        return ApiResultState<VerifyOtpResponseModel>.success(
          data: response.data!,
        );
      } else {
        GetApiException().handleApiFailure(response.error?.model);
        return ApiResultState.failure(
          reason: GetApiException()
              .handleApiFailure(response.error?.model)
              .message
              .toString(),
        );
      }
    } catch (e) {
      return ApiResultState.failure(
        reason: GetApiException().handleHttpApiException(e).message,
      );
    }
  }
}
