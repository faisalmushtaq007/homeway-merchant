part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class RateAndReviewRepositoryImplement implements RateAndReviewRepository {
  const RateAndReviewRepositoryImplement({
    required this.remoteDataSource,
    required this.notificationLocalDataSource,
  });

  final RateAndReviewDataSource remoteDataSource;
  final RateAndReviewLocalDbRepository<RateAndReviewEntity>
      notificationLocalDataSource;
  @override
  Future<DataSourceState<bool>> deleteAllRateAndReview() async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result =
            await notificationLocalDataSource.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all rate and review local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all rate and review to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result =
            await remoteDataSource.deleteAllRateAndReview();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all rate and review to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all rate and review remote error $reason');
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
      appLog.e('Delete all rate and review exception $e');
      return DataSourceState<bool>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        //  exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<bool>> deleteRateAndReview(
      {required int ratingID, RateAndReviewEntity? rateAndReviewEntity}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result =
            await notificationLocalDataSource.deleteById(UniqueId(ratingID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete rate and review local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete rate and review to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result =
            await remoteDataSource.deleteRateAndReview(
          ratingID: ratingID,
          rateAndReviewEntity: rateAndReviewEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete rate and review to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete rate and review remote error $reason');
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
      appLog.e('Delete rate and review exception $e');
      return DataSourceState<bool>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        //  exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<RateAndReviewEntity>> editRateAndReview(
      {required RateAndReviewEntity rateAndReviewEntity,
      required int ratingID}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, RateAndReviewEntity> result =
            await notificationLocalDataSource.update(
                rateAndReviewEntity, UniqueId(ratingID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit rate and review local error ${failure.message}');
          return DataSourceState<RateAndReviewEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit rate and review local : ${r.ratingID}');
          return DataSourceState<RateAndReviewEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<RateAndReviewEntity> result =
            await remoteDataSource.editRateAndReview(
          ratingID: ratingID,
          rateAndReviewEntity: rateAndReviewEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit rate and review to remote');
            return DataSourceState<RateAndReviewEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit rate and review remote error $reason');
            return DataSourceState<RateAndReviewEntity>.error(
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
      appLog.e('Edit rate and review exception $e');
      return DataSourceState<RateAndReviewEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        //  exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<RateAndReviewEntity>>>
      getAllRateAndReview() async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<RateAndReviewEntity>> result =
            await notificationLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all rate and review local error ${failure.message}');
          return DataSourceState<List<RateAndReviewEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all rate and review local : ${r.length}');
          return DataSourceState<List<RateAndReviewEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<RateAndReviewEntity>> result =
            await remoteDataSource.getAllRateAndReview();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all rate and review from remote');
            return DataSourceState<List<RateAndReviewEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all rate and review remote error $reason');
            return DataSourceState<List<RateAndReviewEntity>>.error(
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
      appLog.e('Get all rate and review exception $e');
      return DataSourceState<List<RateAndReviewEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        //  exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<RateAndReviewEntity>> getRateAndReview(
      {required int ratingID, RateAndReviewEntity? rateAndReviewEntity}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, RateAndReviewEntity?> result =
            await notificationLocalDataSource.getById(UniqueId(ratingID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get rate and review local error ${failure.message}');
          return DataSourceState<RateAndReviewEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog
              .d('Get rate and review to local : ${r?.ratingID}, ${r?.title}');
          return DataSourceState<RateAndReviewEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<RateAndReviewEntity> result =
            await remoteDataSource.getRateAndReview(
          ratingID: ratingID,
          rateAndReviewEntity: rateAndReviewEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get rate and review to remote');
            return DataSourceState<RateAndReviewEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get rate and review remote error $reason');
            return DataSourceState<RateAndReviewEntity>.error(
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
      appLog.d('Get rate and review exception $e');
      return DataSourceState<RateAndReviewEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        //  exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<RateAndReviewEntity>> saveRateAndReview(
      {required RateAndReviewEntity rateAndReviewEntity}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, RateAndReviewEntity> result =
            await notificationLocalDataSource.add(rateAndReviewEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save rate and review local error ${failure.message}');
          return DataSourceState<RateAndReviewEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save rate and review to local : ${r.ratingID}, ${r.title}');
          return DataSourceState<RateAndReviewEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<RateAndReviewEntity> result =
            await remoteDataSource.saveRateAndReview(
          rateAndReviewEntity: rateAndReviewEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save rate and review to remote');
            return DataSourceState<RateAndReviewEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save rate and review remote error $reason');
            return DataSourceState<RateAndReviewEntity>.error(
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
      appLog.d('Save rate and review exception $e');
      return DataSourceState<RateAndReviewEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        //  exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<RateAndReviewEntity>>> saveAllRateAndReview({
    required List<RateAndReviewEntity> rateAndReviewEntities,
    bool hasUpdateAll = false,
  }) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<RateAndReviewEntity>> result =
            await notificationLocalDataSource.saveAll(
          entities: rateAndReviewEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all rate and review local error ${failure.message}');
          return DataSourceState<List<RateAndReviewEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all rate and review to local : ${r?.length},');
          return DataSourceState<List<RateAndReviewEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<RateAndReviewEntity>> result =
            await remoteDataSource.saveAllRateAndReview(
          rateAndReviewEntities: rateAndReviewEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all rate and review to remote');
            return DataSourceState<List<RateAndReviewEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all rate and review remote error $reason');
            return DataSourceState<List<RateAndReviewEntity>>.error(
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
      appLog.d('Save all rate and review exception $e');
      return DataSourceState<List<RateAndReviewEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        //  exception: e as Exception,
      );
    }
  }
}
