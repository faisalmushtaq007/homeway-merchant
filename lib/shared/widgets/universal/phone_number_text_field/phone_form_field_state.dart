part of 'phone_form_field_bloc.dart';

@freezed
class PhoneNumberFormFieldState with _$PhoneNumberFormFieldState {
  const factory PhoneNumberFormFieldState.initialize() =
      PhoneNumberFormFieldStateInitialize;

  const factory PhoneNumberFormFieldState.validate({
    @Default(false) bool isAllowEmpty,
    @Default(true) bool mobileOnly,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    required PhoneController phoneController,
    PhoneNumber? phoneNumber,
  }) = PhoneNumberFormFieldStateValidate;

  const factory PhoneNumberFormFieldState.onChange(
      {PhoneNumber? phoneNumber,
      PhoneController? controller}) = PhoneNumberFormFieldStateOnChange;

  const factory PhoneNumberFormFieldState.onSave(
      {PhoneNumber? phoneNumber,
      PhoneController? controller}) = PhoneNumberFormFieldStateOnSave;
}
