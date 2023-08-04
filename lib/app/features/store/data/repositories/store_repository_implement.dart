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
  Future<ResultState<bool>> deleteAllStore() {
    // TODO: implement deleteAllStore
    throw UnimplementedError();
  }

  @override
  Future<ResultState<bool>> deleteStore({StoreEntity? storeEntity, required int storeID}) {
    // TODO: implement deleteStore
    throw UnimplementedError();
  }

  @override
  Future<ResultState<StoreEntity>> editStore({required StoreEntity storeEntity}) {
    // TODO: implement editStore
    throw UnimplementedError();
  }

  @override
  Future<ResultState<StoreEntity>> getAllStore() {
    // TODO: implement getAllStore
    throw UnimplementedError();
  }

  @override
  Future<ResultState<StoreEntity>> getStore({StoreEntity? storeEntity, required int storeID}) {
    // TODO: implement getStore
    throw UnimplementedError();
  }

  @override
  Future<ResultState<StoreEntity>> saveStore({required StoreEntity storeEntity}) {
    // TODO: implement saveStore
    throw UnimplementedError();
  }
}
