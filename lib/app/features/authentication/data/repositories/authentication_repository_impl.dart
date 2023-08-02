part of 'package:homemakers_merchant/app/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplement implements AuthenticationRepository {
  AuthenticationRepositoryImplement({required this.authenticationDataSource});

  final AuthenticationDataSource authenticationDataSource;

  @override
  Future<ResultState<SendOtpResponseModel>> sendPhoneAuthenticationOtp(SendOtpEntity sendOtpEntity) async {
    final response = await authenticationDataSource.sendPhoneAuthenticationOTP(
      sendOtpEntity: BaseRequestModel<SendOtpEntity>(data: sendOtpEntity),
    );
    return response.when(
      success: (data) {
        return ResultState<SendOtpResponseModel>.success(data: data);
      },
      failure: (reason, error, exception, stackTrace) {
        return ResultState.error(
          reason: reason,
          error: error,
          stackTrace: stackTrace,
          networkException: exception,
        );
      },
    );
  }

  @override
  Future<ResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOtp(VerifyOtpEntity verifyOtpEntity) async {
    final response = await authenticationDataSource.verifyPhoneAuthenticationOTP(
      verifyOtpEntity: BaseRequestModel<VerifyOtpEntity>(data: verifyOtpEntity),
    );
    return response.when(
      success: (data) {
        return ResultState<VerifyOtpResponseModel>.success(data: data);
      },
      failure: (reason, error, exception, stackTrace) {
        return ResultState.error(
          reason: reason,
          error: error,
          stackTrace: stackTrace,
          networkException: exception,
        );
      },
    );
  }
}
