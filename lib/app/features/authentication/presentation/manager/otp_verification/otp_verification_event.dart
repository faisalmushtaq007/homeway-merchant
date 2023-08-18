part of 'otp_verification_bloc.dart';

abstract class OtpVerificationEvent with AppEquatable {}

class SendOtp extends OtpVerificationEvent {
  SendOtp({
    required this.sendOtpEntity,
    required this.otpVerificationStatus,
    this.hasOtpResend = false,
  });

  final SendOtpEntity sendOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;
  final bool hasOtpResend;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        sendOtpEntity,
        otpVerificationStatus,
        hasOtpResend,
      ];
}

class VerifyOtp extends OtpVerificationEvent {
  VerifyOtp({
    required this.verifyOtpEntity,
    required this.otpVerificationStatus,
  });

  final VerifyOtpEntity verifyOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        verifyOtpEntity,
        otpVerificationStatus,
      ];
}

class OtpTimer extends OtpVerificationEvent {
  OtpTimer({
    required this.otpTimerStatus,
    required this.otpVerificationStatus,
    this.minute = 0,
  });

  final OtpTimerStatus otpTimerStatus;
  final OtpVerificationStatus otpVerificationStatus;
  int minute;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        otpVerificationStatus,
        otpTimerStatus,
        minute,
      ];
}

class GetUserProfile extends OtpVerificationEvent {
  GetUserProfile({
    this.userToken = '',
  });

  final String userToken;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        userToken,
      ];
}
