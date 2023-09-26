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

  Future<DataSourceState<List<StoreEntity>>> bindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required List<StoreEntity> destination});

  Future<DataSourceState<List<StoreEntity>>> unBindDriverWithStores({
    required List<StoreOwnDeliveryPartnersInfo> source,
    required List<StoreEntity> destination,
  });

  // With User
  Future<DataSourceState<AppUserEntity>> bindDriverWithUser(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required AppUserEntity destination});

  Future<DataSourceState<AppUserEntity>> unBindDriverWithUser({
    required List<StoreOwnDeliveryPartnersInfo> source,
    required AppUserEntity destination,
  });

  Future<DataSourceState<AppUserEntity>> bindStoreWithUser(
      {required List<StoreEntity> source, required AppUserEntity destination});

  Future<DataSourceState<AppUserEntity>> unBindStoreWithUser({
    required List<StoreEntity> source,
    required AppUserEntity destination,
  });

  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriverPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    StoreOwnDeliveryPartnersInfo? driverEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
  Future<DataSourceState<List<StoreEntity>>> getAllStorePagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    StoreEntity? storeEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> saveAllDriver({
    required List<StoreOwnDeliveryPartnersInfo> drivers,
    bool hasUpdateAll = false,
  });
  Future<DataSourceState<List<StoreEntity>>> saveAllStore({
    required List<StoreEntity> stores,
    bool hasUpdateAll = false,
  });
}
