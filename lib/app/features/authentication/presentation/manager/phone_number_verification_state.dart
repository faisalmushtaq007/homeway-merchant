part of 'phone_number_verification_bloc.dart';

@freezed
class PhoneNumberVerificationState with _$PhoneNumberVerificationState {
  const factory PhoneNumberVerificationState.initial(
          {@Default(PhoneNumberVerification.none)
          PhoneNumberVerification phoneNumberVerification}) =
      PhoneNumberVerificationInitialState;

  const factory PhoneNumberVerificationState.success(
      {@Default(PhoneNumberVerification.otpSent)
      PhoneNumberVerification phoneNumberVerification,
      required String phoneNumber,
      required String countryDialCode,
      required String country}) = PhoneNumberVerificationSuccessState;

  const factory PhoneNumberVerificationState.error(
      {@Default(PhoneNumberVerification.error)
      PhoneNumberVerification phoneNumberVerification,
      required String reason}) = PhoneNumberVerificationErrorState;

  const factory PhoneNumberVerificationState.loading() =
      PhoneNumberVerificationLoadingState;

  const factory PhoneNumberVerificationState.processing() =
      PhoneNumberVerificationProcessingState;

  const factory PhoneNumberVerificationState.valid(
          {@Default(PhoneNumberVerification.valid)
          PhoneNumberVerification phoneNumberVerification}) =
      PhoneNumberVerificationValidState;

  const factory PhoneNumberVerificationState.invalid(
      {@Default(PhoneNumberVerification.invalid)
      PhoneNumberVerification phoneNumberVerification,
      required String reason}) = PhoneNumberVerificationInvalidState;

  const factory PhoneNumberVerificationState.validatePhoneNumber(
          {required String phoneNumber,
          required String countryDialCode,
          required String country,
          PhoneNumberInputValidator? phoneNumberInputValidator,
          String? phoneValidation,
          PhoneNumber? enteredPhoneNumber,
          @Default(PhoneNumberVerification.none)
          PhoneNumberVerification phoneNumberVerification}) =
      PhoneNumberVerificationValidatePhoneNumber;
  const factory PhoneNumberVerificationState.phoneNumberChanged({
    required String phoneNumber,
    required String countryDialCode,
    required String country,
    PhoneNumberInputValidator? phoneNumberInputValidator,
    String? phoneValidation,
    PhoneNumber? enteredPhoneNumber,
  }) = PhoneNumberVerificationPhoneNumberChanged;
}
