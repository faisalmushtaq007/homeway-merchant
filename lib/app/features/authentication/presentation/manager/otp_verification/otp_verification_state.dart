part of 'otp_verification_bloc.dart';

abstract class OtpVerificationState with AppEquatable {}

class OtpVerificationInitial extends OtpVerificationState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

class SendOtpState extends OtpVerificationState {
  SendOtpState({
    required this.sendOtpEntity,
    required this.otpVerificationStatus,
  });

  final SendOtpEntity sendOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        sendOtpEntity,
        otpVerificationStatus,
      ];
}

class SendOtpProcessingState extends OtpVerificationState {
  SendOtpProcessingState({
    required this.sendOtpEntity,
    required this.otpVerificationStatus,
    this.isProcessing = true,
  });

  final SendOtpEntity sendOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;
  final bool isProcessing;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        sendOtpEntity,
        otpVerificationStatus,
        isProcessing,
      ];
}

class SendOtpFailedState extends OtpVerificationState {
  SendOtpFailedState({
    required this.sendOtpEntity,
    required this.otpVerificationStatus,
    this.message = '',
    this.stackTrace,
    this.exception,
  });

  final SendOtpEntity sendOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;
  final String message;
  final StackTrace? stackTrace;
  final Object? exception;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        sendOtpEntity,
        otpVerificationStatus,
        message,
        stackTrace,
        exception,
      ];
}

class VerifyOtpState extends OtpVerificationState {
  VerifyOtpState({
    required this.verifyOtpEntity,
    required this.otpVerificationStatus,
  });

  final VerifyOtpEntity verifyOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        verifyOtpEntity,
        otpVerificationStatus,
      ];
}

class VerifyOtpProcessingState extends OtpVerificationState {
  VerifyOtpProcessingState({
    required this.verifyOtpEntity,
    required this.otpVerificationStatus,
    this.isProcessing = true,
  });

  final VerifyOtpEntity verifyOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;
  final bool isProcessing;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        verifyOtpEntity,
        otpVerificationStatus,
        isProcessing,
      ];
}

class VerifyOtpFailedState extends OtpVerificationState {
  VerifyOtpFailedState({
    required this.verifyOtpEntity,
    required this.otpVerificationStatus,
    this.message = '',
    this.stackTrace,
    this.exception,
  });

  final VerifyOtpEntity verifyOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;
  final String message;
  final StackTrace? stackTrace;
  final Object? exception;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        verifyOtpEntity,
        otpVerificationStatus,
        message,
        stackTrace,
        exception,
      ];
}

class OtpTimerState extends OtpVerificationState {
  OtpTimerState({
    required this.otpTimerStatus,
    required this.otpVerificationStatus,
    this.minute = 0,
  });

  final OtpTimerStatus otpTimerStatus;
  final OtpVerificationStatus otpVerificationStatus;
  int minute;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        otpVerificationStatus,
        otpTimerStatus,
        minute,
      ];
}

class GetUserProfileState extends OtpVerificationState {
  GetUserProfileState({
    this.userToken = '',
    this.appUserEntity,
  });

  final String userToken;
  final AppUserEntity? appUserEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        userToken,
        appUserEntity,
      ];
}

class NavigateToApplicationPage extends OtpVerificationState {
  NavigateToApplicationPage({
    this.appUserEntity,
    this.currentStatus = 0,
  });
  final int currentStatus;
  final AppUserEntity? appUserEntity;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];
}
