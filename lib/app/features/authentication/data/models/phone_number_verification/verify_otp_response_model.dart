part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class VerifyOtpResponseModel extends INetworkModel<VerifyOtpResponseModel> {
  VerifyOtpResponseModel({
    this.user_type,
    this.message,
    this.current_status,
    this.uid,
    this.access_token,
  });
  factory VerifyOtpResponseModel.fromJson(Map<String, Object?> json) =>
      VerifyOtpResponseModel(
        user_type: json['user_type'] as String?,
        message: json['message'] as String?,
        current_status: json['current_status'] as int?,
        uid: json['uid'] as String?,
        access_token: json['access_token'] as String?,
      );

  String? message;

  String? uid;

  String? access_token;

  String? user_type;

  int? current_status;
  @override
  VerifyOtpResponseModel fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'message': this.message,
        'uid': this.uid,
        'access_token': this.access_token,
        'user_type': this.user_type,
        'current_status': this.current_status,
      };
  @override
  Map<String, dynamic> toJson() => toMap();
}
