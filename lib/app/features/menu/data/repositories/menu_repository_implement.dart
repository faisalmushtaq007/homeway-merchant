part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuRepositoryImplement implements MenuRepository {
  const MenuRepositoryImplement({
    required this.remoteDataSource,
    required this.menuLocalDataSource,
    required this.addonsLocalDataSource,
    required this.addonsBindingWithMenuLocalDataSource,
    required this.addonsBindingWithCurrentUserLocalDataSource,
    required this.menuBindingWithStoreLocalDataSource,
    required this.menuBindingWithCurrentUserLocalDataSource,
    required this.categoryLocalDbRepository,
  });

  final MenuDataSource remoteDataSource;
  final MenuLocalDbRepository<MenuEntity> menuLocalDataSource;
  final AddonsLocalDbRepository<Addons> addonsLocalDataSource;
  final AddonsBindingWithMenuLocalDbDbRepository<Addons, MenuEntity> addonsBindingWithMenuLocalDataSource;
  final AddonsBindingWithCurrentUserLocalDbDbRepository<Addons, AppUserEntity> addonsBindingWithCurrentUserLocalDataSource;
  final MenuBindingWithStoreLocalDbDbRepository<MenuEntity, StoreEntity> menuBindingWithStoreLocalDataSource;
  final MenuBindingWithCurrentUserLocalDbDbRepository<MenuEntity, AppUserEntity> menuBindingWithCurrentUserLocalDataSource;
  final CategoryLocalDbRepository categoryLocalDbRepository;

  @override
  Future<DataSourceState<bool>> deleteAllMenu() async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await menuLocalDataSource.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all menu local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all menu to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllMenu();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all menu to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all menu remote error $reason');
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
      appLog.e('Delete all menu exception $e');
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
  Future<DataSourceState<bool>> deleteMenu({required int menuID, MenuEntity? menuEntity}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await menuLocalDataSource.deleteById(UniqueId(menuID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete menu local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete menu to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteMenu(menuID: menuID, menuEntity: menuEntity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete menu to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete menu remote error $reason');
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
      appLog.e('Delete menu exception $e');
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
  Future<DataSourceState<MenuEntity>> editMenu({
    required MenuEntity menuEntity,
    required int menuID,
  }) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, MenuEntity> result = await menuLocalDataSource.update(menuEntity, UniqueId(menuID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit menu local error ${failure.message}');
          return DataSourceState<MenuEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit menu local : ${r.menuId}, ${r.menuName}');
          return DataSourceState<MenuEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<MenuEntity> result = await remoteDataSource.editMenu(
          menuEntity: menuEntity,
          menuID: menuID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit menu to remote');
            return DataSourceState<MenuEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit menu remote error $reason');
            return DataSourceState<MenuEntity>.error(
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
      appLog.e('Edit menu exception $e');
      return DataSourceState<MenuEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> getAllMenu({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    /*try {*/
    var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
    if (connectivity.$2 == InternetConnectivityState.internet) {
      // Local DB
      // Save to local
      final Either<RepositoryBaseFailure, List<MenuEntity>> result = await menuLocalDataSource.getAll();
      // Return result
      return result.fold((l) {
        final RepositoryFailure failure = l as RepositoryFailure;
        appLog.d('Get all menu local error ${failure.message}');
        return DataSourceState<List<MenuEntity>>.error(
          reason: failure.message,
          dataSourceFailure: DataSourceFailure.local,
          stackTrace: failure.stacktrace,
        );
      }, (r) {
        appLog.d('Get all menu local : ${r.length}');
        return DataSourceState<List<MenuEntity>>.localDb(data: r);
      });
    } else {
      // Remote
      // Save to server
      final ApiResultState<List<MenuEntity>> result = await remoteDataSource.getAllMenu();
      // Return result
      return result.when(
        success: (data) {
          appLog.d('Get all menu from remote');
          return DataSourceState<List<MenuEntity>>.remote(
            data: data.toList(),
          );
        },
        failure: (reason, error, exception, stackTrace) {
          appLog.d('Get all menu remote error $reason');
          return DataSourceState<List<MenuEntity>>.error(
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
      appLog.e('Get all menu exception $e');
      return DataSourceState<List<MenuEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }*/
  }

  @override
  Future<DataSourceState<MenuEntity>> getMenu({required int menuID, MenuEntity? menuEntity}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, MenuEntity?> result = await menuLocalDataSource.getById(UniqueId(menuID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get menu local error ${failure.message}');
          return DataSourceState<MenuEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get menu to local : ${r?.menuId}, ${r?.menuName}');
          return DataSourceState<MenuEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<MenuEntity> result = await remoteDataSource.getMenu(
          menuEntity: menuEntity,
          menuID: menuID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get menu to remote');
            return DataSourceState<MenuEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get menu remote error $reason');
            return DataSourceState<MenuEntity>.error(
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
      appLog.d('Get menu exception $e');
      return DataSourceState<MenuEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<MenuEntity>> saveMenu({required MenuEntity menuEntity}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, MenuEntity> result = await menuLocalDataSource.add(menuEntity);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save menu local error ${failure.message}');
          return DataSourceState<MenuEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save menu to local : ${r.menuId}, ${r.menuName}');
          return DataSourceState<MenuEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<MenuEntity> result = await remoteDataSource.saveMenu(menuEntity: menuEntity);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save menu to remote');
            return DataSourceState<MenuEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save menu remote error $reason');
            return DataSourceState<MenuEntity>.error(
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
      appLog.d('Save menu exception $e');
      return DataSourceState<MenuEntity>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> bindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<MenuEntity>> result = await addonsBindingWithMenuLocalDataSource.binding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Binding addons with menu error ${failure.message}');
          return DataSourceState<List<MenuEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Binding addons with menu local :');
          return DataSourceState<List<MenuEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<MenuEntity>> result = await remoteDataSource.bindAddonsWithMenu(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Binding addons with menu to remote');
            return DataSourceState<List<MenuEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Binding addons with menu remote error $reason');
            return DataSourceState<List<MenuEntity>>.error(
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
      appLog.e('Binding addons with menu exception $e');
      return DataSourceState<List<MenuEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> bindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<StoreEntity>> result = await menuBindingWithStoreLocalDataSource.binding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Binding menu with store error ${failure.message}');
          return DataSourceState<List<StoreEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Binding menu with store local :');
          return DataSourceState<List<StoreEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<StoreEntity>> result = await remoteDataSource.bindMenuWithStores(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Binding menu with store to remote');
            return DataSourceState<List<StoreEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Binding menu with store remote error $reason');
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
      appLog.e('Binding menu with store exception $e');
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
  Future<DataSourceState<bool>> deleteAddons({required int addonsID, Addons? addons}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await addonsLocalDataSource.deleteById(UniqueId(addonsID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete addons local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete addons to local : $r');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAddons(addonsID: addonsID, addons: addons);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete addons to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete addons remote error $reason');
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
      appLog.e('Delete addons exception $e');
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
  Future<DataSourceState<bool>> deleteAllAddons() async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, bool> result = await addonsLocalDataSource.deleteAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Delete all addons local error ${failure.message}');
          return DataSourceState<bool>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Delete all addons to local : $r,');
          return DataSourceState<bool>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<bool> result = await remoteDataSource.deleteAllAddons();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Delete all addons to remote');
            return DataSourceState<bool>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Delete all addons remote error $reason');
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
      appLog.e('Delete all addons exception $e');
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
  Future<DataSourceState<Addons>> editAddons({
    required Addons addons,
    required int addonsID,
  }) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, Addons> result = await addonsLocalDataSource.update(addons, UniqueId(addonsID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Edit addons local error ${failure.message}');
          return DataSourceState<Addons>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Edit addons local : ${r.addonsID}, ${r.title}');
          return DataSourceState<Addons>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<Addons> result = await remoteDataSource.editAddons(
          addons: addons,
          addonsID: addonsID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Edit addons to remote');
            return DataSourceState<Addons>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Edit addons remote error $reason');
            return DataSourceState<Addons>.error(
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
      appLog.e('Edit addons exception $e');
      return DataSourceState<Addons>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<Addons>> getAddons({required int addonsID, Addons? addons}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, Addons?> result = await addonsLocalDataSource.getById(UniqueId(addonsID));
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get addons local error ${failure.message}');
          return DataSourceState<Addons>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get addons to local : ${r?.addonsID}, ${r?.title}');
          return DataSourceState<Addons>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<Addons> result = await remoteDataSource.getAddons(
          addons: addons,
          addonsID: addonsID,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get addons to remote');
            return DataSourceState<Addons>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get addons remote error $reason');
            return DataSourceState<Addons>.error(
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
      appLog.d('Get addons exception $e');
      return DataSourceState<Addons>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<Addons>>> getAllAddons({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<Addons>> result = await addonsLocalDataSource.getAll();
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all addons local error ${failure.message}');
          return DataSourceState<List<Addons>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all addons local : ${r.length}');
          return DataSourceState<List<Addons>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<Addons>> result = await remoteDataSource.getAllAddons();
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all addons from remote');
            return DataSourceState<List<Addons>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all addons remote error $reason');
            return DataSourceState<List<Addons>>.error(
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
      appLog.e('Get all addons exception $e');
      return DataSourceState<List<Addons>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<Addons>> saveAddons({required Addons addons}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, Addons> result = await addonsLocalDataSource.add(addons);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save addons local error ${failure.message}');
          return DataSourceState<Addons>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save addons to local : ${r.addonsID}, ${r.title}');
          return DataSourceState<Addons>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<Addons> result = await remoteDataSource.saveAddons(addons: addons);
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save addons to remote');
            return DataSourceState<Addons>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save addons remote error $reason');
            return DataSourceState<Addons>.error(
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
      appLog.d('Save addons exception $e');
      return DataSourceState<Addons>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> unBindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination}) {
    // TODO(prasant): implement unBindAddonsWithMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> unBindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination}) {
    // TODO(prasant): implement unBindMenuWithStores
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<AppUserEntity>> bindAddonsWithUser({required List<Addons> source, required AppUserEntity destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity> result = await addonsBindingWithCurrentUserLocalDataSource.binding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Binding addons with user error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Binding addons with user local :');
          return DataSourceState<AppUserEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity> result = await remoteDataSource.bindAddonsWithUser(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Binding addons with user to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Binding addons with user remote error $reason');
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
      appLog.e('Binding addons with user exception $e');
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
  Future<DataSourceState<AppUserEntity>> bindMenuWithUser({required List<MenuEntity> source, required AppUserEntity destination}) async {
    try {
      var connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, AppUserEntity> result = await menuBindingWithCurrentUserLocalDataSource.binding(source, destination);
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Binding menu with user error ${failure.message}');
          return DataSourceState<AppUserEntity>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Binding menu with user local :');
          return DataSourceState<AppUserEntity>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<AppUserEntity> result = await remoteDataSource.bindMenuWithUser(
          source: source,
          destination: destination,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Binding menu with user to remote');
            return DataSourceState<AppUserEntity>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Binding menu with user remote error $reason');
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
      appLog.e('Binding menu with user exception $e');
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
  Future<DataSourceState<AppUserEntity>> unBindAddonsWithUser({required List<Addons> source, required AppUserEntity destination}) {
    // TODO: implement unBindAddonsWithUser
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<AppUserEntity>> unBindMenuWithUser({required List<MenuEntity> source, required AppUserEntity destination}) {
    // TODO: implement unBindMenuWithUser
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<Category>>> getAllCategory({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Category? category,
    Category? subCategory,
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
        final Either<RepositoryBaseFailure, List<Category>> result = await categoryLocalDbRepository.getAllWithPagination(
          filter: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          extras: {
            'category': category,
            'subCategory': subCategory,
          },
          endTimeStamp: endTime,
          startTimeStamp: startTime,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Get all category local error ${failure.message}');
          return DataSourceState<List<Category>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all category local : ${r.length}');
          return DataSourceState<List<Category>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<Category>> result = await remoteDataSource.getAllCategory(
          filtering: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          category: category,
          subCategory: subCategory,
          endTime: endTime,
          startTime: startTime,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all category from remote');
            return DataSourceState<List<Category>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all category remote error $reason');
            return DataSourceState<List<Category>>.error(
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
      appLog.e('Get all category exception $e');
      return DataSourceState<List<Category>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<Addons>>> saveAllAddons({required List<Addons> addonsEntities, bool hasUpdateAll = false}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<Addons>> result = await addonsLocalDataSource.saveAll(
          entities: addonsEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all Addons local error ${failure.message}');
          return DataSourceState<List<Addons>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all Addons to local : ${r?.length},');
          return DataSourceState<List<Addons>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<Addons>> result = await remoteDataSource.saveAllAddons(
          addonsEntities: addonsEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all Addons to remote');
            return DataSourceState<List<Addons>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all Addons remote error $reason');
            return DataSourceState<List<Addons>>.error(
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
      appLog.d('Save all Addons exception $e');
      return DataSourceState<List<Addons>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<Category>>> saveAllCategory({required List<Category> categories, bool hasUpdateAll = false}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<Category>> result = await categoryLocalDbRepository.saveAll(
          entities: categories,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all Category local error ${failure.message}');
          return DataSourceState<List<Category>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all Category to local : ${r?.length},');
          return DataSourceState<List<Category>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<Category>> result = await remoteDataSource.saveAllCategory(
          categories: categories,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all Category to remote');
            return DataSourceState<List<Category>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all Category remote error $reason');
            return DataSourceState<List<Category>>.error(
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
      appLog.d('Save all Category exception $e');
      return DataSourceState<List<Category>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> saveAllMenu({required List<MenuEntity> menuEntities, bool hasUpdateAll = false}) async {
    try {
      final connectivity = serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (connectivity.$2 == InternetConnectivityState.internet) {
        // Local DB
        // Save to local
        final Either<RepositoryBaseFailure, List<MenuEntity>> result = await menuLocalDataSource.saveAll(
          entities: menuEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.fold((l) {
          final RepositoryFailure failure = l as RepositoryFailure;
          appLog.d('Save all MenuEntity local error ${failure.message}');
          return DataSourceState<List<MenuEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Save all MenuEntity to local : ${r?.length},');
          return DataSourceState<List<MenuEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<MenuEntity>> result = await remoteDataSource.saveAllMenu(
          menuEntities: menuEntities,
          hasUpdateAll: hasUpdateAll,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Save all MenuEntity to remote');
            return DataSourceState<List<MenuEntity>>.remote(
              data: data,
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Save all MenuEntity remote error $reason');
            return DataSourceState<List<MenuEntity>>.error(
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
      appLog.d('Save all MenuEntity exception $e');
      return DataSourceState<List<MenuEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<Addons>>> getAllAddonsPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Addons? addonsEntity,
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
        final Either<RepositoryBaseFailure, List<Addons>> result = await addonsLocalDataSource.getAllWithPagination(
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
          appLog.d('Get all addons local error ${failure.message}');
          return DataSourceState<List<Addons>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all addons local : ${r.length}');
          return DataSourceState<List<Addons>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<Addons>> result = await remoteDataSource.getAllAddonsPagination(
          filtering: filtering,
          sorting: sorting,
          searchText: searchText,
          pageSize: pageSize,
          pageKey: pageKey,
          addonsEntity: addonsEntity,
          endTime: endTime,
          startTime: startTime,
        );
        // Return result
        return result.when(
          success: (data) {
            appLog.d('Get all addons from remote');
            return DataSourceState<List<Addons>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all addons remote error $reason');
            return DataSourceState<List<Addons>>.error(
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
      appLog.e('Get all addons exception $e');
      return DataSourceState<List<Addons>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> getAllMenuPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    MenuEntity? menuEntity,
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
        final Either<RepositoryBaseFailure, List<MenuEntity>> result = await menuLocalDataSource.getAllWithPagination(
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
          appLog.d('Get all menu local error ${failure.message}');
          return DataSourceState<List<MenuEntity>>.error(
            reason: failure.message,
            dataSourceFailure: DataSourceFailure.local,
            stackTrace: failure.stacktrace,
          );
        }, (r) {
          appLog.d('Get all menu local : ${r.length}');
          return DataSourceState<List<MenuEntity>>.localDb(data: r);
        });
      } else {
        // Remote
        // Save to server
        final ApiResultState<List<MenuEntity>> result = await remoteDataSource.getAllMenuPagination(
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
            appLog.d('Get all menu from remote');
            return DataSourceState<List<MenuEntity>>.remote(
              data: data.toList(),
            );
          },
          failure: (reason, error, exception, stackTrace) {
            appLog.d('Get all menu remote error $reason');
            return DataSourceState<List<MenuEntity>>.error(
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
      appLog.e('Get all menu exception $e');
      return DataSourceState<List<MenuEntity>>.error(
        reason: e.toString(),
        dataSourceFailure: DataSourceFailure.local,
        stackTrace: s,
        error: e,
        exception: e as Exception,
      );
    }
  }
}
