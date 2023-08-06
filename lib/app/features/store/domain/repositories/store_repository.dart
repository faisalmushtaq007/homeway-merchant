part of 'package:homemakers_merchant/app/features/store/index.dart';

abstract interface class StoreRepository {
  Future<DataSourceState<StoreEntity>> saveStore({
    required StoreEntity storeEntity,
  });

  Future<DataSourceState<StoreEntity>> editStore({
    required StoreEntity storeEntity,
    required int storeID,
  });

  Future<DataSourceState<bool>> deleteStore({
    required int storeID,
    StoreEntity? storeEntity,
  });

  Future<DataSourceState<bool>> deleteAllStore();

  Future<DataSourceState<StoreEntity>> getStore({
    required int storeID,
    StoreEntity? storeEntity,
  });

  Future<DataSourceState<List<StoreEntity>>> getAllStore();

  //Driver
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> saveDriver({
    required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo,
  });

  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> editDriver({
    required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo,
    required int driverID,
  });

  Future<DataSourceState<bool>> deleteDriver({
    required int driverID,
    StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo,
  });

  Future<DataSourceState<bool>> deleteAllDriver();

  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> getDriver({
    required int driverID,
    StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo,
  });

  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver();

  Future<DataSourceState<List<StoreEntity>>> bindDriverWithStores({required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination});

  Future<DataSourceState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination});
}
