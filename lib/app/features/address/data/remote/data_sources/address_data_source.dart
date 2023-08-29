part of 'package:homemakers_merchant/app/features/address/index.dart';

abstract interface class AddressDataSource {
  Future<ApiResultState<AddressModel>> saveAddress({
    required AddressModel addressEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<AddressModel>> editAddress({
    required AddressModel addressEntity,
    required int addressID,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<bool>> deleteAddress({
    required int addressID,
    AddressModel? addressEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<bool>> deleteAllAddress({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<AddressModel>> getAddress({
    required int addressID,
    AppUserEntity? appUserEntity,
    AddressModel? addressEntity,
  });

  Future<ApiResultState<List<AddressModel>>> getAllAddress({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<List<AddressModel>>> getAllAddressPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    AddressModel? addressEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
  Future<ApiResultState<List<AddressModel>>> saveAllAddress({
    required List<AddressModel> addressEntities,
    bool hasUpdateAll = false,
  });
}
