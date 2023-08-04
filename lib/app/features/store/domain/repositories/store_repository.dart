part of 'package:homemakers_merchant/app/features/store/index.dart';

abstract interface class StoreRepository {
  Future<ResultState<StoreEntity>> saveStore({
    required StoreEntity storeEntity,
  });

  Future<ResultState<StoreEntity>> editStore({
    required StoreEntity storeEntity,
  });

  Future<ResultState<bool>> deleteStore({
    StoreEntity? storeEntity,
    required int storeID,
  });

  Future<ResultState<bool>> deleteAllStore();

  Future<ResultState<StoreEntity>> getStore({
    StoreEntity? storeEntity,
    required int storeID,
  });

  Future<ResultState<StoreEntity>> getAllStore();
}
