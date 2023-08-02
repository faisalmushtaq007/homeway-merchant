part of 'phone_number_verification_bloc.dart';

@freezed
class PhoneNumberVerificationEvent with _$PhoneNumberVerificationEvent {
  const factory PhoneNumberVerificationEvent.started() = _Started;

  const factory PhoneNumberVerificationEvent.phoneNumberChanged({
    required String phoneNumber,
    required String countryDialCode,
    required String country,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    PhoneNumber? enteredPhoneNumber,
    required PhoneController phoneController,
  }) = PhoneNumberChanged;

  const factory PhoneNumberVerificationEvent.verifyPhoneNumber({
    required String userEnteredPhoneNumber,
    required String countryDialCode,
    required String country,
    required PhoneController phoneController,
    required PhoneNumber phoneNumber,
  }) = VerifyPhoneNumber;

  const factory PhoneNumberVerificationEvent.validatePhoneNumber({
    required String phoneNumber,
    required String countryDialCode,
    required String country,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    PhoneNumber? enteredPhoneNumber,
    @Default(PhoneNumberVerification.none) PhoneNumberVerification phoneNumberVerification,
    required PhoneController phoneController,
  }) = ValidatePhoneNumber;
}
