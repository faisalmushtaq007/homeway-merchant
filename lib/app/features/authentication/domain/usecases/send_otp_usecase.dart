part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendOtpUseCase extends UseCaseIO<SendOtpEntity, ResultState<SendOtpResponseModel>> {
  SendOtpUseCase({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  @override
  Future<ResultState<SendOtpResponseModel>> call(SendOtpEntity input) async {
    return await authenticationRepository.sendPhoneAuthenticationOtp(input);
  }
}
