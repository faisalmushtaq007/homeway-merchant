part of 'package:homemakers_merchant/app/features/store/index.dart';

abstract interface class StoreDataSource {
  Future<ApiResultState<StoreEntity>> saveStore({
    required StoreEntity storeEntity,
  });

  Future<ApiResultState<StoreEntity>> editStore({
    required StoreEntity storeEntity,
  });

  Future<ApiResultState<bool>> deleteStore({
    StoreEntity? storeEntity,
    required int storeID,
  });

  Future<ApiResultState<bool>> deleteAllStore();

  Future<ApiResultState<StoreEntity>> getStore({
    StoreEntity? storeEntity,
    required int storeID,
  });

  Future<ApiResultState<StoreEntity>> getAllStore();
}
