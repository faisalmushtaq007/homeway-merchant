import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_button/async_button.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:phone_form_field/phone_form_field.dart';

part 'package:homemakers_merchant/app/features/authentication/common/phone_number_verification_enum.dart';

part 'phone_number_verification_event.dart';

part 'phone_number_verification_state.dart';

part 'phone_number_verification_bloc.freezed.dart';

class PhoneNumberVerificationBloc extends Bloc<PhoneNumberVerificationEvent, PhoneNumberVerificationState> {
  PhoneNumberVerificationBloc({
    required this.phoneFormFieldBloc,
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

  FutureOr<void> _phoneNumberChangedEvent(PhoneNumberChanged event, Emitter<PhoneNumberVerificationState> emit) {
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

  FutureOr<void> _validatePhoneNumberEvent(ValidatePhoneNumber event, Emitter<PhoneNumberVerificationState> emit) {
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

  FutureOr<void> _verifyPhoneNumber(VerifyPhoneNumber event, Emitter<PhoneNumberVerificationState> emit) {
    // Handle api call and otp sent request
    emit(
      PhoneNumberVerificationState.success(
        phoneController: event.phoneController,
        countryDialCode: event.countryDialCode,
        userEnteredPhoneNumber: event.userEnteredPhoneNumber,
        country: event.country,
        phoneNumber: event.phoneNumber,
        isoCode: event.isoCode,
      ),
    );
  }
}
