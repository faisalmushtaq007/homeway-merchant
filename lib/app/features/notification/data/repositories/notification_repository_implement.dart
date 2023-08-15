part of 'package:homemakers_merchant/app/features/notification/index.dart';

class NotificationRepositoryImplement implements NotificationRepository {
  const NotificationRepositoryImplement({
    required this.remoteDataSource,
    required this.notificationLocalDataSource,
  });

  final NotificationDataSource remoteDataSource;
  final NotificationLocalDbRepository<NotificationEntity> notificationLocalDataSource;
  @override
  Future<DataSourceState<bool>> deleteAllNotification() async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await notificationLocalDataSource.deleteAll();
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
          appLog.d('Delete all notification to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllNotification();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all notification to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all notification remote error $reason');
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
      appLog.e('Delete all notification exception $e');
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
  Future<DataSourceState<bool>> deleteNotification({required int notificationID, NotificationEntity? notificationEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await notificationLocalDataSource.deleteById(UniqueId(notificationID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete notification local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete notification to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteNotification(
          notificationID: notificationID,
          notificationEntity: notificationEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete notification to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete notification remote error $reason');
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
      appLog.e('Delete notification exception $e');
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
  Future<DataSourceState<NotificationEntity>> editNotification({required NotificationEntity notificationEntity, required int notificationID}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, NotificationEntity> result = await notificationLocalDataSource.update(notificationEntity, UniqueId(notificationID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit notification local error ${failure.message}');
          return DataSourceState<NotificationEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit notification local : ${r.notificationID}');
          return DataSourceState<NotificationEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<NotificationEntity> result = await remoteDataSource.editNotification(
          notificationID: notificationID,
          notificationEntity: notificationEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit notification to remote');
            return DataSourceState<NotificationEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit notification remote error $reason');
            return DataSourceState<NotificationEntity>.error(
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
      appLog.e('Edit notification exception $e');
      return DataSourceState<NotificationEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<NotificationEntity>>> getAllNotification() async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<NotificationEntity>> result = await notificationLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all notification local error ${failure.message}');
          return DataSourceState<List<NotificationEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all notification local : ${r.length}');
          return DataSourceState<List<NotificationEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<NotificationEntity>> result = await remoteDataSource.getAllNotification();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all notification from remote');
            return DataSourceState<List<NotificationEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all notification remote error $reason');
            return DataSourceState<List<NotificationEntity>>.error(
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
      appLog.e('Get all notification exception $e');
      return DataSourceState<List<NotificationEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<NotificationEntity>> getNotification({required int notificationID, NotificationEntity? notificationEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, NotificationEntity?> result = await notificationLocalDataSource.getById(UniqueId(notificationID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get notification local error ${failure.message}');
          return DataSourceState<NotificationEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get notification to local : ${r?.notificationID}, ${r?.title}');
          return DataSourceState<NotificationEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<NotificationEntity> result = await remoteDataSource.getNotification(
          notificationID: notificationID,
          notificationEntity: notificationEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get notification to remote');
            return DataSourceState<NotificationEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get notification remote error $reason');
            return DataSourceState<NotificationEntity>.error(
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
      appLog.d('Get notification exception $e');
      return DataSourceState<NotificationEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<NotificationEntity>> saveNotification({required NotificationEntity notificationEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, NotificationEntity> result = await notificationLocalDataSource.add(notificationEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save notification local error ${failure.message}');
          return DataSourceState<NotificationEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save notification to local : ${r.notificationID}, ${r.title}');
          return DataSourceState<NotificationEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<NotificationEntity> result = await remoteDataSource.saveNotification(
          notificationEntity: notificationEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save notification to remote');
            return DataSourceState<NotificationEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save notification remote error $reason');
            return DataSourceState<NotificationEntity>.error(
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
      appLog.d('Save notification exception $e');
      return DataSourceState<NotificationEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<NotificationEntity>>> saveAllNotification({
    required List<NotificationEntity> notificationEntities,
    bool hasUpdateAll = false,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<NotificationEntity>> result = await notificationLocalDataSource.saveAll(
          entities: notificationEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all notification local error ${failure.message}');
          return DataSourceState<List<NotificationEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all notification to local : ${r?.length},');
          return DataSourceState<List<NotificationEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<NotificationEntity>> result = await remoteDataSource.saveAllNotification(
          notificationEntities: notificationEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all notification to remote');
            return DataSourceState<List<NotificationEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all notification remote error $reason');
            return DataSourceState<List<NotificationEntity>>.error(
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
      appLog.d('Save all notification exception $e');
      return DataSourceState<List<NotificationEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }
}
