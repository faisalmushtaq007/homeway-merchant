part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendOtpEntity extends INetworkModel<SendOtpEntity> {
  SendOtpEntity({
    required this.mobile,
    this.country_dial_code = '+966',
    this.user_type = 'merchant',
    this.isoCode = 'SA',
    this.phoneNumberWithoutFormat = '',
    this.phoneNumberWithFormat = '',
    this.db = 'odoo16home',
  });

  factory SendOtpEntity.fromJson(Map<String, dynamic> json) => SendOtpEntity(
        country_dial_code: json['country_dial_code'] ?? '+966' as String,
        user_type: json['user_type'] ?? 'merchant' as String,
        mobile: json['mobile'] ?? '' as String,
        isoCode: json['isoCode'] ?? 'SA' as String,
        phoneNumberWithoutFormat:
            json['phoneNumberWithoutFormat'] ?? '' as String,
        phoneNumberWithFormat: json['phoneNumberWithFormat'] ?? '' as String,
        db: json['db'] ?? 'odoo16home',
      );

  String mobile;
  String country_dial_code;
  String user_type;
  String isoCode;
  String phoneNumberWithFormat;
  String phoneNumberWithoutFormat;
  String db;

  @override
  SendOtpEntity fromJson(Map<String, dynamic> json) {
    return SendOtpEntity.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'mobile': mobile,
        'country_dial_code': country_dial_code,
        'user_type': user_type,
        'isoCode': isoCode,
        'db': db,
        //'phoneNumberWithoutFormat': phoneNumberWithoutFormat,
        //'phoneNumberWithFormat': phoneNumberWithFormat,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
