import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/verify_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/verify_otp_entity.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/repositories/authentication_repository.dart';

import 'package:homemakers_merchant/base/base_usecase.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';

class VerifyOtpUseCase extends UseCaseIO<VerifyOtpEntity, ResultState<VerifyOtpResponseModel>> {
  VerifyOtpUseCase({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;
  @override
  Future<ResultState<VerifyOtpResponseModel>> call(VerifyOtpEntity input) async {
    return await authenticationRepository.verifyPhoneAuthenticationOtp(input);
  }
}
