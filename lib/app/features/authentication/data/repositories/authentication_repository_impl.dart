part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class AuthenticationRepositoryImplement implements AuthenticationRepository {
  AuthenticationRepositoryImplement({
    required this.remoteDataSource,
    required this.userLocalDbRepository,
  });

  final AuthenticationDataSource remoteDataSource;
  final UserLocalDbRepository<AppUserEntity> userLocalDbRepository;

  @override
  Future<ResultState<SendOtpResponseModel>> sendPhoneAuthenticationOtp(SendOtpEntity sendOtpEntity) async {
    final response = await remoteDataSource.sendPhoneAuthenticationOTP(
      sendOtpEntity: BaseRequestModel<SendOtpEntity>(data: sendOtpEntity),
    );
    return response.when(
      success: (data) {
        return ResultState<SendOtpResponseModel>.success(data: data);
      },
      failure: (reason, error, exception, stackTrace) {
        return ResultState.error(
          reason: reason,
          error: error,
          stackTrace: stackTrace,
          networkException: exception,
        );
      },
    );
  }

  @override
  Future<ResultState<VerifyOtpResponseModel>> verifyPhoneAuthenticationOtp(VerifyOtpEntity verifyOtpEntity) async {
    final response = await remoteDataSource.verifyPhoneAuthenticationOTP(
      verifyOtpEntity: BaseRequestModel<VerifyOtpEntity>(data: verifyOtpEntity),
    );
    return response.when(
      success: (data) {
        return ResultState<VerifyOtpResponseModel>.success(data: data);
      },
      failure: (reason, error, exception, stackTrace) {
        return ResultState.error(
          reason: reason,
          error: error,
          stackTrace: stackTrace,
          networkException: exception,
        );
      },
    );
  }

  @override
  Future<DataSourceState<bool>> deleteAllAppUser() async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await userLocalDbRepository.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all appUser local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all appUser to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllAppUser();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all appUser to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all appUser remote error $reason');
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
      appLog.e('Delete all appUser exception $e');
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
  Future<DataSourceState<bool>> deleteAppUser({required int userID, AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await userLocalDbRepository.deleteById(UniqueId(userID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete appUser local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete appUser to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAppUser(
          userID: userID,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete appUser to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete appUser remote error $reason');
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
      appLog.e('Delete appUser exception $e');
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
  Future<DataSourceState<AppUserEntity>> editAppUser(
      {required AppUserEntity appUserEntity, required int userID}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity> result =
            await userLocalDbRepository.update(appUserEntity, UniqueId(userID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit appUser local error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit appUser local : ${r.userID}');
          return DataSourceState<AppUserEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity> result = await remoteDataSource.editAppUser(
          userID: userID,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit appUser to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit appUser remote error $reason');
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
      appLog.e('Edit appUser exception $e');
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
  Future<DataSourceState<List<AppUserEntity>>> getAllAppUser() async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<AppUserEntity>> result = await userLocalDbRepository.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all appUser local error ${failure.message}');
          return DataSourceState<List<AppUserEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all appUser local : ${r.length}');
          return DataSourceState<List<AppUserEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<AppUserEntity>> result = await remoteDataSource.getAllAppUser();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all appUser from remote');
            return DataSourceState<List<AppUserEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all appUser remote error $reason');
            return DataSourceState<List<AppUserEntity>>.error(
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
      appLog.e('Get all appUser exception $e');
      return DataSourceState<List<AppUserEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<AppUserEntity>> getAppUser({required int userID, AppUserEntity? appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity?> result =
            await userLocalDbRepository.getById(UniqueId(userID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get appUser local error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get appUser to local : ${r?.userID}');
          return DataSourceState<AppUserEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity> result = await remoteDataSource.getAppUser(
          userID: userID,
          appUserEntity: appUserEntity,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get appUser to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get appUser remote error $reason');
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
      appLog.d('Get appUser exception $e');
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
  Future<DataSourceState<AppUserEntity>> saveAppUser({required AppUserEntity appUserEntity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity> result = await userLocalDbRepository.add(appUserEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save appUser local error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save appUser to local : ${r.userID}');
          return DataSourceState<AppUserEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity> result = await remoteDataSource.saveAppUser(appUserEntity: appUserEntity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save appUser to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save appUser remote error $reason');
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
      appLog.d('Save appUser exception $e');
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
  Future<DataSourceState<AppUserEntity?>> getCurrentAppUser({AppUserEntity? entity}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity?> result =
            await userLocalDbRepository.getCurrentUser(entity: entity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get current appUser local error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          if (r != null) {
            appLog.d('Get current appUser to local : ${r?.toMap()}');
            return DataSourceState<AppUserEntity>.localDb(data: r);
          } else {
            return const DataSourceState<AppUserEntity>.error(
              reason: 'User is null',
              dataSourceFailure: DataSourceFailure.local,
            );
          }
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity?> result = await remoteDataSource.getCurrentAppUser(entity: entity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get current appUser to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get current appUser remote error $reason');
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
      appLog.d('Get current appUser exception $e');
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
  Future<DataSourceState<List<AppUserEntity>>> getAllUsersPagination({
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
        final Either<RepositoryBaseFailure, List<AppUserEntity>> result = await userLocalDbRepository.getAllWithPagination(
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
          appLog.d('Get all users local error ${failure.message}');
          return DataSourceState<List<AppUserEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all menu local : ${r.length}');
          return DataSourceState<List<AppUserEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<AppUserEntity>> result = await remoteDataSource.getAllAppUsersPagination(
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
            appLog.d('Get all users from remote');
            return DataSourceState<List<AppUserEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all users remote error $reason');
            return DataSourceState<List<AppUserEntity>>.error(
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
      appLog.e('Get all users exception $e');
      return DataSourceState<List<AppUserEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<AppUserEntity>>> saveAllUsers({
    required List<AppUserEntity> appUsers,
    bool hasUpdateAll = false,
  }) {
    // TODO: implement saveAllUsers
    throw UnimplementedError();
  }
}
