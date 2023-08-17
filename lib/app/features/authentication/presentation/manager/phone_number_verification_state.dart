part of 'phone_number_verification_bloc.dart';

@freezed
class PhoneNumberVerificationState with _$PhoneNumberVerificationState {
  const factory PhoneNumberVerificationState.initial({@Default(PhoneNumberVerification.none) PhoneNumberVerification phoneNumberVerification}) =
      PhoneNumberVerificationInitialState;

  const factory PhoneNumberVerificationState.success({
    @Default(PhoneNumberVerification.otpSent) PhoneNumberVerification phoneNumberVerification,
    required String userEnteredPhoneNumber,
    @Default('+966') String countryDialCode,
    required String country,
    required PhoneController phoneController,
    required PhoneNumber phoneNumber,
    @Default('SA') String isoCode,
    @Default(
      AsyncBtnState.success,
    )
    AsyncBtnState asyncBtnState,
  }) = PhoneNumberVerificationSuccessState;

  const factory PhoneNumberVerificationState.error({
    @Default(PhoneNumberVerification.error) PhoneNumberVerification phoneNumberVerification,
    required String reason,
    @Default(
      AsyncBtnState.failure,
    )
    AsyncBtnState asyncBtnState,
  }) = PhoneNumberVerificationErrorState;

  const factory PhoneNumberVerificationState.loading() = PhoneNumberVerificationLoadingState;

  const factory PhoneNumberVerificationState.processing() = PhoneNumberVerificationProcessingState;

  const factory PhoneNumberVerificationState.valid({
    @Default(PhoneNumberVerification.valid) PhoneNumberVerification phoneNumberVerification,
  }) = PhoneNumberVerificationValidState;

  const factory PhoneNumberVerificationState.invalid(
      {@Default(PhoneNumberVerification.invalid) PhoneNumberVerification phoneNumberVerification,
      required String reason}) = PhoneNumberVerificationInvalidState;

  const factory PhoneNumberVerificationState.validatePhoneNumber({
    required String phoneNumber,
    @Default('+966') String countryDialCode,
    required String country,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    PhoneNumber? enteredPhoneNumber,
    @Default(PhoneNumberVerification.none) PhoneNumberVerification phoneNumberVerification,
    required PhoneController phoneController,
    @Default('SA') String isoCode,
  }) = PhoneNumberVerificationValidatePhoneNumber;

  const factory PhoneNumberVerificationState.phoneNumberChanged({
    required String phoneNumber,
    @Default('+966') String countryDialCode,
    required String country,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    PhoneNumber? enteredPhoneNumber,
    required PhoneController phoneController,
    @Default('SA') String isoCode,
  }) = PhoneNumberVerificationPhoneNumberChanged;
}
