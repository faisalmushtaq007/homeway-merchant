part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessDocumentRepositoryImplement implements UserBusinessDocumentRepository {
  const BusinessDocumentRepositoryImplement({
    required this.remoteDataSource,
    required this.businessDocumentLocalDataSource,
  });

  final ProfileDataSource remoteDataSource;
  final UserBusinessDocumentLocalDbRepository<BusinessDocumentUploadedEntity> businessDocumentLocalDataSource;

  @override
  Future<DataSourceState<bool>> deleteAllBusinessDocument({AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await businessDocumentLocalDataSource.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all document local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all document to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllBusinessDocument();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all document to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all document remote error $reason');
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
      appLog.e('Delete all document exception $e');
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
  Future<DataSourceState<bool>> deleteBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await businessDocumentLocalDataSource.deleteById(UniqueId(documentID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete document local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete document to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteBusinessDocument(
          documentID: documentID,
          businessDocumentUploadedEntity: businessDocumentUploadedEntity,
          appUserEntity: appUserEntity,
          appUserID: appUserID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete document to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete document remote error $reason');
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
      appLog.e('Delete document exception $e');
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
  Future<DataSourceState<BusinessDocumentUploadedEntity>> editBusinessDocument({
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
    required int documentID,
    AppUserEntity? appUserEntity,
    int? appUserID,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity> result =
            await businessDocumentLocalDataSource.update(businessDocumentUploadedEntity, UniqueId(documentID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit document local error ${failure.message}');
          return DataSourceState<BusinessDocumentUploadedEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit document local : ${r.documentID}, ${r.documentIDNumber}');
          return DataSourceState<BusinessDocumentUploadedEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<BusinessDocumentUploadedEntity> result = await remoteDataSource.editBusinessDocument(
          documentID: documentID,
          businessDocumentUploadedEntity: businessDocumentUploadedEntity,
          appUserEntity: appUserEntity,
          appUserID: appUserID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit document to remote');
            return DataSourceState<BusinessDocumentUploadedEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit document remote error $reason');
            return DataSourceState<BusinessDocumentUploadedEntity>.error(
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
      appLog.e('Edit document exception $e');
      return DataSourceState<BusinessDocumentUploadedEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<BusinessDocumentUploadedEntity>>> getAllBusinessDocument({AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<BusinessDocumentUploadedEntity>> result = await businessDocumentLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all document local error ${failure.message}');
          return DataSourceState<List<BusinessDocumentUploadedEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all document local : ${r.length}');
          return DataSourceState<List<BusinessDocumentUploadedEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<BusinessDocumentUploadedEntity>> result = await remoteDataSource.getAllBusinessDocument();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all document from remote');
            return DataSourceState<List<BusinessDocumentUploadedEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all document remote error $reason');
            return DataSourceState<List<BusinessDocumentUploadedEntity>>.error(
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
      appLog.e('Get all document exception $e');
      return DataSourceState<List<BusinessDocumentUploadedEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> getBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity?> result = await businessDocumentLocalDataSource.getById(UniqueId(documentID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get document local error ${failure.message}');
          return DataSourceState<BusinessDocumentUploadedEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get document to local : ${r?.documentID}, ${r?.documentIDNumber}');
          return DataSourceState<BusinessDocumentUploadedEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<BusinessDocumentUploadedEntity> result = await remoteDataSource.getBusinessDocument(
          documentID: documentID,
          businessDocumentUploadedEntity: businessDocumentUploadedEntity,
          appUserEntity: appUserEntity,
          appUserID: appUserID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get document to remote');
            return DataSourceState<BusinessDocumentUploadedEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get document remote error $reason');
            return DataSourceState<BusinessDocumentUploadedEntity>.error(
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
      appLog.d('Get document exception $e');
      return DataSourceState<BusinessDocumentUploadedEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> saveBusinessDocument({
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
    AppUserEntity? appUserEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity> result = await businessDocumentLocalDataSource.add(businessDocumentUploadedEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save document local error ${failure.message}');
          return DataSourceState<BusinessDocumentUploadedEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save document to local : ${r.documentID}, ${r.documentIDNumber}');
          return DataSourceState<BusinessDocumentUploadedEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<BusinessDocumentUploadedEntity> result =
            await remoteDataSource.saveBusinessDocument(businessDocumentUploadedEntity: businessDocumentUploadedEntity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save document to remote');
            return DataSourceState<BusinessDocumentUploadedEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save document remote error $reason');
            return DataSourceState<BusinessDocumentUploadedEntity>.error(
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
      appLog.d('Save document exception $e');
      return DataSourceState<BusinessDocumentUploadedEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }
}
