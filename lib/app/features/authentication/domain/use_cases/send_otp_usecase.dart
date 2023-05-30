import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/send_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/send_otp_entity.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_model.dart';
import 'package:homemakers_merchant/base/base_usecase.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';

class SendOtpUseCase
    extends UseCaseIO<SendOtpEntity, ResultState<SendOtpResponseModel>> {
  @override
  Future<ResultState<SendOtpResponseModel>> call(SendOtpEntity input) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
