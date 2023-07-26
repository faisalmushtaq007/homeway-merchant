// This file is "main.dart"
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/core/constants/hive_type_constant.dart';
import 'package:network_manager/network_manager.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: HiveTypeConstant.userModel, adapterName: 'UserModelAdapter')
class UserModel extends INetworkModel<UserModel> {
  UserModel({
    this.id,
    this.token,
    this.latitude,
    this.longitude,
    this.image,
    this.bio,
    this.name,
    this.email,
    this.address,
    this.addressModel,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? image;
  @HiveField(4)
  String? bio;
  @HiveField(5)
  String? token;
  @HiveField(6)
  String? address;
  @HiveField(7)
  String? latitude;
  @HiveField(8)
  String? longitude;
  @JsonKey(name: 'user_address')
  @HiveField(9)
  AddressModel? addressModel;

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  Map<String, dynamic>? toMap() => _$UserModelToJson(this);

  @override
  Map<String, dynamic>? toJson() => toMap();
}
