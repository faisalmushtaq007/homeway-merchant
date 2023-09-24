part of 'package:homemakers_merchant/app/features/store/index.dart';

abstract interface class StoreDataSource {
  Future<ApiResultState<StoreEntity>> saveStore({
    required StoreEntity storeEntity,
  });

  Future<ApiResultState<StoreEntity>> editStore({
    required StoreEntity storeEntity,
  });

  Future<ApiResultState<bool>> deleteStore({
    required int storeID,
    StoreEntity? storeEntity,
  });

  Future<ApiResultState<bool>> deleteAllStore();

  Future<ApiResultState<StoreEntity>> getStore({
    required int storeID,
    StoreEntity? storeEntity,
  });

  Future<ApiResultState<List<StoreEntity>>> getAllStore();

  // Driver
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> saveDriver({
    required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo,
  });

  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> editDriver({
    required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo,
    required int driverID,
  });

  Future<ApiResultState<bool>> deleteDriver({
    required int driverID,
    StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo,
  });

  Future<ApiResultState<bool>> deleteAllDriver();

  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> getDriver({
    required int driverID,
    StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo,
  });

  Future<ApiResultState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver();

  Future<ApiResultState<List<StoreEntity>>> bindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required List<StoreEntity> destination});

  Future<ApiResultState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required List<StoreEntity> destination});

  Future<ApiResultState<AppUserEntity>> bindDriverWithUser(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> unBindDriversWithUser(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> bindStoreWithUser(
      {required List<StoreEntity> source, required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> unBindStoreWithUser(
      {required List<StoreEntity> source, required AppUserEntity destination});
}
