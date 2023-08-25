part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class VerifyOtpEntity extends INetworkModel<VerifyOtpEntity> {
  VerifyOtpEntity({
    required this.mobile,
    required this.user_type,
    this.country_dial_code = '+966',
    required this.otp,
    this.db = 'odoo16home',
    required this.password,
    this.isoCode = 'SA',
    this.phoneNumberWithoutFormat = '',
    this.phoneNumberWithFormat = '',
  });

  factory VerifyOtpEntity.fromJson(Map<String, dynamic> json) => VerifyOtpEntity(
        mobile: json['mobile'] ?? '' as String,
        user_type: json['user_type'] ?? 'merchant' as String,
        country_dial_code: json['country_dial_code'] ?? '' as String,
        otp: json['otp'] ?? -1 as int,
        password: json['password'] ?? '' as int,
        db: json['db'] ?? '' as String,
        isoCode: json['isoCode'] as String,
        phoneNumberWithoutFormat: json['phoneNumberWithoutFormat'] ?? '' as String,
        phoneNumberWithFormat: json['phoneNumberWithFormat'] ?? '' as String,
      );

  String mobile;
  String country_dial_code;
  int otp;
  int password;
  String db;
  String user_type;
  String isoCode;
  String phoneNumberWithFormat;
  String phoneNumberWithoutFormat;

  @override
  VerifyOtpEntity fromJson(Map<String, dynamic> json) {
    return VerifyOtpEntity.fromJson(json);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'mobile': mobile,
        'country_dial_code': country_dial_code,
        'otp': otp,
        //'password': password,
        'db': db,
        'user_type': user_type,
        'isoCode': isoCode,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
