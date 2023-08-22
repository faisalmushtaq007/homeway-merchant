part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderRepositoryImplement implements OrderRepository {
  const OrderRepositoryImplement({
    required this.remoteDataSource,
    required this.orderLocalDataSource,
  });

  final OrderDataSource remoteDataSource;
  final OrderLocalDbRepository<OrderEntity> orderLocalDataSource;
  @override
  Future<DataSourceState<bool>> deleteAllOrder({
    OrderType orderType = OrderType.none,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await orderLocalDataSource.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all profile local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all order to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllOrder();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all order to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all order remote error $reason');
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
      appLog.e('Delete all order exception $e');
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
  Future<DataSourceState<bool>> deleteOrder({
    required int orderID,
    OrderEntity? orderEntity,
    OrderType orderType = OrderType.none,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await orderLocalDataSource.deleteById(UniqueId(orderID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete order local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete order to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteOrder(
          orderID: orderID,
          orderEntity: orderEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete order to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete order remote error $reason');
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
      appLog.e('Delete order exception $e');
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
  Future<DataSourceState<OrderEntity>> editOrder({
    required OrderEntity orderEntity,
    required int orderID,
    OrderType orderType = OrderType.none,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, OrderEntity> result = await orderLocalDataSource.update(orderEntity, UniqueId(orderID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit order local error ${failure.message}');
          return DataSourceState<OrderEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit order local : ${r.orderID}');
          return DataSourceState<OrderEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<OrderEntity> result = await remoteDataSource.editOrder(
          orderID: orderID,
          orderEntity: orderEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit order to remote');
            return DataSourceState<OrderEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit order remote error $reason');
            return DataSourceState<OrderEntity>.error(
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
      appLog.e('Edit order exception $e');
      return DataSourceState<OrderEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<OrderEntity>>> getAllOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.none,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<OrderEntity>> result = await orderLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all order local error ${failure.message}');
          return DataSourceState<List<OrderEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all order local : ${r.length}');
          return DataSourceState<List<OrderEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<OrderEntity>> result = await remoteDataSource.getAllOrder();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all order from remote');
            return DataSourceState<List<OrderEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all order remote error $reason');
            return DataSourceState<List<OrderEntity>>.error(
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
      appLog.e('Get all order exception $e');
      return DataSourceState<List<OrderEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<OrderEntity>> getOrder({
    required int orderID,
    OrderEntity? orderEntity,
    OrderType orderType = OrderType.none,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, OrderEntity?> result = await orderLocalDataSource.getById(UniqueId(orderID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get order local error ${failure.message}');
          return DataSourceState<OrderEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get order to local : ${r?.orderID}, ${r?.orderDateTime.toUtc().toString()}');
          return DataSourceState<OrderEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<OrderEntity> result = await remoteDataSource.getOrder(
          orderID: orderID,
          orderEntity: orderEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get order to remote');
            return DataSourceState<OrderEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get order remote error $reason');
            return DataSourceState<OrderEntity>.error(
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
      appLog.d('Get order exception $e');
      return DataSourceState<OrderEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<OrderEntity>> saveOrder({
    required OrderEntity orderEntity,
    OrderType orderType = OrderType.none,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, OrderEntity> result = await orderLocalDataSource.add(orderEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save order local error ${failure.message}');
          return DataSourceState<OrderEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save order to local : ${r.orderID}, ${r.orderDateTime.toUtc().toString()}');
          return DataSourceState<OrderEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<OrderEntity> result = await remoteDataSource.saveOrder(
          orderEntity: orderEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save order to remote');
            return DataSourceState<OrderEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save order remote error $reason');
            return DataSourceState<OrderEntity>.error(
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
      appLog.d('Save order exception $e');
      return DataSourceState<OrderEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }
}
