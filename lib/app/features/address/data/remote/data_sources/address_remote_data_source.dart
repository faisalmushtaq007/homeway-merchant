part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressRemoteDataSource implements AddressDataSource {
  final client = serviceLocator<INetworkManager<BaseApiResponseErrorModel>>();
  @override
  Future<ApiResultState<bool>> deleteAddress(
      {required int addressID,
      AddressModel? addressEntity,
      AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAddress
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllAddress(
      {AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllAddress
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AddressModel>> editAddress(
      {required AddressModel addressEntity,
      required int addressID,
      AppUserEntity? appUserEntity}) {
    // TODO: implement editAddress
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AddressModel>> getAddress(
      {required int addressID,
      AppUserEntity? appUserEntity,
      AddressModel? addressEntity}) {
    // TODO: implement getAddress
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AddressModel>>> getAllAddress(
      {AppUserEntity? appUserEntity}) {
    // TODO: implement getAllAddress
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AddressModel>> saveAddress(
      {required AddressModel addressEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement saveAddress
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AddressModel>>> getAllAddressPagination(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      AddressModel? addressEntity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) {
    // TODO: implement getAllAddressPagination
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AddressModel>>> saveAllAddress(
      {required List<AddressModel> addressEntities,
      bool hasUpdateAll = false}) {
    // TODO: implement saveAllCategory
    throw UnimplementedError();
  }
}
