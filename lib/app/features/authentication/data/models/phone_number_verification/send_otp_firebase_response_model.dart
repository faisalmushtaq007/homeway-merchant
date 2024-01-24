part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendOtpFirebaseResponseModel {
  SendOtpFirebaseResponseModel({
    required this.hasOtpCodeSent,
    this.stackTrace,
    this.verificationId,
    this.firebaseException,
    this.error,
    this.errorMessage,
  });

  String? verificationId;
  bool hasOtpCodeSent;
  FirebaseException? firebaseException;
  String? errorMessage;
  Object? error;
  StackTrace? stackTrace;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'verificationId': this.verificationId??'',
        'hasOtpCodeSent': this.hasOtpCodeSent,
        'errorMessage': this.errorMessage ?? '',
      };
}
