import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

part 'phone_form_field_event.dart';

part 'phone_form_field_state.dart';

part 'phone_form_field_bloc.freezed.dart';

class PhoneFormFieldBloc
    extends Bloc<PhoneFormFieldEvent, PhoneNumberFormFieldState> {
  PhoneFormFieldBloc() : super(const PhoneNumberFormFieldState.initialize()) {
    on<PhoneFormFieldInitialize>(
      _phoneFormFieldInitialize,
    );
    on<PhoneFormFieldValidate>(
      _phoneFormFieldValidate,
      transformer: restartable(),
    );
    on<PhoneFormFieldOnChange>(
      _phoneFormFieldOnChange,
      transformer: restartable(),
    );
    on<PhoneFormFieldOnSave>(
      _phoneFormFieldOnSave,
      transformer: restartable(),
    );
  }

  PhoneController? controller;
  PhoneNumber? phoneNumber;

  FutureOr<void> _phoneFormFieldInitialize(PhoneFormFieldInitialize event,
      Emitter<PhoneNumberFormFieldState> emit) {}

  FutureOr<void> _phoneFormFieldValidate(
      PhoneFormFieldValidate event, Emitter<PhoneNumberFormFieldState> emit) {
    PhoneNumberVerification phoneNumberVerification =
        PhoneNumberVerification.none;
    String userEnteredPhoneNumber =
        '+${event.phoneController.value?.countryCode} ${event.phoneController.value?.getFormattedNsn().trim()}';
    String countryDialCode =
        '+${event.phoneController.value?.countryCode ?? '+966'}';
    String country = event.phoneController.value?.isoCode.name ?? 'SA';
    if (event.phoneValidation != null && event.phoneValidation!.isNotEmpty) {
      phoneNumberVerification = PhoneNumberVerification.invalid;
    } else {
      if (event.phoneValidation == null &&
          event.phoneController.value != null &&
          event.phoneController.value!.getFormattedNsn().trim().isNotEmpty) {
        phoneNumberVerification = PhoneNumberVerification.valid;
      } else {
        phoneNumberVerification = PhoneNumberVerification.none;
      }
    }
    emit(PhoneNumberFormFieldStateValidate(
      isAllowEmpty: event.isAllowEmpty,
      mobileOnly: event.mobileOnly,
      phoneNumberInputValidator: event.phoneNumberInputValidator,
      phoneValidation: event.phoneValidation,
      phoneController: event.phoneController,
      phoneNumber: event.phoneNumber,
      phoneNumberVerification: phoneNumberVerification,
      userEnteredPhoneNumber: userEnteredPhoneNumber,
      countryDialCode: countryDialCode,
      country: country,
    ));
  }

  FutureOr<void> _phoneFormFieldOnChange(
      PhoneFormFieldOnChange event, Emitter<PhoneNumberFormFieldState> emit) {
    controller = event.controller;
    phoneNumber = event.phoneNumber;
    emit(PhoneNumberFormFieldStateOnChange(
      controller: event.controller,
      phoneNumber: event.phoneNumber,
    ));
  }

  FutureOr<void> _phoneFormFieldOnSave(
      PhoneFormFieldOnSave event, Emitter<PhoneNumberFormFieldState> emit) {
    controller = event.controller;
    phoneNumber = event.phoneNumber;
    emit(PhoneNumberFormFieldStateOnSave(
      controller: event.controller,
      phoneNumber: event.phoneNumber,
    ));
  }
}
