part of 'phone_form_field_bloc.dart';

@freezed
class PhoneFormFieldEvent with _$PhoneFormFieldEvent {
  const factory PhoneFormFieldEvent.initialize() = PhoneFormFieldInitialize;

  const factory PhoneFormFieldEvent.validate({
    @Default(false) bool isAllowEmpty,
    @Default(true) bool mobileOnly,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    required PhoneController phoneController,
    PhoneNumber? phoneNumber,
  }) = PhoneFormFieldValidate;

  const factory PhoneFormFieldEvent.onChange(
      {PhoneNumber? phoneNumber,
      PhoneController? controller}) = PhoneFormFieldOnChange;

  const factory PhoneFormFieldEvent.onSave(
      {PhoneNumber? phoneNumber,
      PhoneController? controller}) = PhoneFormFieldOnSave;
}
