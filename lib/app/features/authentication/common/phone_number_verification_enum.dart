part of 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';

enum PhoneNumberVerification {
  valid(message: 'Phone number is valid'),
  invalid(message: 'Invalid Phone number'),
  mismatchCountryDialCode(message: ''),
  otpSent(message: 'OTP sent to phone number'),
  error(message: 'Something went wrong, Please try again.'),
  none(message: ''),
  processing(message: 'Processing'),
  ;

  const PhoneNumberVerification({required this.message});
  final String message;
  @override
  String toString() => 'PhoneNumberVerification($name, $message)';
  //static PhoneNumberVerification byFieldValue(String value) => values.firstWhere((e) => e._field == value);
}
