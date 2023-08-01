import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/send_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/send_otp_entity.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/repositories/authentication_repository.dart';

import 'package:homemakers_merchant/base/base_usecase.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';

class SendOtpUseCase extends UseCaseIO<SendOtpEntity, ResultState<SendOtpResponseModel>> {
  SendOtpUseCase({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  @override
  Future<ResultState<SendOtpResponseModel>> call(SendOtpEntity input) async {
    return await authenticationRepository.sendPhoneAuthenticationOtp(input);
  }
}
