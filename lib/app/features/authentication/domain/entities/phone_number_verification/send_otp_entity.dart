part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendOtpEntity extends INetworkModel<SendOtpEntity> {
  SendOtpEntity({
    this.country_dial_code = '+966',
    required this.user_type,
    required this.userName,
    this.isoCode = 'SA',
  });

  factory SendOtpEntity.fromJson(Map<String, dynamic> json) => SendOtpEntity(
        country_dial_code: json['country_dial_code'] ?? '+966' as String,
        user_type: json['user_type'] ?? '' as String,
        userName: json['username'] ?? '' as String,
        isoCode: json['isoCode'] ?? 'SA' as String,
      );

  String userName;
  String country_dial_code;
  String user_type;
  String isoCode;

  @override
  SendOtpEntity fromJson(Map<String, dynamic> json) {
    return SendOtpEntity.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'username': userName,
        'country_dial_code': country_dial_code,
        'user_type': user_type,
        'isoCode': isoCode,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
