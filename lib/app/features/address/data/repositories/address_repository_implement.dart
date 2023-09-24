part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressRepositoryImplement implements UserAddressRepository {
  const AddressRepositoryImplement({
    required this.remoteDataSource,
    required this.addressLocalDataSource,
  });

  final AddressDataSource remoteDataSource;
  final AddressLocalDbRepository<AddressModel> addressLocalDataSource;

  @override
  Future<DataSourceState<bool>> deleteAllAddress(
      {AppUserEntity? appUserEntity}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result =
            await addressLocalDataSource.deleteAll();
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
          appLog.d('Delete all address to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result =
            await remoteDataSource.deleteAllAddress();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all address to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all address remote error $reason');
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
      appLog.e('Delete all address exception $e');
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
  Future<DataSourceState<bool>> deleteAddress(
      {required int addressID,
      AddressModel? addressEntity,
      AppUserEntity? appUserEntity}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result =
            await addressLocalDataSource.deleteById(UniqueId(addressID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete address local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete address to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result =
            await remoteDataSource.deleteAddress(
          addressID: addressID,
          addressEntity: addressEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete address to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete address remote error $reason');
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
      appLog.e('Delete address exception $e');
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
  Future<DataSourceState<AddressModel>> editAddress({
    required AddressModel addressEntity,
    required int addressID,
    AppUserEntity? appUserEntity,
  }) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AddressModel> result =
            await addressLocalDataSource.update(
                addressEntity, UniqueId(addressID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit address local error ${failure.message}');
          return DataSourceState<AddressModel>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d(
              'Edit address local : ${r.addressID}, ${r.address?.area ?? 'No Address'}');
          return DataSourceState<AddressModel>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AddressModel> result =
            await remoteDataSource.editAddress(
          addressID: addressID,
          addressEntity: addressEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit address to remote');
            return DataSourceState<AddressModel>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit address remote error $reason');
            return DataSourceState<AddressModel>.error(
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
      appLog.e('Edit address exception $e');
      return DataSourceState<AddressModel>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<AddressModel>>> getAllAddress(
      {AppUserEntity? appUserEntity}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<AddressModel>> result =
            await addressLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all address local error ${failure.message}');
          return DataSourceState<List<AddressModel>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all address local : ${r.length}');
          return DataSourceState<List<AddressModel>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<AddressModel>> result =
            await remoteDataSource.getAllAddress();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all address from remote');
            return DataSourceState<List<AddressModel>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all address remote error $reason');
            return DataSourceState<List<AddressModel>>.error(
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
      appLog.e('Get all address exception $e');
      return DataSourceState<List<AddressModel>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<AddressModel>> getAddress({
    required int addressID,
    AppUserEntity? appUserEntity,
    AddressModel? addressEntity,
  }) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AddressModel?> result =
            await addressLocalDataSource.getById(UniqueId(addressID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get address local error ${failure.message}');
          return DataSourceState<AddressModel>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d(
              'Get address to local : ${r?.addressID}, ${r?.address?.area ?? 'No Address'}');
          return DataSourceState<AddressModel>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AddressModel> result =
            await remoteDataSource.getAddress(
          addressID: addressID,
          addressEntity: addressEntity,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get address to remote');
            return DataSourceState<AddressModel>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get address remote error $reason');
            return DataSourceState<AddressModel>.error(
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
      appLog.d('Get address exception $e');
      return DataSourceState<AddressModel>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<AddressModel>> saveAddress(
      {required AddressModel addressEntity,
      AppUserEntity? appUserEntity}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AddressModel> result =
            await addressLocalDataSource.add(addressEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save address local error ${failure.message}');
          return DataSourceState<AddressModel>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d(
              'Save address to local : ${r.addressID}, ${r.address?.area ?? 'No Address'}');
          return DataSourceState<AddressModel>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AddressModel> result =
            await remoteDataSource.saveAddress(
          addressEntity: addressEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save address to remote');
            return DataSourceState<AddressModel>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save address remote error $reason');
            return DataSourceState<AddressModel>.error(
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
      appLog.d('Save address exception $e');
      return DataSourceState<AddressModel>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<AddressModel>>> getAllAddressPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    AddressModel? addressEntity,
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
        final Either<RepositoryBaseFailure, List<AddressModel>> result =
            await addressLocalDataSource.getAllWithPagination(
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
          appLog.d('Get all address local error ${failure.message}');
          return DataSourceState<List<AddressModel>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all address local : ${r.length}');
          return DataSourceState<List<AddressModel>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<AddressModel>> result =
            await remoteDataSource.getAllAddressPagination(
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
            appLog.d('Get all address from remote');
            return DataSourceState<List<AddressModel>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all address remote error $reason');
            return DataSourceState<List<AddressModel>>.error(
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
      appLog.e('Get all address exception $e');
      return DataSourceState<List<AddressModel>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<AddressModel>>> saveAllAddress(
      {required List<AddressModel> addressEntities,
      bool hasUpdateAll = false}) async {
    try {
      final connectivity =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<AddressModel>> result =
            await addressLocalDataSource.saveAll(
          entities: addressEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all address local error ${failure.message}');
          return DataSourceState<List<AddressModel>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all address to local : ${r?.length},');
          return DataSourceState<List<AddressModel>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<AddressModel>> result =
            await remoteDataSource.saveAllAddress(
          addressEntities: addressEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all address to remote');
            return DataSourceState<List<AddressModel>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all address remote error $reason');
            return DataSourceState<List<AddressModel>>.error(
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
      appLog.d('Save all address exception $e');
      return DataSourceState<List<AddressModel>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }
}
