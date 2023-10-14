part of 'package:homemakers_merchant/app/features/common/index.dart';
enum ChangePhoneNumberPurpose {
  profile(message: 'Profile'),
  store(message: 'Store'),
  driver(message: 'Driver'),
  ;

  const ChangePhoneNumberPurpose({required this.message});
  final String message;
  @override
  String toString() => 'Change PhoneNumber purpose for ($name, $message)';
}