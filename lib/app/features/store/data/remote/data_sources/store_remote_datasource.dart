part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreRemoteDataSource implements StoreDataSource {
  final client = serviceLocator<INetworkManager<BaseResponseErrorModel>>();
  @override
  Future<ApiResultState<bool>> deleteAllStore() {
    // TODO: implement deleteAllStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteStore({StoreEntity? storeEntity, required int storeID}) {
    // TODO: implement deleteStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreEntity>> editStore({required StoreEntity storeEntity}) {
    // TODO: implement editStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> getAllStore() {
    // TODO: implement getAllStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreEntity>> getStore({StoreEntity? storeEntity, required int storeID}) {
    // TODO: implement getStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreEntity>> saveStore({required StoreEntity storeEntity}) {
    // TODO: implement saveStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> bindDriverWithStores({required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    // TODO: implement bindDriverWithStores
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllDriver() {
    // TODO: implement deleteAllDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteDriver({required int driverID, StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) {
    // TODO: implement deleteDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> editDriver({required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo, required int driverID}) {
    // TODO: implement editDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver() {
    // TODO: implement getAllDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> getDriver({required int driverID, StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) {
    // TODO: implement getDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> saveDriver({required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo}) {
    // TODO: implement saveDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    // TODO: implement unBindDriverWithStores
    throw UnimplementedError();
  }
}
