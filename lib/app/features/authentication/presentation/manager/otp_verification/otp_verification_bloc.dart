import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/common/otp_verification_enum.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:meta/meta.dart';

part 'otp_verification_event.dart';

part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
  }) : super(OtpVerificationInitial()) {
    on<SendOtp>(_sendOTP);
    on<VerifyOtp>(_verifyOtp);
    on<OtpTimer>(_otpTimer);
  }

  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  FutureOr<void> _sendOTP(SendOtp event, Emitter<OtpVerificationState> emit) async {
    try {
      emit(
        SendOtpProcessingState(
          sendOtpEntity: event.sendOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.processing,
        ),
      );
      if (!event.sendOtpEntity.userName.isEmptyOrNull) {
        final ResultState<SendOtpResponseModel> resultState = await sendOtpUseCase(event.sendOtpEntity);
        emit(
          SendOtpProcessingState(
            sendOtpEntity: event.sendOtpEntity,
            otpVerificationStatus: OtpVerificationStatus.processing,
            isProcessing: false,
          ),
        );
        resultState.maybeWhen(
          orElse: () {
            emit(
              SendOtpState(sendOtpEntity: event.sendOtpEntity, otpVerificationStatus: OtpVerificationStatus.otpSending),
            );
          },
          success: (data) {
            emit(
              SendOtpState(
                sendOtpEntity: event.sendOtpEntity,
                otpVerificationStatus: (event.hasOtpResend) ? OtpVerificationStatus.otpReSent : OtpVerificationStatus.otpSent,
              ),
            );
          },
          error: (reason, error, networkException, stackTrace) {
            emit(
              SendOtpFailedState(
                sendOtpEntity: event.sendOtpEntity,
                otpVerificationStatus: OtpVerificationStatus.error,
                stackTrace: stackTrace,
                exception: error,
                message: reason,
              ),
            );
          },
        );
      } else {
        emit(
          SendOtpProcessingState(
            sendOtpEntity: event.sendOtpEntity,
            otpVerificationStatus: OtpVerificationStatus.processing,
            isProcessing: false,
          ),
        );
        emit(
          SendOtpFailedState(
            sendOtpEntity: event.sendOtpEntity,
            otpVerificationStatus: OtpVerificationStatus.failed,
            message: 'Something went wrong, please try again',
          ),
        );
      }
    } catch (e, s) {
      emit(
        SendOtpProcessingState(
          sendOtpEntity: event.sendOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.processing,
          isProcessing: false,
        ),
      );
      emit(
        SendOtpFailedState(
          sendOtpEntity: event.sendOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.error,
          stackTrace: s,
          exception: e,
          message: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _verifyOtp(VerifyOtp event, Emitter<OtpVerificationState> emit) async {
    try {
      emit(
        VerifyOtpProcessingState(
          verifyOtpEntity: event.verifyOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.processing,
        ),
      );
      if (!event.verifyOtpEntity.login.isEmptyOrNull && event.verifyOtpEntity.otp != null) {
        final ResultState<VerifyOtpResponseModel> resultState = await verifyOtpUseCase(event.verifyOtpEntity);
        emit(
          VerifyOtpProcessingState(
            verifyOtpEntity: event.verifyOtpEntity,
            otpVerificationStatus: OtpVerificationStatus.processing,
            isProcessing: false,
          ),
        );
        resultState.maybeWhen(
          orElse: () {
            emit(
              VerifyOtpState(verifyOtpEntity: event.verifyOtpEntity, otpVerificationStatus: OtpVerificationStatus.verifying),
            );
            return;
          },
          success: (data) {
            emit(
              VerifyOtpState(
                verifyOtpEntity: event.verifyOtpEntity,
                otpVerificationStatus: OtpVerificationStatus.otpVerified,
              ),
            );
            return;
          },
          error: (reason, error, networkException, stackTrace) {
            emit(
              VerifyOtpFailedState(
                verifyOtpEntity: event.verifyOtpEntity,
                otpVerificationStatus: OtpVerificationStatus.error,
                stackTrace: stackTrace,
                exception: error,
                message: reason,
              ),
            );
            return;
          },
        );
      } else {
        emit(
          VerifyOtpProcessingState(
            verifyOtpEntity: event.verifyOtpEntity,
            otpVerificationStatus: OtpVerificationStatus.processing,
            isProcessing: false,
          ),
        );
        emit(
          VerifyOtpFailedState(
            verifyOtpEntity: event.verifyOtpEntity,
            otpVerificationStatus: OtpVerificationStatus.failed,
            message: 'Either phone number or otp is invalid, please try again',
          ),
        );
      }
    } catch (e, s) {
      emit(
        VerifyOtpProcessingState(
          verifyOtpEntity: event.verifyOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.processing,
          isProcessing: false,
        ),
      );
      emit(
        VerifyOtpFailedState(
          verifyOtpEntity: event.verifyOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.error,
          stackTrace: s,
          exception: e,
          message: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _otpTimer(OtpTimer event, Emitter<OtpVerificationState> emit) async {}
}
