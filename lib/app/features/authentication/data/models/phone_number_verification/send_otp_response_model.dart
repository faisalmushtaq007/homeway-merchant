part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendOtpResponseModel extends INetworkModel<SendOtpResponseModel> {
  SendOtpResponseModel({
    this.app_user_type = '',
    this.id = '',
  });

  factory SendOtpResponseModel.fromJson(Map<String, Object?> json) => SendOtpResponseModel(
        app_user_type: (json['app_user_type'].isNotNull) ? json['app_user_type'] as String : '',
        id: (json['id'].isNotNull) ? json['id'] as String : '',
      )..result = json['result'].isNull ? SendOtpResultModel() : SendOtpResultModel.fromJson(json['result'] as Map<String, dynamic>);
  String id;
  String app_user_type;
  SendOtpResultModel? result;

  @override
  SendOtpResponseModel fromJson(Map<String, dynamic> json) {
    return SendOtpResponseModel.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': this.id,
        'app_user_type': this.app_user_type,
        'result': this.result?.toJson(),
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}

class SendOtpResultModel extends INetworkModel<SendOtpResultModel> {
  SendOtpResultModel({
    this.otp = -1,
    this.message = '',
  });

  factory SendOtpResultModel.fromJson(Map<String, Object?> json) => SendOtpResultModel(
        otp: (json['otp'].isNotNull) ? json['otp'] as int : -1,
        message: json['message'].isNotNull ? json['message'] as String : '',
      );

  String message;

  int otp;

  @override
  SendOtpResultModel fromJson(Map<String, dynamic> json) {
    return SendOtpResultModel.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'message': this.message,
        'otp': this.otp,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
