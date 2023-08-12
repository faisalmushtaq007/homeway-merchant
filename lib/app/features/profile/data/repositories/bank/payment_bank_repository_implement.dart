part of 'package:homemakers_merchant/app/features/profile/index.dart';

class PaymentBankRepositoryImplement implements UserPaymentBankRepository {
  const PaymentBankRepositoryImplement({
    required this.remoteDataSource,
    required this.paymentBankLocalDataSource,
  });
  final ProfileDataSource remoteDataSource;
  final UserPaymentBankLocalDbRepository<PaymentBankEntity> paymentBankLocalDataSource;
  @override
  Future<DataSourceState<bool>> deleteAllPaymentBank({AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await paymentBankLocalDataSource.deleteAll();
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
          appLog.d('Delete all bank to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllPaymentBank();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all bank to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all bank remote error $reason');
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
      appLog.e('Delete all bank exception $e');
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
  Future<DataSourceState<bool>> deletePaymentBank({required int paymentBankID, PaymentBankEntity? paymentBankEntity, AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await paymentBankLocalDataSource.deleteById(UniqueId(paymentBankID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete bank local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete bank to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deletePaymentBank(
          paymentBankID: paymentBankID,
          paymentBankEntity: paymentBankEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete bank to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete bank remote error $reason');
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
      appLog.e('Delete bank exception $e');
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
  Future<DataSourceState<PaymentBankEntity>> editPaymentBank({
    required PaymentBankEntity paymentBankEntity,
    required int paymentBankID,
    AppUserEntity? appUserEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, PaymentBankEntity> result = await paymentBankLocalDataSource.update(paymentBankEntity, UniqueId(paymentBankID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit bank local error ${failure.message}');
          return DataSourceState<PaymentBankEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit bank local : ${r.paymentBankID}, ${r.bankName}');
          return DataSourceState<PaymentBankEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<PaymentBankEntity> result = await remoteDataSource.editPaymentBank(
          paymentBankID: paymentBankID,
          paymentBankEntity: paymentBankEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit bank to remote');
            return DataSourceState<PaymentBankEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit bank remote error $reason');
            return DataSourceState<PaymentBankEntity>.error(
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
      appLog.e('Edit bank exception $e');
      return DataSourceState<PaymentBankEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<PaymentBankEntity>>> getAllPaymentBank({AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<PaymentBankEntity>> result = await paymentBankLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all bank local error ${failure.message}');
          return DataSourceState<List<PaymentBankEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all bank local : ${r.length}');
          return DataSourceState<List<PaymentBankEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<PaymentBankEntity>> result = await remoteDataSource.getAllPaymentBank();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all bank from remote');
            return DataSourceState<List<PaymentBankEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all bank remote error $reason');
            return DataSourceState<List<PaymentBankEntity>>.error(
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
      appLog.e('Get all bank exception $e');
      return DataSourceState<List<PaymentBankEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<PaymentBankEntity>> getPaymentBank({
    required int paymentBankID,
    AppUserEntity? appUserEntity,
    PaymentBankEntity? paymentBankEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, PaymentBankEntity?> result = await paymentBankLocalDataSource.getById(UniqueId(paymentBankID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get bank local error ${failure.message}');
          return DataSourceState<PaymentBankEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get bank to local : ${r?.paymentBankID}, ${r?.bankName}');
          return DataSourceState<PaymentBankEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<PaymentBankEntity> result = await remoteDataSource.getPaymentBank(
          paymentBankID: paymentBankID,
          paymentBankEntity: paymentBankEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get bank to remote');
            return DataSourceState<PaymentBankEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get bank remote error $reason');
            return DataSourceState<PaymentBankEntity>.error(
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
      appLog.d('Get bank exception $e');
      return DataSourceState<PaymentBankEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<PaymentBankEntity>> savePaymentBank({required PaymentBankEntity paymentBankEntity, AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, PaymentBankEntity> result = await paymentBankLocalDataSource.add(paymentBankEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save bank local error ${failure.message}');
          return DataSourceState<PaymentBankEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save bank to local : ${r.paymentBankID}, ${r.bankName}');
          return DataSourceState<PaymentBankEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<PaymentBankEntity> result = await remoteDataSource.savePaymentBank(
          paymentBankEntity: paymentBankEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save bank to remote');
            return DataSourceState<PaymentBankEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save bank remote error $reason');
            return DataSourceState<PaymentBankEntity>.error(
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
      appLog.d('Save bank exception $e');
      return DataSourceState<PaymentBankEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }
}
