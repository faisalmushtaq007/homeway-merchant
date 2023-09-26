part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreRepositoryImplement implements StoreRepository {
  const StoreRepositoryImplement({
    required this.remoteDataSource,
    required this.storeLocalDataSource,
    required this.driverLocalDataSource,
    required this.storeBindingWithUserLocalDataSource,
    required this.storeOwnDriverBindingWithCurrentUserLocalDataSource,
    required this.storeOwnDriverBindingWithStoreLocalDataSource,
  });

  final StoreDataSource remoteDataSource;
  final StoreLocalDbRepository<StoreEntity> storeLocalDataSource;
  final StoreOwnDeliveryPartnersLocalDbRepository<StoreOwnDeliveryPartnersInfo> driverLocalDataSource;
  final StoreBindingWithUserLocalDbRepository<StoreEntity, AppUserEntity> storeBindingWithUserLocalDataSource;
  final StoreOwnDriverBindingWithStoreLocalDbRepository<StoreOwnDeliveryPartnersInfo, StoreEntity>
      storeOwnDriverBindingWithStoreLocalDataSource;
  final StoreOwnDriverBindingWithCurrentUserLocalDbRepository<StoreOwnDeliveryPartnersInfo, AppUserEntity>
      storeOwnDriverBindingWithCurrentUserLocalDataSource;

  @override
  Future<DataSourceState<bool>> deleteAllStore() async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await storeLocalDataSource.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all store local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all store to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllStore();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all store to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all Store remote error $reason');
            return DataSourceState<bool>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Delete all store exception $e');
      return DataSourceState<bool>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<bool>> deleteStore({
    required int storeID,
    StoreEntity? storeEntity,
  }) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await storeLocalDataSource.deleteById(UniqueId(storeID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete Store local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete store to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result =
            await remoteDataSource.deleteStore(storeID: storeID, storeEntity: storeEntity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete store to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete Store remote error $reason');
            return DataSourceState<bool>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Delete store exception $e');
      return DataSourceState<bool>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<StoreEntity>> editStore({
    required StoreEntity storeEntity,
    required int storeID,
  }) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, StoreEntity> result =
            await storeLocalDataSource.update(storeEntity, UniqueId(storeID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit store local error ${failure.message}');
          return DataSourceState<StoreEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit store local : ${r.storeID}, ${r.storeName}');
          return DataSourceState<StoreEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<StoreEntity> result = await remoteDataSource.editStore(storeEntity: storeEntity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit store to remote');
            return DataSourceState<StoreEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit store remote error $reason');
            return DataSourceState<StoreEntity>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Edit store exception $e');
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
    /*try {*/
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
      // Local DB
      // Save to local
      final Either<RepositoryBaseFailure, List<StoreEntity>> result = await storeLocalDataSource.getAll();
      // Return result
      return result.fold((l) {
        final RepositoryFailure failure = l as RepositoryFailure;
        appLog.d('Get all store local error ${failure.message}');
        return DataSourceState<List<StoreEntity>>.error(
          reason: failure.message,
          dataSourceFailure: DataSourceFailure.local,
          stackTrace: failure.stacktrace,
        );
      }, (r) {
        appLog.d('Get all store local : ${r.length}');
        return DataSourceState<List<StoreEntity>>.localDb(data: r);
      });
    } else {
      // Remote
      // Save to server
      final ApiResultState<List<StoreEntity>> result = await remoteDataSource.getAllStore();
      // Return result
      return result.when(
        success: (data) {
          appLog.d('Get all store from remote');
          return DataSourceState<List<StoreEntity>>.remote(
            data: data.toList(),
          );
        },
        failure: (reason, error, exception, stackTrace) {
          appLog.d('Get all store remote error $reason');
          return DataSourceState<List<StoreEntity>>.error(
            reason: reason,
            dataSourceFailure: DataSourceFailure.remote,
            stackTrace: stackTrace,
            error: error,
            networkException: exception,
          );
        },
      );
    }
    /*} catch (e, s) {
      appLog.e('Get all store exception $e');
      return DataSourceState<List<StoreEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }*/
  }

  @override
  Future<DataSourceState<StoreEntity>> getStore({required int storeID, StoreEntity? storeEntity}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, StoreEntity?> result =
            await storeLocalDataSource.getById(UniqueId(storeID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get store local error ${failure.message}');
          return DataSourceState<StoreEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get store to local : ${r?.storeID}, ${r?.storeName}');
          return DataSourceState<StoreEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<StoreEntity> result = await remoteDataSource.getStore(
          storeEntity: storeEntity,
          storeID: storeID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get store to remote');
            return DataSourceState<StoreEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get store remote error $reason');
            return DataSourceState<StoreEntity>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.d('Get store exception $e');
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
  Future<DataSourceState<StoreEntity>> saveStore({required StoreEntity storeEntity}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, StoreEntity> result = await storeLocalDataSource.add(storeEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save store local error ${failure.message}');
          return DataSourceState<StoreEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save store to local : ${r.storeID}, ${r.storeName}');
          return DataSourceState<StoreEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<StoreEntity> result = await remoteDataSource.saveStore(storeEntity: storeEntity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save store to remote');
            return DataSourceState<StoreEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save store remote error $reason');
            return DataSourceState<StoreEntity>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.d('Save store exception $e');
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
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreEntity>> result =
            await storeOwnDriverBindingWithStoreLocalDataSource.binding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Binding driver with store local error ${failure.message}');
          return DataSourceState<List<StoreEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Binding driver with store local :');
          return DataSourceState<List<StoreEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreEntity>> result = await remoteDataSource.bindDriverWithStores(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Binding driver with store to remote');
            return DataSourceState<List<StoreEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Binding driver with store remote error $reason');
            return DataSourceState<List<StoreEntity>>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Binding driver with store exception $e');
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
  Future<DataSourceState<bool>> deleteAllDriver() async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await driverLocalDataSource.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all driver local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all river to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllDriver();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all driver to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all river remote error $reason');
            return DataSourceState<bool>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Delete all driver exception $e');
      return DataSourceState<bool>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<bool>> deleteDriver(
      {required int driverID, StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await driverLocalDataSource.deleteById(UniqueId(driverID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete driver local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete driver to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteDriver(
          driverID: driverID,
          storeOwnDeliveryPartnersInfo: storeOwnDeliveryPartnersInfo,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete driver to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete driver remote error $reason');
            return DataSourceState<bool>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Delete driver exception $e');
      return DataSourceState<bool>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> editDriver(
      {required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo, required int driverID}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo> result =
            await driverLocalDataSource.update(storeOwnDeliveryPartnersInfo, UniqueId(driverID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit driver local error ${failure.message}');
          return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit driver local : ${r.driverID}, ${r.driverName}');
          return DataSourceState<StoreOwnDeliveryPartnersInfo>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<StoreOwnDeliveryPartnersInfo> result = await remoteDataSource.editDriver(
          storeOwnDeliveryPartnersInfo: storeOwnDeliveryPartnersInfo,
          driverID: driverID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit driver to remote');
            return DataSourceState<StoreOwnDeliveryPartnersInfo>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit driver remote error $reason');
            return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Edit store exception $e');
      return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriver() async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreOwnDeliveryPartnersInfo>> result =
            await driverLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all driver local error ${failure.message}');
          return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all driver local : ${r.length}');
          return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreOwnDeliveryPartnersInfo>> result = await remoteDataSource.getAllDriver();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all driver from remote');
            return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all driver remote error $reason');
            return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Get all driver exception $e');
      return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> getDriver(
      {required int driverID, StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo?> result =
            await driverLocalDataSource.getById(UniqueId(driverID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get driver local error ${failure.message}');
          return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get driver to local : ${r?.driverID}, ${r?.driverName}');
          return DataSourceState<StoreOwnDeliveryPartnersInfo>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<StoreOwnDeliveryPartnersInfo> result = await remoteDataSource.getDriver(
          storeOwnDeliveryPartnersInfo: storeOwnDeliveryPartnersInfo,
          driverID: driverID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get driver to remote');
            return DataSourceState<StoreOwnDeliveryPartnersInfo>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get driver remote error $reason');
            return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.d('Get driver exception $e');
      return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> saveDriver(
      {required StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnersInfo}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo> result =
            await driverLocalDataSource.add(storeOwnDeliveryPartnersInfo);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save driver local error ${failure.message}');
          return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save driver to local : ${r.driverID}, ${r.driverName}');
          return DataSourceState<StoreOwnDeliveryPartnersInfo>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<StoreOwnDeliveryPartnersInfo> result =
            await remoteDataSource.saveDriver(storeOwnDeliveryPartnersInfo: storeOwnDeliveryPartnersInfo);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save driver to remote');
            return DataSourceState<StoreOwnDeliveryPartnersInfo>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save driver remote error $reason');
            return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.d('Save driver exception $e');
      return DataSourceState<StoreOwnDeliveryPartnersInfo>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> unBindDriverWithStores(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreEntity>> result =
            await storeOwnDriverBindingWithStoreLocalDataSource.unbinding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('UnBinding driver with store local error ${failure.message}');
          return DataSourceState<List<StoreEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('UnBinding driver with store local :');
          return DataSourceState<List<StoreEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreEntity>> result = await remoteDataSource.unBindDriverWithStores(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('UnBinding driver with store to remote');
            return DataSourceState<List<StoreEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('UnBinding driver with store remote error $reason');
            return DataSourceState<List<StoreEntity>>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('UnBinding driver with store exception $e');
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
  Future<DataSourceState<AppUserEntity>> bindDriverWithUser(
      {required List<StoreOwnDeliveryPartnersInfo> source, required AppUserEntity destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity> result =
            await storeOwnDriverBindingWithCurrentUserLocalDataSource.binding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Binding driver with user local error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Binding driver with user local :');
          return DataSourceState<AppUserEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity> result = await remoteDataSource.bindDriverWithUser(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Binding driver with user to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Binding driver with user remote error $reason');
            return DataSourceState<AppUserEntity>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Binding driver with user exception $e');
      return DataSourceState<AppUserEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<AppUserEntity>> bindStoreWithUser(
      {required List<StoreEntity> source, required AppUserEntity destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity> result =
            await storeBindingWithUserLocalDataSource.binding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Binding stores with user local error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Binding stores with user local :');
          return DataSourceState<AppUserEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity> result = await remoteDataSource.bindStoreWithUser(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Binding stores with user to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Binding stores with user remote error $reason');
            return DataSourceState<AppUserEntity>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Binding stores with user exception $e');
      return DataSourceState<AppUserEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<AppUserEntity>> unBindDriverWithUser(
      {required List<StoreOwnDeliveryPartnersInfo> source, required AppUserEntity destination}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<AppUserEntity>> unBindStoreWithUser(
      {required List<StoreEntity> source, required AppUserEntity destination}) {
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
    } else {}
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> getAllDriverPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    StoreOwnDeliveryPartnersInfo? driverEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    try {
      final connectivity =
      serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreOwnDeliveryPartnersInfo>> result =
        await driverLocalDataSource.getAllWithPagination(
          filter: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          endTimeStamp: endTime,
          startTimeStamp: startTime,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all StoreOwnDeliveryPartnersInfo local error ${failure.message}');
          return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all StoreOwnDeliveryPartnersInfo local : ${r.length}');
          return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreOwnDeliveryPartnersInfo>> result =
        await remoteDataSource.getAllDriversPagination(
          filtering: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          drivers: driverEntity,
          endTime: endTime,
          startTime: startTime,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all StoreOwnDeliveryPartnersInfo from remote');
            return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all StoreOwnDeliveryPartnersInfo remote error $reason');
            return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Get all StoreOwnDeliveryPartnersInfo exception $e');
      return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> getAllStorePagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    StoreEntity? storeEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    try {
      final connectivity =
      serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreEntity>> result =
        await storeLocalDataSource.getAllWithPagination(
          filter: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          endTimeStamp: endTime,
          startTimeStamp: startTime,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all StoreEntity local error ${failure.message}');
          return DataSourceState<List<StoreEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all StoreEntity local : ${r.length}');
          return DataSourceState<List<StoreEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreEntity>> result =
        await remoteDataSource.getAllStorePagination(
          filtering: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          stores: storeEntity,
          endTime: endTime,
          startTime: startTime,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all StoreEntity from remote');
            return DataSourceState<List<StoreEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all StoreEntity remote error $reason');
            return DataSourceState<List<StoreEntity>>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Get all StoreEntity exception $e');
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
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> saveAllDriver({
    required List<StoreOwnDeliveryPartnersInfo> drivers,
    bool hasUpdateAll = false,
  }) async {
    try {
      final connectivity =
      serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreOwnDeliveryPartnersInfo>> result =
        await driverLocalDataSource.saveAll(
          entities: drivers.toList(),
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all StoreOwnDeliveryPartnersInfo local error ${failure.message}');
          return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all StoreOwnDeliveryPartnersInfo to local : ${r?.length},');
          return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreOwnDeliveryPartnersInfo>> result =
        await remoteDataSource.saveAllDriver(
          drivers: drivers.toList(),
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all StoreOwnDeliveryPartnersInfo to remote');
            return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all StoreOwnDeliveryPartnersInfo remote error $reason');
            return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.d('Save all StoreOwnDeliveryPartnersInfo exception $e');
      return DataSourceState<List<StoreOwnDeliveryPartnersInfo>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> saveAllStore({
    required List<StoreEntity> stores,
    bool hasUpdateAll = false,
  }) async {
    try {
      final connectivity =
      serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreEntity>> result =
        await storeLocalDataSource.saveAll(
          entities: stores,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all StoreEntity local error ${failure.message}');
          return DataSourceState<List<StoreEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all StoreEntity to local : ${r?.length},');
          return DataSourceState<List<StoreEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreEntity>> result =
        await remoteDataSource.saveAllStore(
          stores: stores.toList(),
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all StoreEntity to remote');
            return DataSourceState<List<StoreEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all StoreEntity remote error $reason');
            return DataSourceState<List<StoreEntity>>.error(
              reason: reason,
              dataSourceFailure: DataSourceFailure.remote,
              stackTrace: stackTrace,
              error: error,
              networkException: exception,
            );
          },
        );
      }
    } catch (e, s) {
      appLog.d('Save all StoreEntity exception $e');
      return DataSourceState<List<StoreEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

// Driver
}
