part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class VerifyOtpEntity extends INetworkModel<VerifyOtpEntity> {
  VerifyOtpEntity({
    required this.mobile,
    this.user_type='merchant',
    this.country_dial_code = '+966',
    required this.otp,
    this.phoneNumberWithoutFormat = '',
    this.phoneNumberWithFormat = '',
    this.verificationId = '',
  });

  factory VerifyOtpEntity.fromJson(Map<String, dynamic> json) =>
      VerifyOtpEntity(
        mobile: json['mobile'] ?? '',
        user_type: json['user_type'] ?? 'merchant',
        country_dial_code: json['country_dial_code'] ?? '',
        otp: json['otp'] ?? '',
        phoneNumberWithoutFormat:
            json['phoneNumberWithoutFormat'] ?? '',
        phoneNumberWithFormat: json['phoneNumberWithFormat'] ?? '',
        verificationId: json['verificationId'],
      );

  String mobile;
  String country_dial_code;
  String otp;
  String user_type;
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
        'user_type': user_type,
      };

  Map<String, dynamic> toVerifyOtp() => <String, dynamic>{
        'phone_number': mobile,
        'otp': otp,
      };

  @override
  Map<String, dynamic> toJson() => toVerifyOtp();
}
