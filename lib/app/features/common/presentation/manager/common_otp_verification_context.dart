part of 'package:homemakers_merchant/app/features/common/index.dart';

class CommonOtpVerificationContext<T extends Object> {
  CommonOtpVerificationContext(this.commonOtpVerificationImplement);

  late ICommonOtpVerification<T> commonOtpVerificationImplement;

  void init(
      {required String existingPhoneNumber, required String newPhoneNumber}) {
    commonOtpVerificationImplement.init(existingPhoneNumber, newPhoneNumber);
  }

  Future<void> verifyOtpPhoneNumber(T bloc) async {
    await commonOtpVerificationImplement.verifyOtpPhoneNumber(bloc);
    return;
  }

  Future<void> resendOtpPhoneNumber(T bloc) async {
    await commonOtpVerificationImplement.resendOtpPhoneNumber(bloc);
    return;
  }
}
