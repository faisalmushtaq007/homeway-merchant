enum OtpVerificationStatus {
  valid(message: 'OTP is valid'),
  invalid(message: 'OTP is invalid'),
  invalidPhoneNumber(message: 'Invalid mobile number'),
  otpSent(message: 'OTP has send to'),
  otpReSent(message: 'OTP has resend it to'),
  verifying(message: 'OTP is verifying'),
  verified(message: 'OTP is verified'),
  error(message: 'OTP has error'),
  none(message: ''),
  otpSending(message: 'OTP is sending to your'),
  otpVerified(message: 'OTP is verified'),
  otpException(message: 'OTP has exception or error'),
  failed(message: 'OTP has failed'),
  processing(message: 'OTP is processing'),
  ;

  const OtpVerificationStatus({required this.message});
  final String message;
  @override
  String toString() => 'OtpVerification($name, $message)';
}

enum OtpTimerStatus {
  start(message: ''),
  pause(message: ''),
  stop(message: ''),
  resume(message: ''),
  none(message: ''),
  ;

  const OtpTimerStatus({required this.message});
  final String message;
  @override
  String toString() => 'OtpVerification($name, $message)';
}
