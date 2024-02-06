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
        user_type: 'merchant',
        message: json['msg'] as String?,
        current_status: json['status'] as int?,
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
        'msg': this.message,
        'uid': this.uid,
        'access_token': this.access_token,
        'user_type': this.user_type,
        'status': this.current_status,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
