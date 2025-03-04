part of 'package:homemakers_merchant/app/features/address/index.dart';

abstract interface class UserAddressRepository {
  Future<DataSourceState<AddressModel>> saveAddress({
    required AddressModel addressEntity,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<AddressModel>> editAddress({
    required AddressModel addressEntity,
    required int addressID,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deleteAddress({
    required int addressID,
    AddressModel? addressEntity,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deleteAllAddress({
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<AddressModel>> getAddress({
    required int addressID,
    AppUserEntity? appUserEntity,
    AddressModel? addressEntity,
  });

  Future<DataSourceState<List<AddressModel>>> getAllAddress({
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<List<AddressModel>>> getAllAddressPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    AddressModel? addressEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<AddressModel>>> saveAllAddress({
    required List<AddressModel> addressEntities,
    bool hasUpdateAll = false,
  });
}
