part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreRepositoryImplement implements StoreRepository {
  const StoreRepositoryImplement({
    required this.remoteDataSource,
    required this.storeLocalDataSource,
    required this.driverLocalDataSource,
  });

  final StoreDataSource remoteDataSource;
  final StoreLocalDbRepository<StoreEntity> storeLocalDataSource;
  final StoreOwnDeliveryPartnersLocalDbRepository<StoreOwnDeliveryPartnersInfo> driverLocalDataSource;

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
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreEntity>> editStore({
    required StoreEntity storeEntity,
    required int storeID,
  }) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        Either<RepositoryBaseFailure, StoreEntity> result;
        result = await serviceLocator<StoreLocalDbRepository>().update(storeEntity, UniqueId(storeID));
        return result.fold((l) {
          RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Update Store error ${l.toString()}, ${l.message}');
          return DataSourceState<StoreEntity>.error(
            reason: l.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: l.stacktrace,
          );
        }, (r) {
          appLog.d('Update StoreID : ${r.storeID}, ${r.storeName}');
          return DataSourceState<StoreEntity>.localDb(data: r);
        });
      } else {
        appLog.d('Update ELSE');
        return DataSourceState<StoreEntity>.remote(
          data: storeEntity,
        );
      }
    } catch (e, s) {
      appLog.d('Update Error ${e}');
      return DataSourceState<StoreEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> getAllStore() async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        Either<RepositoryBaseFailure, List<StoreEntity>> result;
        result = await serviceLocator<StoreLocalDbRepository>().getAll();
        return result.fold((l) {
          RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get All Store error ${l.toString()}, ${l.message}');
          return DataSourceState<List<StoreEntity>>.error(
            reason: l.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: l.stacktrace,
          );
        }, (r) {
          appLog.d('Get All Store length : ${r.length}');
          return DataSourceState<List<StoreEntity>>.localDb(data: r);
        });
      } else {
        appLog.d('Get All Store ELSE');
        return const DataSourceState<List<StoreEntity>>.remote(
          data: [],
        );
      }
    } catch (e, s) {
      appLog.d('Get All Store Error ${e}');
      return DataSourceState<List<StoreEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<StoreEntity>> getStore({StoreEntity? storeEntity, required int storeID}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreEntity>> saveStore({required StoreEntity storeEntity}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        Either<RepositoryBaseFailure, StoreEntity> result;
        result = await serviceLocator<StoreLocalDbRepository>().add(storeEntity);
        return result.fold((l) {
          RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save Store error ${l.toString()}, ${l.message}');
          return DataSourceState<StoreEntity>.error(
            reason: l.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: l.stacktrace,
          );
        }, (r) {
          appLog.d('Save StoreID : ${r.storeID}, ${r.storeName}');
          return DataSourceState<StoreEntity>.localDb(data: r);
        });
      } else {
        appLog.d('Save ELSE');
        return DataSourceState<StoreEntity>.remote(
          data: storeEntity,
        );
      }
    } catch (e, s) {
      appLog.d('Save Error ${e}');
      return DataSourceState<StoreEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  // Driver
  @override
  Future<DataSourceState<List<StoreEntity>>> bindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteAllDriver() {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteDriver({StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo, required int driverID}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> editDriver(
      {required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo, required int driverID}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver() {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> getDriver({StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo, required int driverID}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> saveDriver({required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

// Driver
}
