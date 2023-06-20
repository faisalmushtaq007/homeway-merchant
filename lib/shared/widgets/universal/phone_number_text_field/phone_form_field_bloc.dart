import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    emit(PhoneNumberFormFieldStateValidate(
      isAllowEmpty: event.isAllowEmpty,
      mobileOnly: event.mobileOnly,
      phoneNumberInputValidator: event.phoneNumberInputValidator,
      phoneValidation: event.phoneValidation,
      phoneController: event.phoneController,
      phoneNumber: event.phoneNumber,
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
