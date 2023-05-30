import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/core/constants/hive_type_constant.dart';
import 'package:network_manager/network_manager.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(
    typeId: HiveTypeConstant.addressModel, adapterName: 'AddressModelAdapter')
class AddressModel extends INetworkModel<AddressModel> {
  AddressModel({
    this.isDefault,
    this.countryDialCode,
    this.address,
    this.addressRefId,
    this.isoCode,
    this.phoneNumber,
    this.userId,
    this.fullName,
    this.createdAt,
    this.anonymousUserId,
    this.boundingbox,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, Object?> json) =>
      _$AddressModelFromJson(json);

  @JsonKey(name: 'address_ref_id')
  @HiveField(0)
  String? addressRefId;
  @JsonKey(name: 'anonymous_user_id')
  @HiveField(1)
  String? anonymousUserId;
  @JsonKey(name: 'user_id')
  @HiveField(2)
  int? userId;
  @JsonKey(name: 'full_name')
  @HiveField(3)
  String? fullName;
  @JsonKey(name: 'phone_number')
  @HiveField(4)
  String? phoneNumber;
  @JsonKey(name: 'country_dial_code')
  @HiveField(5)
  String? countryDialCode;
  @JsonKey(name: 'iso_code')
  @HiveField(6)
  String? isoCode;
  @JsonKey(name: 'createdAt')
  @HiveField(7)
  int? createdAt;
  @JsonKey(name: 'updatedAt')
  @HiveField(8)
  int? updatedAt;
  @JsonKey(name: 'address')
  @HiveField(9)
  AddressBean? address;
  @JsonKey(name: 'boundingbox')
  @HiveField(10)
  List<String>? boundingbox;
  @JsonKey(name: 'isDefault')
  @HiveField(44)
  bool? isDefault;

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  AddressModel fromMap(Map<String, dynamic> json) {
    return AddressModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toMap() => toJson();
}

@JsonSerializable(explicitToJson: true)
@HiveType(
    typeId: HiveTypeConstant.addressBeanModel,
    adapterName: 'AddressBeanAdapter')
class AddressBean extends INetworkModel<AddressBean> {
  AddressBean({
    this.latitude,
    this.longitude,
    this.state,
    this.category,
    this.city,
    this.area,
    this.landmark,
    this.country,
    this.district,
    this.isDefault,
    this.addressType,
    this.indexOfSavedAddressAs,
    this.countryCode,
    this.placeId,
    this.apartment,
    this.postalCode,
    this.displayAddressName,
    this.savedAddressAs,
    this.placeRank,
    this.village,
    this.type,
    this.town,
    this.suburb,
    this.stateDistrict,
    this.road,
    this.osmType,
    this.municipality,
    this.county,
    this.cityDistrict,
    this.cityCode,
    this.osmId,
    this.pickupAddress,
    this.stateCode,
  });

  factory AddressBean.fromJson(Map<String, Object?> json) =>
      _$AddressBeanFromJson(json);

  @JsonKey(name: 'place_id')
  @HiveField(11)
  int? placeId;
  @JsonKey(name: 'pickup_address')
  @HiveField(12)
  String? pickupAddress;
  @JsonKey(name: 'apartment')
  @HiveField(13)
  String? apartment;
  @JsonKey(name: 'area')
  @HiveField(14)
  String? area;
  @JsonKey(name: 'landmark')
  @HiveField(15)
  String? landmark;
  @JsonKey(name: 'district')
  @HiveField(16)
  String? district;
  @JsonKey(name: 'postal_code')
  @HiveField(17)
  int? postalCode;
  @JsonKey(name: 'city')
  @HiveField(18)
  String? city;
  @JsonKey(name: 'state')
  @HiveField(19)
  String? state;
  @JsonKey(name: 'country')
  @HiveField(20)
  String? country;
  @JsonKey(name: 'country_code')
  @HiveField(21)
  int? countryCode;
  @JsonKey(name: 'city_code')
  @HiveField(22)
  int? cityCode;
  @JsonKey(name: 'state_code')
  @HiveField(23)
  int? stateCode;
  @JsonKey(name: 'isDefault')
  @HiveField(24)
  bool? isDefault;
  @JsonKey(name: 'saved_address_as')
  @HiveField(25)
  String? savedAddressAs;
  @JsonKey(name: 'index_of_saved_address')
  @HiveField(26)
  int? indexOfSavedAddressAs;
  @JsonKey(name: 'latitude')
  @HiveField(27)
  double? latitude;
  @JsonKey(name: 'longitude')
  @HiveField(28)
  double? longitude;
  @JsonKey(name: 'road')
  @HiveField(29)
  String? road;
  @JsonKey(name: 'village')
  @HiveField(30)
  String? village;
  @JsonKey(name: 'state_district')
  @HiveField(31)
  String? stateDistrict;
  @JsonKey(name: 'city_district')
  @HiveField(32)
  String? cityDistrict;
  @JsonKey(name: 'municipality')
  @HiveField(33)
  String? municipality;
  @JsonKey(name: 'suburb')
  @HiveField(34)
  String? suburb;
  @JsonKey(name: 'town')
  @HiveField(35)
  String? town;
  @JsonKey(name: 'county')
  @HiveField(36)
  String? county;
  @JsonKey(name: 'osm_type')
  @HiveField(37)
  String? osmType;
  @JsonKey(name: 'osm_id')
  @HiveField(38)
  int? osmId;
  @JsonKey(name: 'place_rank')
  @HiveField(39)
  int? placeRank;
  @JsonKey(name: 'category')
  @HiveField(40)
  String? category;
  @JsonKey(name: 'type')
  @HiveField(41)
  String? type;
  @JsonKey(name: 'address_type')
  @HiveField(42)
  String? addressType;

//selectedMapAddress
  @JsonKey(name: 'display_address_name')
  @HiveField(43)
  String? displayAddressName;

  Map<String, dynamic> toJson() => _$AddressBeanToJson(this);

  @override
  AddressBean fromMap(Map<String, dynamic> json) {
    return AddressBean.fromJson(json);
  }

  @override
  Map<String, dynamic>? toMap() => toJson();
}
