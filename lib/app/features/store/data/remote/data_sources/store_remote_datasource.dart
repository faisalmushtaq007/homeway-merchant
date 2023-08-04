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
  Future<ApiResultState<StoreEntity>> getAllStore() {
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
}
