part of 'authentication_remote_data_source.dart';

abstract class AuthenticationDataSource {
  Future<ApiResultState<SendOtpResponseModel>> sendPhoneAuthenticationOTP({required SendOtpEntity sendOtpEntity});

  Future<ApiResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOTP({required VerifyOtpEntity verifyOtpEntity});

  Future<ApiResultState<AppUserEntity>> getUserProfile({String userID = ''});
}
