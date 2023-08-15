part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class VerifyOtpUseCase extends UseCaseIO<VerifyOtpEntity, ResultState<VerifyOtpResponseModel>> {
  VerifyOtpUseCase({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;
  @override
  Future<ResultState<VerifyOtpResponseModel>> call(VerifyOtpEntity input) async {
    return await authenticationRepository.verifyPhoneAuthenticationOtp(input);
  }
}
