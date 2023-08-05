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
    StoreEntity? storeEntity,
    required int storeID,
  });

  Future<DataSourceState<bool>> deleteAllStore();

  Future<DataSourceState<StoreEntity>> getStore({
    StoreEntity? storeEntity,
    required int storeID,
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
    StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo,
    required int driverID,
  });

  Future<DataSourceState<bool>> deleteAllDriver();

  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> getDriver({
    StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo,
    required int driverID,
  });

  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver();

  Future<DataSourceState<List<StoreEntity>>> bindDriverWithStores({required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination});

  Future<DataSourceState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination});
}
