part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreRemoteDataSource implements StoreDataSource {
  final client = serviceLocator<INetworkManager<BaseResponseErrorModel>>();
  @override
  Future<ApiResultState<bool>> deleteAllStore() {
    // TODO(prasant): implement deleteAllStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteStore({StoreEntity? storeEntity, required int storeID}) {
    // TODO(prasant): implement deleteStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreEntity>> editStore({required StoreEntity storeEntity}) {
    // TODO(prasant): implement editStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> getAllStore() {
    // TODO(prasant): implement getAllStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreEntity>> getStore({StoreEntity? storeEntity, required int storeID}) {
    // TODO(prasant): implement getStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreEntity>> saveStore({required StoreEntity storeEntity}) {
    // TODO(prasant): implement saveStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> bindDriverWithStores({required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    // TODO(prasant): implement bindDriverWithStores
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllDriver() {
    // TODO(prasant): implement deleteAllDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteDriver({required int driverID, StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) {
    // TODO(prasant): implement deleteDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> editDriver({required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo, required int driverID}) {
    // TODO(prasant): implement editDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver() {
    // TODO(prasant): implement getAllDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> getDriver({required int driverID, StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) {
    // TODO(prasant): implement getDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> saveDriver({required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo}) {
    // TODO(prasant): implement saveDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    // TODO(prasant): implement unBindDriverWithStores
    throw UnimplementedError();
  }
}
