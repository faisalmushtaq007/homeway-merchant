part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressModel extends INetworkModel<AddressModel> {
  AddressModel({
    this.addressID = -1,
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

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressID: json['addressID'] as int? ?? -1,
        isDefault: json['isDefault'] as bool? ?? false,
        countryDialCode: json['country_dial_code'] as String? ?? '',
        address: json['address'] == null
            ? AddressBean()
            : AddressBean.fromJson(json['address'] as Map<String, dynamic>),
        addressRefId: json['address_ref_id'] as String? ?? '',
        isoCode: json['iso_code'] as String? ?? '',
        phoneNumber: json['phone_number'] as String? ?? '',
        userId: json['user_id'] as int? ?? -1,
        fullName: json['full_name'] as String? ?? '',
        createdAt: json['createdAt'] as int? ?? -1,
        anonymousUserId: json['anonymous_user_id'] as String? ?? '',
        boundingbox: (json['boundingbox'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        updatedAt: json['updatedAt'] as int? ?? -1,
      );

  int addressID;

  String? addressRefId;

  String? anonymousUserId;

  int? userId;

  String? fullName;

  String? phoneNumber;

  String? countryDialCode;

  String? isoCode;

  int? createdAt;

  int? updatedAt;

  AddressBean? address;

  List<String>? boundingbox;

  bool? isDefault;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'addressID': this.addressID,
        'address_ref_id': this.addressRefId,
        'anonymous_user_id': this.anonymousUserId,
        'user_id': this.userId,
        'full_name': this.fullName,
        'phone_number': this.phoneNumber,
        'country_dial_code': this.countryDialCode,
        'iso_code': this.isoCode,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'address': this.address?.toJson() ?? <String, dynamic>{},
        'boundingbox': this.boundingbox,
        'isDefault': this.isDefault,
      };

  @override
  AddressModel fromJson(Map<String, dynamic> json) {
    return AddressModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() => toMap();

  AddressModel copyWith({
    int? addressID,
    String? addressRefId,
    String? anonymousUserId,
    int? userId,
    String? fullName,
    String? phoneNumber,
    String? countryDialCode,
    String? isoCode,
    int? createdAt,
    int? updatedAt,
    AddressBean? address,
    List<String>? boundingbox,
    bool? isDefault,
  }) {
    return AddressModel(
      addressID: addressID ?? this.addressID,
      addressRefId: addressRefId ?? this.addressRefId,
      anonymousUserId: anonymousUserId ?? this.anonymousUserId,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryDialCode: countryDialCode ?? this.countryDialCode,
      isoCode: isoCode ?? this.isoCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
      boundingbox: boundingbox ?? this.boundingbox,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

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

  factory AddressBean.fromJson(Map<String, Object?> json) => AddressBean(
        latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
        state: json['state'] as String? ?? '',
        category: json['category'] as String? ?? '',
        city: json['city'] as String? ?? '',
        area: json['area'] as String? ?? '',
        landmark: json['landmark'] as String? ?? '',
        country: json['country'] as String? ?? '',
        district: json['district'] as String? ?? '',
        isDefault: json['isDefault'] as bool? ?? false,
        addressType: json['address_type'] as String? ?? '',
        indexOfSavedAddressAs: json['index_of_saved_address'] as int? ?? -1,
        countryCode: json['country_code'] as int? ?? -1,
        placeId: json['place_id'] as int? ?? -1,
        apartment: json['apartment'] as String? ?? '',
        postalCode: json['postal_code'] as int? ?? -1,
        displayAddressName: json['display_address_name'] as String? ?? '',
        savedAddressAs: json['saved_address_as'] as String? ?? '',
        placeRank: json['place_rank'] as int? ?? -1,
        village: json['village'] as String? ?? '',
        type: json['type'] as String? ?? '',
        town: json['town'] as String? ?? '',
        suburb: json['suburb'] as String? ?? '',
        stateDistrict: json['state_district'] as String? ?? '',
        road: json['road'] as String? ?? '',
        osmType: json['osm_type'] as String? ?? '',
        municipality: json['municipality'] as String? ?? '',
        county: json['county'] as String? ?? '',
        cityDistrict: json['city_district'] as String? ?? '',
        cityCode: json['city_code'] as int? ?? -1,
        osmId: json['osm_id'] as int? ?? -1,
        pickupAddress: json['pickup_address'] as String? ?? '',
        stateCode: json['state_code'] as int? ?? -1,
      );

  int? placeId;

  String? pickupAddress;

  String? apartment;

  String? area;

  String? landmark;

  String? district;

  int? postalCode;

  String? city;

  String? state;

  String? country;

  int? countryCode;

  int? cityCode;

  int? stateCode;

  bool? isDefault;

  String? savedAddressAs;

  int? indexOfSavedAddressAs;

  double? latitude;

  double? longitude;

  String? road;

  String? village;

  String? stateDistrict;

  String? cityDistrict;

  String? municipality;

  String? suburb;

  String? town;

  String? county;

  String? osmType;

  int? osmId;

  int? placeRank;

  String? category;

  String? type;

  String? addressType;

//selectedMapAddress

  String? displayAddressName;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'place_id': this.placeId ?? -1,
        'pickup_address': this.pickupAddress ?? '',
        'apartment': this.apartment ?? '',
        'area': this.area ?? '',
        'landmark': this.landmark ?? '',
        'district': this.district ?? '',
        'postal_code': this.postalCode ?? -1,
        'city': this.city ?? '',
        'state': this.state ?? '',
        'country': this.country ?? '',
        'country_code': this.countryCode ?? -1,
        'city_code': this.cityCode ?? -1,
        'state_code': this.stateCode ?? -1,
        'isDefault': this.isDefault ?? false,
        'saved_address_as': this.savedAddressAs ?? '',
        'index_of_saved_address': this.indexOfSavedAddressAs ?? -1,
        'latitude': this.latitude ?? 0.0,
        'longitude': this.longitude ?? 0.0,
        'road': this.road ?? '',
        'village': this.village ?? '',
        'state_district': this.stateDistrict ?? '',
        'city_district': this.cityDistrict ?? '',
        'municipality': this.municipality ?? '',
        'suburb': this.suburb ?? '',
        'town': this.town ?? '',
        'county': this.county ?? '',
        'osm_type': this.osmType ?? '',
        'osm_id': this.osmId ?? -1,
        'place_rank': this.placeRank ?? -1,
        'category': this.category ?? '',
        'type': this.type ?? '',
        'address_type': this.addressType ?? '',
        'display_address_name': this.displayAddressName ?? '',
      };

  @override
  AddressBean fromJson(Map<String, dynamic> json) {
    return AddressBean.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() => toMap();

  AddressBean copyWith({
    int? placeId,
    String? pickupAddress,
    String? apartment,
    String? area,
    String? landmark,
    String? district,
    int? postalCode,
    String? city,
    String? state,
    String? country,
    int? countryCode,
    int? cityCode,
    int? stateCode,
    bool? isDefault,
    String? savedAddressAs,
    int? indexOfSavedAddressAs,
    double? latitude,
    double? longitude,
    String? road,
    String? village,
    String? stateDistrict,
    String? cityDistrict,
    String? municipality,
    String? suburb,
    String? town,
    String? county,
    String? osmType,
    int? osmId,
    int? placeRank,
    String? category,
    String? type,
    String? addressType,
    String? displayAddressName,
  }) {
    return AddressBean(
      placeId: placeId ?? this.placeId,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      apartment: apartment ?? this.apartment,
      area: area ?? this.area,
      landmark: landmark ?? this.landmark,
      district: district ?? this.district,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      cityCode: cityCode ?? this.cityCode,
      stateCode: stateCode ?? this.stateCode,
      isDefault: isDefault ?? this.isDefault,
      savedAddressAs: savedAddressAs ?? this.savedAddressAs,
      indexOfSavedAddressAs:
          indexOfSavedAddressAs ?? this.indexOfSavedAddressAs,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      road: road ?? this.road,
      village: village ?? this.village,
      stateDistrict: stateDistrict ?? this.stateDistrict,
      cityDistrict: cityDistrict ?? this.cityDistrict,
      municipality: municipality ?? this.municipality,
      suburb: suburb ?? this.suburb,
      town: town ?? this.town,
      county: county ?? this.county,
      osmType: osmType ?? this.osmType,
      osmId: osmId ?? this.osmId,
      placeRank: placeRank ?? this.placeRank,
      category: category ?? this.category,
      type: type ?? this.type,
      addressType: addressType ?? this.addressType,
      displayAddressName: displayAddressName ?? this.displayAddressName,
    );
  }
}
