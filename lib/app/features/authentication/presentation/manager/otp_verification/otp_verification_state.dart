part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationState extends Equatable {}

@immutable
class OtpVerificationInitial extends OtpVerificationState {
  @override
  List<Object?> get props => [];
}

@immutable
class SendOtpState extends OtpVerificationState {
  SendOtpState({
    required this.sendOtpEntity,
    required this.otpVerificationStatus,
  });

  final SendOtpEntity sendOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;

  @override
  List<Object?> get props => [
        sendOtpEntity,
        otpVerificationStatus,
      ];
}

@immutable
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
  List<Object?> get props => [
        sendOtpEntity,
        otpVerificationStatus,
        isProcessing,
      ];
}

@immutable
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
  List<Object?> get props => [
        sendOtpEntity,
        otpVerificationStatus,
        message,
        stackTrace,
        exception,
      ];
}

@immutable
class VerifyOtpState extends OtpVerificationState {
  VerifyOtpState({
    required this.verifyOtpEntity,
    required this.otpVerificationStatus,
    this.appUserEntity,
  });

  final VerifyOtpEntity verifyOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;
  final AppUserEntity? appUserEntity;

  @override
  List<Object?> get props => [
        verifyOtpEntity,
        otpVerificationStatus,
        appUserEntity,
      ];
}

@immutable
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
  List<Object?> get props => [
        verifyOtpEntity,
        otpVerificationStatus,
        isProcessing,
      ];
}

@immutable
class VerifyOtpFailedState extends OtpVerificationState {
  VerifyOtpFailedState({
    required this.verifyOtpEntity,
    required this.otpVerificationStatus,
    this.message = '',
    this.stackTrace,
    this.exception,
    this.appUserEntity,
  });

  final VerifyOtpEntity verifyOtpEntity;
  final OtpVerificationStatus otpVerificationStatus;
  final String message;
  final StackTrace? stackTrace;
  final Object? exception;
  final AppUserEntity? appUserEntity;

  @override
  List<Object?> get props => [
        verifyOtpEntity,
        otpVerificationStatus,
        message,
        stackTrace,
        exception,
        appUserEntity,
      ];
}

@immutable
class OtpTimerState extends OtpVerificationState {
  OtpTimerState({
    required this.otpTimerStatus,
    required this.otpVerificationStatus,
    this.minute = 0,
  });

  final OtpTimerStatus otpTimerStatus;
  final OtpVerificationStatus otpVerificationStatus;
  final int minute;

  @override
  List<Object?> get props => [
        otpVerificationStatus,
        otpTimerStatus,
        minute,
      ];
}

@immutable
class GetUserProfileState extends OtpVerificationState {
  GetUserProfileState({
    this.userToken = '',
    this.appUserEntity,
  });

  final String userToken;
  final AppUserEntity? appUserEntity;

  @override
  List<Object?> get props => [
        userToken,
        appUserEntity,
      ];
}

@immutable
class NavigateToApplicationPage extends OtpVerificationState {
  NavigateToApplicationPage({
    this.appUserEntity,
    this.currentStatus = 0,
  });
  final int currentStatus;
  final AppUserEntity? appUserEntity;
  @override
  @override
  List<Object?> get props => [];
}
