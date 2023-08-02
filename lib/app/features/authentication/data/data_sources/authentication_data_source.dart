part of 'authentication_remote_data_source.dart';

abstract class AuthenticationDataSource {
  Future<ApiResultState<SendOtpResponseModel>> sendPhoneAuthenticationOTP({required BaseRequestModel<SendOtpEntity> sendOtpEntity});

  Future<ApiResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOTP({required BaseRequestModel<VerifyOtpEntity> verifyOtpEntity});

  Future<ApiResultState<AppUserEntity>> getUserProfile({String userID = ''});
}
