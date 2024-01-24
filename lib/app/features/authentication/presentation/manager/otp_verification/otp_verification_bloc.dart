import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/authentication/common/otp_verification_enum.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:homeway_firebase/homeway_firebase.dart';
import 'package:meta/meta.dart';

part 'otp_verification_event.dart';

part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.firebaseAuthentication,
    required this.sendFirebaseOtpUseCase,
    required this.verifyFirebaseOtpUseCase,
  }) : super(OtpVerificationInitial()) {
    on<SendOtp>(_sendOTP);
    on<VerifyOtp>(_verifyOtp);
    on<OtpTimer>(_otpTimer);
  }

  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  final SendFirebaseOtpUseCase sendFirebaseOtpUseCase;
  final VerifyFirebaseOtpUseCase verifyFirebaseOtpUseCase;
  final FirebaseAuthenticationRepository firebaseAuthentication;

  FutureOr<void> _sendOTP(
      SendOtp event, Emitter<OtpVerificationState> emit) async {
    try {
      emit(
        SendOtpProcessingState(
          sendOtpEntity: event.sendOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.processing,
        ),
      );
      if (!event.sendOtpEntity.mobile.isEmptyOrNull) {
        // Request send otp use case
        final ResultState<SendOtpFirebaseResponseModel> resultState =
            await sendFirebaseOtpUseCase(event.sendOtpEntity);

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
              SendOtpState(
                  sendOtpEntity: event.sendOtpEntity,
                  otpVerificationStatus: OtpVerificationStatus.otpSending),
            );
          },
          success: (data) {
            emit(
              SendOtpState(
                sendOtpEntity: event.sendOtpEntity,
                otpVerificationStatus: (event.hasOtpResend)
                    ? OtpVerificationStatus.otpReSent
                    : OtpVerificationStatus.otpSent,
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

  FutureOr<void> _verifyOtp(
      VerifyOtp event, Emitter<OtpVerificationState> emit) async {
    try {
      VerifyOtpFirebaseResponseModel? verifyOtpResponseModel;
      emit(
        VerifyOtpProcessingState(
          verifyOtpEntity: event.verifyOtpEntity,
          otpVerificationStatus: OtpVerificationStatus.processing,
        ),
      );
      if (!event.verifyOtpEntity.mobile.isEmptyOrNull &&
          event.verifyOtpEntity.otp != null) {
        // Verify otp use case
        final ResultState<VerifyOtpFirebaseResponseModel> resultState =
            await verifyFirebaseOtpUseCase(event.verifyOtpEntity);

        emit(
          VerifyOtpProcessingState(
            verifyOtpEntity: event.verifyOtpEntity,
            otpVerificationStatus: OtpVerificationStatus.processing,
            isProcessing: false,
          ),
        );
        await resultState.maybeWhen(
          orElse: () {
            emit(
              VerifyOtpState(
                  verifyOtpEntity: event.verifyOtpEntity,
                  otpVerificationStatus: OtpVerificationStatus.verifying),
            );
            return;
          },
          success: (data) async {
            verifyOtpResponseModel = data;
            // Todo(prasant): Change this logic when we are verify the otp from remote
            appLog
                .d('Wait for processing, uploading and fetching current user');
            AppUserEntity saveUserEntity = AppUserEntity();
            // Firebase token
            final firebaseToken =
                await verifyOtpResponseModel?.firebaseUserData?.getIdToken();
            final saveUserEntityResult =
                await serviceLocator<SaveAllAppUserUseCase>()([
              AppUserEntity(
                isoCode: event.verifyOtpEntity.isoCode,
                country_dial_code: event.verifyOtpEntity.country_dial_code,
                phoneNumber: event.verifyOtpEntity.phoneNumberWithFormat,
                hasCurrentUser: true,
                uid: verifyOtpResponseModel?.firebaseUserId ?? '',
                access_token: firebaseToken ?? '',
                currentUserStage: 0,
                phoneNumberWithoutDialCode:
                    event.verifyOtpEntity.phoneNumberWithoutFormat,
              ),
            ]);
            await saveUserEntityResult.when(
              remote: (data, meta) {},
              localDb: (data, meta) async {
                appLog.d('Save current user save local ${data?.last.toMap()}');
                if (data != null) {
                  saveUserEntity = data.last;
                  appLog.e(
                      'Save current user ${saveUserEntity.userID ?? ''}, ${saveUserEntity.phoneNumber}');
                  await Future.delayed(
                      const Duration(milliseconds: 500), () {});
                  //Save to local model
                  serviceLocator<AppUserEntity>()
                    ..userID = saveUserEntity.userID
                    ..phoneNumber = saveUserEntity.phoneNumber
                    ..businessProfile = saveUserEntity.businessProfile
                    ..stores = saveUserEntity.stores
                    ..token = saveUserEntity.token
                    ..tokenCreationDateTime =
                        saveUserEntity.tokenCreationDateTime
                    ..hasUserAuthenticated = saveUserEntity.hasUserAuthenticated
                    ..businessTypeEntity = saveUserEntity.businessTypeEntity
                    ..currentProfileStatus = saveUserEntity.currentProfileStatus
                    ..menus = saveUserEntity.menus
                    ..drivers = saveUserEntity.drivers
                    ..addons = saveUserEntity.addons
                    ..ratingAndReviewEntity =
                        saveUserEntity.ratingAndReviewEntity
                    ..hasCurrentUser = saveUserEntity.hasCurrentUser
                    ..country_dial_code = saveUserEntity.country_dial_code
                    ..isoCode = saveUserEntity.isoCode
                    ..user_type = saveUserEntity.user_type
                    ..access_token = saveUserEntity.access_token
                    ..currentUserStage = saveUserEntity.currentUserStage
                    ..uid = saveUserEntity.uid
                    ..paymentBankEntity = saveUserEntity.paymentBankEntity
                    ..hasMultiplePaymentBanks =
                        saveUserEntity.hasMultiplePaymentBanks
                    ..paymentBankEntities = saveUserEntity.paymentBankEntities
                    ..phoneNumberWithoutDialCode =
                        saveUserEntity.phoneNumberWithoutDialCode;
                  serviceLocator<UserModelStorageController>()
                      .setUserModel(data.first.copyWith());
                }
              },
              error: (dataSourceFailure, reason, error, networkException,
                  stackTrace, exception, extra) {
                appLog.d('Save current user save local exception $error');
              },
            );
            emit(
              VerifyOtpState(
                verifyOtpEntity: event.verifyOtpEntity,
                otpVerificationStatus: OtpVerificationStatus.otpVerified,
                appUserEntity: saveUserEntity,
              ),
            );
          },
          error: (reason, error, networkException, stackTrace) async {
            // Todo(prasant): Change this logic when we are verify the otp from remote
            appLog
                .d('Wait for processing, uploading and fetching current user');
            AppUserEntity saveUserEntity = AppUserEntity();
            final saveUserEntityResult =
                await serviceLocator<SaveAllAppUserUseCase>()([
              AppUserEntity(
                isoCode: event.verifyOtpEntity.isoCode,
                country_dial_code: event.verifyOtpEntity.country_dial_code,
                phoneNumber: event.verifyOtpEntity.phoneNumberWithFormat,
                hasCurrentUser: true,
                uid: '',
                access_token: '',
                currentUserStage: 0,
                phoneNumberWithoutDialCode:
                    event.verifyOtpEntity.phoneNumberWithoutFormat,
              ),
            ]);
            await saveUserEntityResult.when(
              remote: (data, meta) {},
              localDb: (data, meta) async {
                appLog.d('Save current user save local ${data?.first.toMap()}');
                if (data != null) {
                  appLog.e(
                      'Save current user ${data.first.phoneNumberWithoutDialCode ?? ''}, ${data.first.phoneNumber}');
                  saveUserEntity = data.first;
                  await Future.delayed(
                      const Duration(milliseconds: 500), () {});
                  //Save to local model
                  serviceLocator<UserModelStorageController>()
                      .setUserModel(data.first.copyWith());
                }
              },
              error: (dataSourceFailure, reason, error, networkException,
                  stackTrace, exception, extra) {
                appLog.d('Save current user save local exception $error');
              },
            );

            emit(
              VerifyOtpFailedState(
                verifyOtpEntity: event.verifyOtpEntity,
                otpVerificationStatus: OtpVerificationStatus.error,
                stackTrace: stackTrace,
                exception: error,
                message: reason,
                appUserEntity: saveUserEntity,
              ),
            );
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

  FutureOr<void> _otpTimer(
      OtpTimer event, Emitter<OtpVerificationState> emit) async {}
}
