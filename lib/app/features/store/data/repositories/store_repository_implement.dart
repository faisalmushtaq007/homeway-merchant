part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreRepositoryImplement implements StoreRepository {
  const StoreRepositoryImplement({
    required this.remoteDataSource,
    required this.storeLocalDataSource,
    required this.driverLocalDataSource,
  });
  final StoreDataSource remoteDataSource;
  final BaseStoreLocalDbRepository storeLocalDataSource;
  final BaseStoreOwnDriverLocalDbRepository driverLocalDataSource;
  @override
  Future<DataSourceState<bool>> deleteAllStore() {
    // TODO: implement deleteAllStore
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteStore({
    StoreEntity? storeEntity,
    required int storeID,
  }) {
    // TODO: implement deleteStore
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreEntity>> editStore({
    required StoreEntity storeEntity,
    required int storeID,
  }) {
    // TODO: implement editStore
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreEntity>> getAllStore() {
    // TODO: implement getAllStore
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreEntity>> getStore({StoreEntity? storeEntity, required int storeID}) {
    // TODO: implement getStore
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreEntity>> saveStore({required StoreEntity storeEntity}) {
    // TODO: implement saveStore
    throw UnimplementedError();
  }

  // Driver
  @override
  Future<DataSourceState<List<StoreEntity>>> bindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    // TODO: implement bindDriverWithStores
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteAllDriver() {
    // TODO: implement deleteAllDriver
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteDriver({StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo, required int driverID}) {
    // TODO: implement deleteDriver
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> editDriver(
      {required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo, required int driverID}) {
    // TODO: implement editDriver
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver() {
    // TODO: implement getAllDriver
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> getDriver({StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo, required int driverID}) {
    // TODO: implement getDriver
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> saveDriver({required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo}) {
    // TODO: implement saveDriver
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    // TODO: implement unBindDriverWithStores
    throw UnimplementedError();
  }

  // Driver
}
