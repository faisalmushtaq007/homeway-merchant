import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:network_manager/network_manager.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)
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

  factory AddressModel.fromJson(Map<String, Object?> json) => _$AddressModelFromJson(json);

  @JsonKey(name: 'address_ref_id')
  String? addressRefId;
  @JsonKey(name: 'anonymous_user_id')
  String? anonymousUserId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'full_name')
  String? fullName;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'country_dial_code')
  String? countryDialCode;
  @JsonKey(name: 'iso_code')
  String? isoCode;
  @JsonKey(name: 'createdAt')
  int? createdAt;
  @JsonKey(name: 'updatedAt')
  int? updatedAt;
  @JsonKey(name: 'address')
  AddressBean? address;
  @JsonKey(name: 'boundingbox')
  List<String>? boundingbox;
  @JsonKey(name: 'isDefault')
  bool? isDefault;

  Map<String, dynamic> toMap() => _$AddressModelToJson(this);

  @override
  AddressModel fromJson(Map<String, dynamic> json) {
    return AddressModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() => toMap();
}

@JsonSerializable(explicitToJson: true)
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

  factory AddressBean.fromJson(Map<String, Object?> json) => _$AddressBeanFromJson(json);

  @JsonKey(name: 'place_id')
  int? placeId;
  @JsonKey(name: 'pickup_address')
  String? pickupAddress;
  @JsonKey(name: 'apartment')
  String? apartment;
  @JsonKey(name: 'area')
  String? area;
  @JsonKey(name: 'landmark')
  String? landmark;
  @JsonKey(name: 'district')
  String? district;
  @JsonKey(name: 'postal_code')
  int? postalCode;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'state')
  String? state;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'country_code')
  int? countryCode;
  @JsonKey(name: 'city_code')
  int? cityCode;
  @JsonKey(name: 'state_code')
  int? stateCode;
  @JsonKey(name: 'isDefault')
  bool? isDefault;
  @JsonKey(name: 'saved_address_as')
  String? savedAddressAs;
  @JsonKey(name: 'index_of_saved_address')
  int? indexOfSavedAddressAs;
  @JsonKey(name: 'latitude')
  double? latitude;
  @JsonKey(name: 'longitude')
  double? longitude;
  @JsonKey(name: 'road')
  String? road;
  @JsonKey(name: 'village')
  String? village;
  @JsonKey(name: 'state_district')
  String? stateDistrict;
  @JsonKey(name: 'city_district')
  String? cityDistrict;
  @JsonKey(name: 'municipality')
  String? municipality;
  @JsonKey(name: 'suburb')
  String? suburb;
  @JsonKey(name: 'town')
  String? town;
  @JsonKey(name: 'county')
  String? county;
  @JsonKey(name: 'osm_type')
  String? osmType;
  @JsonKey(name: 'osm_id')
  int? osmId;
  @JsonKey(name: 'place_rank')
  int? placeRank;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'address_type')
  String? addressType;

//selectedMapAddress
  @JsonKey(name: 'display_address_name')
  String? displayAddressName;

  Map<String, dynamic> toMap() => _$AddressBeanToJson(this);

  @override
  AddressBean fromJson(Map<String, dynamic> json) {
    return AddressBean.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() => toMap();
}
