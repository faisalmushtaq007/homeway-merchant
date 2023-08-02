import 'package:homemakers_merchant/app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/send_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/verify_otp_response_model.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/send_otp_entity.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/verify_otp_entity.dart';
import 'package:homemakers_merchant/core/network/http/base_request_model.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';
import 'package:network_manager/network_manager.dart';

part 'package:homemakers_merchant/app/features/authentication/data/repositories/authentication_repository_impl.dart';

abstract interface class AuthenticationRepository {
  Future<ResultState<SendOtpResponseModel>> sendPhoneAuthenticationOtp(
    SendOtpEntity sendOtpEntity,
  );

  Future<ResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOtp(
    VerifyOtpEntity verifyOtpEntity,
  );
}
