part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessProfileRepositoryImplement implements UserBusinessProfileRepository {
  const BusinessProfileRepositoryImplement(
      {required this.remoteDataSource, required this.businessProfileLocalDataSource});

  final ProfileDataSource remoteDataSource;
  final UserBusinessProfileLocalDbRepository<BusinessProfileEntity> businessProfileLocalDataSource;

  @override
  Future<DataSourceState<bool>> deleteAllBusinessProfile({AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await businessProfileLocalDataSource.deleteAll();
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
          appLog.d('Delete all profile to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllBusinessProfile();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all profile to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all profile remote error $reason');
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
      appLog.e('Delete all profile exception $e');
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
  Future<DataSourceState<bool>> deleteAllBusinessType(
      {AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO(prasant): implement deleteAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteBusinessProfile({
    required int businessProfileID,
    BusinessProfileEntity? businessProfileEntity,
    AppUserEntity? appUserEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result =
            await businessProfileLocalDataSource.deleteById(UniqueId(businessProfileID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete profile local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete profile to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteBusinessProfile(
          businessProfileID: businessProfileID,
          businessProfileEntity: businessProfileEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete profile to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete profile remote error $reason');
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
      appLog.e('Delete profile exception $e');
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
  Future<DataSourceState<bool>> deleteBusinessType({
    required int businessTypeID,
    BusinessTypeEntity? businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement deleteBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessProfileEntity>> editBusinessProfile({
    required BusinessProfileEntity businessProfileEntity,
    required int businessProfileID,
    AppUserEntity? appUserEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, BusinessProfileEntity> result =
            await businessProfileLocalDataSource.update(businessProfileEntity, UniqueId(businessProfileID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit profile local error ${failure.message}');
          return DataSourceState<BusinessProfileEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit profile local : ${r.businessProfileID}, ${r.businessName}');
          return DataSourceState<BusinessProfileEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<BusinessProfileEntity> result = await remoteDataSource.editBusinessProfile(
          businessProfileID: businessProfileID,
          businessProfileEntity: businessProfileEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit profile to remote');
            return DataSourceState<BusinessProfileEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit profile remote error $reason');
            return DataSourceState<BusinessProfileEntity>.error(
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
      appLog.e('Edit profile exception $e');
      return DataSourceState<BusinessProfileEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> editBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement editBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> getAllBusinessProfile({AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<BusinessProfileEntity>> result =
            await businessProfileLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all profile local error ${failure.message}');
          return DataSourceState<List<BusinessProfileEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all profile local : ${r.length}');
          return DataSourceState<List<BusinessProfileEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<BusinessProfileEntity>> result = await remoteDataSource.getAllBusinessProfile();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all profile from remote');
            return DataSourceState<List<BusinessProfileEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all profile remote error $reason');
            return DataSourceState<List<BusinessProfileEntity>>.error(
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
      appLog.e('Get all profile exception $e');
      return DataSourceState<List<BusinessProfileEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, List<BusinessTypeEntity>)>> getAllBusinessType({
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement getAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessProfileEntity>> getBusinessProfile({
    required int businessProfileID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, BusinessProfileEntity?> result =
            await businessProfileLocalDataSource.getById(UniqueId(businessProfileID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get profile local error ${failure.message}');
          return DataSourceState<BusinessProfileEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get profile to local : ${r?.businessProfileID}, ${r?.businessName}');
          return DataSourceState<BusinessProfileEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<BusinessProfileEntity> result = await remoteDataSource.getBusinessProfile(
          businessProfileEntity: businessProfileEntity,
          businessProfileID: businessProfileID,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get profile to remote');
            return DataSourceState<BusinessProfileEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get profile remote error $reason');
            return DataSourceState<BusinessProfileEntity>.error(
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
      appLog.d('Get profile exception $e');
      return DataSourceState<BusinessProfileEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> getBusinessType({
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
    BusinessTypeEntity? businessTypeEntity,
  }) async {
    // TODO(prasant): implement getBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessProfileEntity>> saveBusinessProfile({
    required BusinessProfileEntity businessProfileEntity,
    AppUserEntity? appUserEntity,
  }) async {
    /*try {*/
    final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
      // Local DB
      // Save to local
      appLog.d('SaveBusinessProfile data ${businessProfileEntity.toMap()}');
      final Either<RepositoryBaseFailure, BusinessProfileEntity> result =
          await businessProfileLocalDataSource.add(businessProfileEntity);
      // Return result
      return result.fold((l) {
        final RepositoryFailure failure = l as RepositoryFailure;
        appLog.d('Save profile local error ${failure.message}');
        return DataSourceState<BusinessProfileEntity>.error(
          reason: failure.message,
          dataSourceFailure: DataSourceFailure.local,
          stackTrace: failure.stacktrace,
        );
      }, (r) {
        appLog.d('Save profile to local : ${r.businessProfileID}, ${r.businessName}');
        return DataSourceState<BusinessProfileEntity>.localDb(data: r);
      });
    } else {
      // Remote
      // Save to server
      final ApiResultState<BusinessProfileEntity> result =
          await remoteDataSource.saveBusinessProfile(businessProfileEntity: businessProfileEntity);
      // Return result
      return result.when(
        success: (data) {
          appLog.d('Save profile to remote');
          return DataSourceState<BusinessProfileEntity>.remote(
            data: data,
          );
        },
        failure: (reason, error, exception, stackTrace) {
          appLog.d('Save profile remote error $reason');
          return DataSourceState<BusinessProfileEntity>.error(
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
      appLog.d('Save profile exception $e');
      return DataSourceState<BusinessProfileEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }*/
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> saveBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement saveBusinessType
    throw UnimplementedError();
  }

  @override
  Future<AppUserEntity?> getCurrentUserBusinessProfileFromLocalDB({
    Map<String, dynamic> metaInfo = const {},
    String byID = '',
    String byToken = '',
  }) {
    // TODO: implement getCurrentUserBusinessProfileFromLocalDB
    throw UnimplementedError();
  }

  @override
  Future<String> getCurrentUserTokenFromLocalDB({
    Map<String, dynamic> metaInfo = const {},
  }) {
    // TODO: implement getCurrentUserTokenFromLocalDB
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> getAllBusinessProfilePagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<BusinessProfileEntity>> result = await businessProfileLocalDataSource.getAllWithPagination(
          filter: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          endTimeStamp: endTime,
          startTimeStamp: startTime,
          extras: extras,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all businessProfile local error ${failure.message}');
          return DataSourceState<List<BusinessProfileEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all businessProfile local : ${r.length}');
          return DataSourceState<List<BusinessProfileEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<BusinessProfileEntity>> result = await remoteDataSource.getAllBusinessProfilePagination(
          filtering: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          endTime: endTime,
          startTime: startTime,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all businessProfile from remote');
            return DataSourceState<List<BusinessProfileEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all businessProfile remote error $reason');
            return DataSourceState<List<BusinessProfileEntity>>.error(
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
      appLog.e('Get all businessProfile exception $e');
      return DataSourceState<List<BusinessProfileEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> saveAllBusinessProfiles({
    required List<BusinessProfileEntity> businessProfiles,
    bool hasUpdateAll = false,
  }) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<BusinessProfileEntity>> result = await businessProfileLocalDataSource.saveAll(
          entities: businessProfiles,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all BusinessProfileEntity local error ${failure.message}');
          return DataSourceState<List<BusinessProfileEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all BusinessProfileEntity to local : ${r.length},');
          return DataSourceState<List<BusinessProfileEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<BusinessProfileEntity>> result = await remoteDataSource.saveAllBusinessDocuments(
          newBusinessDocuments: businessProfiles,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all BusinessProfileEntity to remote');
            return DataSourceState<List<BusinessProfileEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all BusinessProfileEntity remote error $reason');
            return DataSourceState<List<BusinessProfileEntity>>.error(
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
      appLog.d('Save all BusinessProfileEntity exception $e');
      return DataSourceState<List<BusinessProfileEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }
}
