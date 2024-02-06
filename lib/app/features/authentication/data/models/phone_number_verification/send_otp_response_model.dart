part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendOtpResponseModel extends INetworkModel<SendOtpResponseModel> {
  SendOtpResponseModel({
    this.message = '',
  });

  factory SendOtpResponseModel.fromJson(Map<String, Object?> json) =>
      SendOtpResponseModel(
        message: json['msg'].isNotNull ? json['msg'] as String : '',
      );

  String message;

  @override
  SendOtpResponseModel fromJson(Map<String, dynamic> json) {
    return SendOtpResponseModel.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'msg': this.message,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
