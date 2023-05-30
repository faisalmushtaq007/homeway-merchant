import 'package:homemakers_merchant/app/features/authentication/common/constants.dart';
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
        return ApiResultState.success(data: response.data!);
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
        reason: GetApiException().handleHttpApiException(e),
      );
    }
  }

  @override
  Future<void> sendOTP(
    String mobileNumber, {
    String dialCode = '+61',
  }) {
    const String apiPath = AuthenticationConstants.sendOtp;
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOTP(
    String mobileNumber,
    String verificationCode, {
    String dialCode = '+61',
  }) {
    const String apiPath = AuthenticationConstants.verifyOtp;
    throw UnimplementedError();
  }
}
