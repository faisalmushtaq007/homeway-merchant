import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:network_manager/network_manager.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressModel extends INetworkModel<AddressModel> {
  AddressModel({
    this.isDefault = false,
    this.countryDialCode = '',
    this.address,
    this.addressRefId = '',
    this.isoCode = '',
    this.phoneNumber = '',
    this.userId = -1,
    this.fullName = '',
    this.createdAt = -1,
    this.anonymousUserId = '',
    this.boundingbox = const [],
    this.updatedAt = -1,
  });

  factory AddressModel.fromJson(Map<String, Object?> json) => _$AddressModelFromJson(json);

  @JsonKey(
    name: 'address_ref_id',
    defaultValue: '',
  )
  String? addressRefId;
  @JsonKey(
    name: 'anonymous_user_id',
    defaultValue: '',
  )
  String? anonymousUserId;
  @JsonKey(
    name: 'user_id',
    defaultValue: -1,
  )
  int? userId;
  @JsonKey(
    name: 'full_name',
    defaultValue: '',
  )
  String? fullName;
  @JsonKey(
    name: 'phone_number',
    defaultValue: '',
  )
  String? phoneNumber;
  @JsonKey(
    name: 'country_dial_code',
    defaultValue: '',
  )
  String? countryDialCode;
  @JsonKey(
    name: 'iso_code',
    defaultValue: '',
  )
  String? isoCode;
  @JsonKey(
    name: 'createdAt',
    defaultValue: -1,
  )
  int? createdAt;
  @JsonKey(
    name: 'updatedAt',
    defaultValue: -1,
  )
  int? updatedAt;
  @JsonKey(
    name: 'address',
  )
  AddressBean? address;
  @JsonKey(
    name: 'boundingbox',
    defaultValue: [],
  )
  List<String>? boundingbox;
  @JsonKey(name: 'isDefault', defaultValue: false)
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
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.state = '',
    this.category = '',
    this.city = '',
    this.area = '',
    this.landmark = '',
    this.country = '',
    this.district = '',
    this.isDefault = false,
    this.addressType = '',
    this.indexOfSavedAddressAs = -1,
    this.countryCode = -1,
    this.placeId = -1,
    this.apartment = '',
    this.postalCode = -1,
    this.displayAddressName = '',
    this.savedAddressAs = '',
    this.placeRank = -1,
    this.village = '',
    this.type = '',
    this.town = '',
    this.suburb = '',
    this.stateDistrict = '',
    this.road = '',
    this.osmType = '',
    this.municipality = '',
    this.county = '',
    this.cityDistrict = '',
    this.cityCode = -1,
    this.osmId = -1,
    this.pickupAddress = '',
    this.stateCode = -1,
  });

  factory AddressBean.fromJson(Map<String, Object?> json) => _$AddressBeanFromJson(json);

  @JsonKey(
    name: 'place_id',
    defaultValue: -1,
  )
  int? placeId;
  @JsonKey(
    name: 'pickup_address',
    defaultValue: '',
  )
  String? pickupAddress;
  @JsonKey(
    name: 'apartment',
    defaultValue: '',
  )
  String? apartment;
  @JsonKey(
    name: 'area',
    defaultValue: '',
  )
  String? area;
  @JsonKey(
    name: 'landmark',
    defaultValue: '',
  )
  String? landmark;
  @JsonKey(
    name: 'district',
    defaultValue: '',
  )
  String? district;
  @JsonKey(
    name: 'postal_code',
    defaultValue: -1,
  )
  int? postalCode;
  @JsonKey(
    name: 'city',
    defaultValue: '',
  )
  String? city;
  @JsonKey(
    name: 'state',
    defaultValue: '',
  )
  String? state;
  @JsonKey(
    name: 'country',
    defaultValue: '',
  )
  String? country;
  @JsonKey(
    name: 'country_code',
    defaultValue: -1,
  )
  int? countryCode;
  @JsonKey(
    name: 'city_code',
    defaultValue: -1,
  )
  int? cityCode;
  @JsonKey(
    name: 'state_code',
    defaultValue: -1,
  )
  int? stateCode;
  @JsonKey(
    name: 'isDefault',
    defaultValue: false,
  )
  bool? isDefault;
  @JsonKey(
    name: 'saved_address_as',
    defaultValue: '',
  )
  String? savedAddressAs;
  @JsonKey(
    name: 'index_of_saved_address',
    defaultValue: -1,
  )
  int? indexOfSavedAddressAs;
  @JsonKey(
    name: 'latitude',
    defaultValue: 0.0,
  )
  double? latitude;
  @JsonKey(
    name: 'longitude',
    defaultValue: 0.0,
  )
  double? longitude;
  @JsonKey(
    name: 'road',
    defaultValue: '',
  )
  String? road;
  @JsonKey(
    name: 'village',
    defaultValue: '',
  )
  String? village;
  @JsonKey(
    name: 'state_district',
    defaultValue: '',
  )
  String? stateDistrict;
  @JsonKey(
    name: 'city_district',
    defaultValue: '',
  )
  String? cityDistrict;
  @JsonKey(
    name: 'municipality',
    defaultValue: '',
  )
  String? municipality;
  @JsonKey(
    name: 'suburb',
    defaultValue: '',
  )
  String? suburb;
  @JsonKey(
    name: 'town',
    defaultValue: '',
  )
  String? town;
  @JsonKey(
    name: 'county',
    defaultValue: '',
  )
  String? county;
  @JsonKey(
    name: 'osm_type',
    defaultValue: '',
  )
  String? osmType;
  @JsonKey(
    name: 'osm_id',
    defaultValue: -1,
  )
  int? osmId;
  @JsonKey(
    name: 'place_rank',
    defaultValue: -1,
  )
  int? placeRank;
  @JsonKey(
    name: 'category',
    defaultValue: '',
  )
  String? category;
  @JsonKey(
    name: 'type',
    defaultValue: '',
  )
  String? type;
  @JsonKey(
    name: 'address_type',
    defaultValue: '',
  )
  String? addressType;

//selectedMapAddress
  @JsonKey(
    name: 'display_address_name',
    defaultValue: '',
  )
  String? displayAddressName;

  Map<String, dynamic> toMap() => _$AddressBeanToJson(this);

  @override
  AddressBean fromJson(Map<String, dynamic> json) {
    return AddressBean.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() => toMap();
}
