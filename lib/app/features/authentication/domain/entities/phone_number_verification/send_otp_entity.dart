// This file is "main.dart"
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:network_manager/network_manager.dart';

part 'send_otp_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class SendOtpEntity extends INetworkModel<SendOtpEntity> {
  SendOtpEntity({
    this.longitude,
    this.latitude,
    this.countryDialCode,
    this.appUserType,
    this.businessAddress,
    this.businessCity,
    this.businessEmail,
    this.businessName,
    this.businessPhoneNumber,
    this.businessType,
    this.userName,
  });

  factory SendOtpEntity.fromJson(Map<String, Object?> json) => _$SendOtpEntityFromJson(json);

  @JsonKey(name: 'business_name')
  String? businessName;
  @JsonKey(name: 'business_type')
  String? businessType;
  @JsonKey(name: 'username')
  String? userName;
  @JsonKey(name: 'business_email')
  String? businessEmail;
  @JsonKey(name: 'business_phonenumber')
  String? businessPhoneNumber;
  @JsonKey(name: 'country_dial_code')
  String? countryDialCode;
  @JsonKey(name: 'business_city')
  String? businessCity;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'business_address')
  AddressModel? businessAddress;
  @JsonKey(name: 'app_user_type')
  String? appUserType;

  @override
  SendOtpEntity fromJson(Map<String, dynamic> json) {
    return SendOtpEntity.fromJson(json);
  }

  Map<String, dynamic> toMap() => _$SendOtpEntityToJson(this);

  @override
  Map<String, dynamic> toJson() => toMap();
}
