// This file is "main.dart"
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:network_manager/network_manager.dart';

part 'verify_otp_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifyOtpEntity extends INetworkModel<VerifyOtpEntity> {
  VerifyOtpEntity({
    this.businessPhoneNumber,
    this.appUserType,
    this.countryDialCode,
    this.otpCode,
  });

  factory VerifyOtpEntity.fromJson(Map<String, Object?> json) => _$VerifyOtpEntityFromJson(json);

  @JsonKey(name: 'business_phonenumber')
  String? businessPhoneNumber;
  @JsonKey(name: 'country_dial_code')
  String? countryDialCode;
  @JsonKey(name: 'otp_code')
  int? otpCode;
  @JsonKey(name: 'app_user_type')
  String? appUserType;

  @override
  VerifyOtpEntity fromJson(Map<String, dynamic> json) {
    return VerifyOtpEntity.fromJson(json);
  }

  Map<String, dynamic> toMap() => _$VerifyOtpEntityToJson(this);

  @override
  Map<String, dynamic> toJson() => toMap();
}
