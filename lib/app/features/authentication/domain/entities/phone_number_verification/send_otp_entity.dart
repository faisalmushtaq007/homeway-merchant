// This file is "main.dart"
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:network_manager/network_manager.dart';

part 'send_otp_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class SendOtpEntity extends INetworkModel<SendOtpEntity> {
  SendOtpEntity({
    this.countryDialCode,
    this.appUserType,
    this.userName,
  });

  factory SendOtpEntity.fromJson(Map<String, Object?> json) => _$SendOtpEntityFromJson(json);

  @JsonKey(name: 'username')
  String? userName;
  @JsonKey(name: 'country_dial_code')
  String? countryDialCode;
  @JsonKey(name: 'user_type')
  String? appUserType;

  @override
  SendOtpEntity fromJson(Map<String, dynamic> json) {
    return SendOtpEntity.fromJson(json);
  }

  Map<String, dynamic> toMap() => _$SendOtpEntityToJson(this);

  @override
  Map<String, dynamic> toJson() => toMap();
}
