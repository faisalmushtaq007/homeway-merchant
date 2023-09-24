part of 'phone_number_verification_bloc.dart';

@freezed
class PhoneNumberVerificationEvent with _$PhoneNumberVerificationEvent {
  const factory PhoneNumberVerificationEvent.started() = _Started;

  const factory PhoneNumberVerificationEvent.phoneNumberChanged({
    required String phoneNumber,
    @Default('+966') String countryDialCode,
    required String country,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    PhoneNumber? enteredPhoneNumber,
    required PhoneController phoneController,
    @Default('SA') String isoCode,
  }) = PhoneNumberChanged;

  const factory PhoneNumberVerificationEvent.verifyPhoneNumber({
    required String userEnteredPhoneNumber,
    @Default('+966') String countryDialCode,
    required String country,
    required PhoneController phoneController,
    required PhoneNumber phoneNumber,
    @Default('SA') String isoCode,
  }) = VerifyPhoneNumber;

  const factory PhoneNumberVerificationEvent.validatePhoneNumber({
    required String phoneNumber,
    @Default('+966') String countryDialCode,
    required String country,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    PhoneNumber? enteredPhoneNumber,
    @Default(PhoneNumberVerification.none)
    PhoneNumberVerification phoneNumberVerification,
    required PhoneController phoneController,
    @Default('SA') String isoCode,
  }) = ValidatePhoneNumber;
}
