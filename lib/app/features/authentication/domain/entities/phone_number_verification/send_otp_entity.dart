part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendOtpEntity extends INetworkModel<SendOtpEntity> {
  SendOtpEntity({
    required this.country_dial_code,
    required this.user_type,
    required this.userName,
  });

  factory SendOtpEntity.fromJson(Map<String, dynamic> json) => SendOtpEntity(
        country_dial_code: json['country_dial_code'] ?? '' as String,
        user_type: json['user_type'] ?? '' as String,
        userName: json['username'] ?? '' as String,
      );

  String userName;
  String country_dial_code;
  String user_type;

  @override
  SendOtpEntity fromJson(Map<String, dynamic> json) {
    return SendOtpEntity.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'username': userName,
        'country_dial_code': country_dial_code,
        'user_type': user_type,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
