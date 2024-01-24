part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class VerifyOtpFirebaseResponseModel {
  VerifyOtpFirebaseResponseModel({
    required this.hasOtpCodeVerified,
    this.firebaseUserData,
    this.firebaseUserId,
    this.otpAutoVerified = false,
    this.userCredentials,
  });

  String? firebaseUserId;
  bool hasOtpCodeVerified;
  User? firebaseUserData;
  UserCredential? userCredentials;
  bool otpAutoVerified;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'verificationId': this.firebaseUserId,
        'hasOtpCodeSent': this.hasOtpCodeVerified,
        'otpAutoVerified': this.otpAutoVerified,
      };
}
