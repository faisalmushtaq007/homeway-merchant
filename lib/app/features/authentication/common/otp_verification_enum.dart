enum OtpVerification {
  valid(message: ''),
  invalid(message: ''),
  invalidPhoneNumber(message: ''),
  otpReSent(message: ''),
  verifying(message: ''),
  verified(message: ''),
  error(message: ''),
  none(message: ''),
  ;

  const OtpVerification({required this.message});
  final String message;
  @override
  String toString() => 'OtpVerification($name, $message)';
}
