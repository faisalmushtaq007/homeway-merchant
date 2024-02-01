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
    this.verificationId = '',
  });

  factory VerifyOtpEntity.fromJson(Map<String, dynamic> json) =>
      VerifyOtpEntity(
        mobile: json['mobile'] ?? '' as String,
        user_type: json['user_type'] ?? 'merchant' as String,
        country_dial_code: json['country_dial_code'] ?? '' as String,
        otp: json['otp'] ?? '' as String,
        password: json['password'] ?? '' as String,
        db: json['db'] ?? 'odoo16home' as String,
        isoCode: json['isoCode'] as String,
        phoneNumberWithoutFormat:
            json['phoneNumberWithoutFormat'] ?? '' as String,
        phoneNumberWithFormat: json['phoneNumberWithFormat'] ?? '' as String,
        verificationId: json['verificationId'],
      );

  String mobile;
  String country_dial_code;
  String otp;
  String password;
  String db;
  String user_type;
  String isoCode;
  String phoneNumberWithFormat;
  String phoneNumberWithoutFormat;
  String verificationId;

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
        'verificationId': verificationId,
      };

  @override
  Map<String, dynamic> toJson() => toMap();
}
