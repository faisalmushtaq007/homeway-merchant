import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_button/async_button.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:homeway_firebase/homeway_firebase.dart';
import 'package:phone_form_field/phone_form_field.dart';

part 'package:homemakers_merchant/app/features/authentication/common/phone_number_verification_enum.dart';

part 'phone_number_verification_event.dart';

part 'phone_number_verification_state.dart';

part 'phone_number_verification_bloc.freezed.dart';

class PhoneNumberVerificationBloc
    extends Bloc<PhoneNumberVerificationEvent, PhoneNumberVerificationState> {
  PhoneNumberVerificationBloc({
    required this.phoneFormFieldBloc,
    required this.sendOtpUseCase,
  }) : super(const PhoneNumberVerificationState.initial()) {
    on<PhoneNumberChanged>(
      _phoneNumberChangedEvent,
      transformer: restartable(),
    );
    on<ValidatePhoneNumber>(
      _validatePhoneNumberEvent,
      transformer: restartable(),
    );
    on<VerifyPhoneNumber>(
      _verifyPhoneNumber,
      transformer: restartable(),
    );
  }

  final PhoneFormFieldBloc phoneFormFieldBloc;
  final SendOtpUseCase sendOtpUseCase;

  FutureOr<void> _initialize(
      _Started event, Emitter<PhoneNumberVerificationState> emit) {}

  FutureOr<void> _phoneNumberChangedEvent(
      PhoneNumberChanged event, Emitter<PhoneNumberVerificationState> emit) {
    emit(PhoneNumberVerificationState.phoneNumberChanged(
      phoneNumber: event.phoneNumber,
      countryDialCode: event.countryDialCode,
      country: event.country,
      phoneValidation: event.phoneValidation,
      phoneNumberInputValidator: event.phoneNumberInputValidator,
      enteredPhoneNumber: event.enteredPhoneNumber,
      phoneController: event.phoneController,
    ));
  }

  FutureOr<void> _validatePhoneNumberEvent(
      ValidatePhoneNumber event, Emitter<PhoneNumberVerificationState> emit) {
    emit(PhoneNumberVerificationState.validatePhoneNumber(
      phoneNumber: event.phoneNumber,
      country: event.country,
      countryDialCode: event.countryDialCode,
      enteredPhoneNumber: event.enteredPhoneNumber,
      phoneNumberVerification: event.phoneNumberVerification,
      phoneNumberInputValidator: event.phoneNumberInputValidator,
      phoneValidation: event.phoneValidation,
      phoneController: event.phoneController,
    ));
  }

  Future<FutureOr<void>> _verifyPhoneNumber(VerifyPhoneNumber event,
      Emitter<PhoneNumberVerificationState> emit) async {
    // Handle api call and otp sent request
    try {
      // Processing state
      emit(
        PhoneNumberVerificationState.processing(),
      );
      await Future.delayed(const Duration(seconds: 2),() {

      },);
      if (event.userEnteredPhoneNumber.isNotEmpty) {
        final sendOtpEntity = SendOtpEntity(
          mobile: event.userEnteredPhoneNumber,
          phoneNumberWithFormat: event.phoneNumberWithFormat,
          country_dial_code: event.countryDialCode,
        );
        // Request send otp use case,
        final ResultState<SendOtpResponseModel> resultState =
            await sendOtpUseCase(sendOtpEntity);

        resultState.maybeMap(
          success: (data) async {
            emit(
              PhoneNumberVerificationState.valid(
                phoneNumberVerification: PhoneNumberVerification.valid,
              ),
            );

            emit(
              PhoneNumberVerificationState.success(
                countryDialCode: event.countryDialCode,
                userEnteredPhoneNumber: event.userEnteredPhoneNumber,
                phoneNumberWithFormat: event.phoneNumberWithFormat,
                phoneNumberVerification: PhoneNumberVerification.otpSent
              ),
            );
          },
          error: (value) {
            emit(
              PhoneNumberVerificationState.error(
                reason: value.reason,
                phoneNumberVerification: PhoneNumberVerification.error,
              ),
            );
          },
          orElse: () {
            emit(
              PhoneNumberVerificationState.invalid(
                reason: 'Something went wrong, please try again.',
                phoneNumberVerification: PhoneNumberVerification.invalid,
              ),
            );
          },
        );
      } else {
        emit(
          PhoneNumberVerificationState.invalid(
            reason: 'Mobile number is invalid',
            phoneNumberVerification: PhoneNumberVerification.invalid,
          ),
        );
      }
    } catch (e, s) {
      emit(
        PhoneNumberVerificationState.error(
          reason: e.toString(),
          phoneNumberVerification: PhoneNumberVerification.error,
        ),
      );
    }
  }
}
