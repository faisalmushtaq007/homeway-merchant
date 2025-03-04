enum PhoneNumberVerification {
  valid(message: ''),
  invalid(message: ''),
  mismatchCountryDialCode(message: ''),
  otpSent(message: ''),
  error(message: ''),
  none(message: ''),
  ;

  const PhoneNumberVerification({required this.message});
  final String message;
  @override
  String toString() => 'PhoneNumberVerification($name, $message)';
  //static PhoneNumberVerification byFieldValue(String value) => values.firstWhere((e) => e._field == value);
}
