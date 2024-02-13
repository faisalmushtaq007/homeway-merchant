part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreRemoteDataSource implements StoreDataSource {
  final client = serviceLocator<IRestApiManager>();

  @override
  Future<ApiResultState<bool>> deleteAllStore() {
    // TODO(prasant): implement deleteAllStore
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteStore(
      {StoreEntity? storeEntity, required int storeID}) async {
    try {
      final response = await client.send(
        GlobalApp.businessCollection,
        method: RequestType.PUT,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<BusinessProfileEntity>.success(
          data: BusinessProfileEntity.fromMap(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<BusinessProfileEntity>.failure(
          reason: GetApiException()
              .handleApiFailure(
                error?.model,
                statusCode: error?.statusCode,
              )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<BusinessProfileEntity>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<StoreEntity>> editStore(
      {required StoreEntity storeEntity}) async {
    try {
      final response = await client.send(
        GlobalApp.storeCollection,
        method: RequestType.PUT,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<StoreEntity>.success(
          data: BusinessProfileEntity.fromMap(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<StoreEntity>.failure(
          reason: GetApiException()
              .handleApiFailure(
                error?.model,
                statusCode: error?.statusCode,
              )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<StoreEntity>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> getAllStore() async {
    try {
      final response = await client.send(
        GlobalApp.storeCollection,
        method: RequestType.GET,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<List<StoreEntity>>.success(
          data: response.data?.data
              .map((e) => StoreEntity.fromMap(e as Map))
              .toList()
              .cast<StoreEntity>(),
        );
      } else {
        final error = response.error;
        return ApiResultState<List<StoreEntity>>.failure(
          reason: GetApiException()
              .handleApiFailure(
                error?.model,
                statusCode: error?.statusCode,
              )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<List<StoreEntity>>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<StoreEntity>> getStore(
      {StoreEntity? storeEntity, required int storeID}) async {
    try {
      final response = await client.send(
        GlobalApp.storeCollection,
        method: RequestType.GET,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<StoreEntity>.success(
          data: StoreEntity.fromMap(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<StoreEntity>.failure(
          reason: GetApiException()
              .handleApiFailure(
                error?.model,
                statusCode: error?.statusCode,
              )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<StoreEntity>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<StoreEntity>> saveStore(
      {required StoreEntity storeEntity}) async {
    try {
      final response = await client.send(
        GlobalApp.storeCollection,
        method: RequestType.POST,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<StoreEntity>.success(
          data: StoreEntity.fromMap(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<StoreEntity>.failure(
          reason: GetApiException()
              .handleApiFailure(
                error?.model,
                statusCode: error?.statusCode,
              )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<StoreEntity>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> bindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required List<StoreEntity> destination}) {
    // TODO(prasant): implement bindDriverWithStores
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllDriver() {
    // TODO(prasant): implement deleteAllDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteDriver(
      {required int driverID,
      StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) {
    // TODO(prasant): implement deleteDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> editDriver(
      {required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo,
      required int driverID}) {
    // TODO(prasant): implement editDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver() {
    // TODO(prasant): implement getAllDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> getDriver(
      {required int driverID,
      StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) {
    // TODO(prasant): implement getDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<StoreOwnDeliveryPartnersInfo>> saveDriver(
      {required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo}) {
    // TODO(prasant): implement saveDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required List<StoreEntity> destination}) {
    // TODO(prasant): implement unBindDriverWithStores
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> bindDriverWithUser(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required AppUserEntity destination}) {
    // TODO: implement bindDriverWithUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> bindStoreWithUser(
      {required List<StoreEntity> source, required AppUserEntity destination}) {
    // TODO: implement bindStoreWithUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> unBindDriversWithUser(
      {required List<StoreOwnDeliveryPartnersInfo> source,
      required AppUserEntity destination}) {
    // TODO: implement unBindDriversWithUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> unBindStoreWithUser(
      {required List<StoreEntity> source, required AppUserEntity destination}) {
    // TODO: implement unBindStoreWithUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreOwnDeliveryPartnersInfo>>>
      getAllDriversPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    StoreOwnDeliveryPartnersInfo? drivers,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) {
    // TODO: implement getAllDriversPagination
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> getAllStorePagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    StoreEntity? stores,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) {
    // TODO: implement getAllStorePagination
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreOwnDeliveryPartnersInfo>>> saveAllDriver({
    required List<StoreOwnDeliveryPartnersInfo> drivers,
    bool hasUpdateAll = false,
  }) {
    // TODO: implement saveAllDriver
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> saveAllStore({
    required List<StoreEntity> stores,
    bool hasUpdateAll = false,
  }) {
    // TODO: implement saveAllStore
    throw UnimplementedError();
  }
}
