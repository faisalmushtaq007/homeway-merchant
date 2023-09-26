part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreOwnDeliveryPartnersLocalDbRepository<
        Driver extends StoreOwnDeliveryPartnersInfo>
    implements
        BaseStoreOwnDriverLocalDbRepository<StoreOwnDeliveryPartnersInfo> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _driver =>
      AppDatabase.instance.driver;

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo>> add(
      StoreOwnDeliveryPartnersInfo entity) async {
    final result = await tryCatch<StoreOwnDeliveryPartnersInfo>(() async {
      final int recordID = await _driver.add(await _db, entity.toMap());
      //final StoreOwnDeliveryPartnersInfo recordStoreOwnDeliveryPartnersInfo = entity.copyWith(driverID: recordID.toString());
      await update(entity.copyWith(driverID: recordID), UniqueId(recordID));
      final value = await _driver.record(recordID).get(await _db);
      if (value != null) {
        final storedDriverEntity = StoreOwnDeliveryPartnersInfo.fromMap(value);
        final driverEntity = storedDriverEntity.copyWith(driverID: recordID);
        return driverEntity;
      } else {
        final driverEntity = entity.copyWith(driverID: recordID);
        return driverEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(
      StoreOwnDeliveryPartnersInfo entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.driverID;
      final finder = Finder(filter: Filter.byKey(key));
      await _driver.delete(
        await _db,
        finder: finder,
      );
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll() async {
    final result = await tryCatch<bool>(() async {
      final db = await _db;
      int count = 0;
      await db.transaction((transaction) async {
        // Delete all
        await _driver.delete(transaction);
        count++;
      });
      if (count >= 0) {
        return true;
      } else {
        return false;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteById(
      UniqueId uniqueId) async {
    final result = await tryCatch<bool>(() async {
      final value = await _driver.record(uniqueId.value).get(await _db);
      if (value != null) {
        await _driver.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreOwnDeliveryPartnersInfo>>>
      getAll() async {
    final result = await tryCatch<List<StoreOwnDeliveryPartnersInfo>>(() async {
      final snapshots = await _driver.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <StoreOwnDeliveryPartnersInfo>[];
      } else {
        return snapshots
            .map(
              (snapshot) =>
                  StoreOwnDeliveryPartnersInfo.fromMap(snapshot.value).copyWith(
                driverID: snapshot.key,
              ),
            )
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo?>> getById(
      UniqueId id) async {
    final result = await tryCatch<StoreOwnDeliveryPartnersInfo?>(() async {
      final value = await _driver.record(id.value).get(await _db);
      if (value != null) {
        return StoreOwnDeliveryPartnersInfo.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo>> update(
      StoreOwnDeliveryPartnersInfo entity, UniqueId uniqueId) async {
    final result = await tryCatch<StoreOwnDeliveryPartnersInfo>(() async {
      final int key = uniqueId.value;
      final value = await _driver.record(key).get(await _db);
      if (value != null) {
        final result = await _driver.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return StoreOwnDeliveryPartnersInfo.fromMap(result);
        } else {
          return upsert(id: uniqueId, entity: entity);
        }
      } else {
        return upsert(id: uniqueId, entity: entity);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo>> upsert({
    UniqueId? id,
    String? token,
    required StoreOwnDeliveryPartnersInfo entity,
    bool checkIfUserLoggedIn = false,
  }) async {
    final result = await tryCatch<StoreOwnDeliveryPartnersInfo>(() async {
      final int key = entity.driverID;
      final value = await _driver.record(key).get(await _db);
      final result = await _driver
          .record(key)
          .put(await _db, entity.toMap(), merge: (value != null) || false);
      return StoreOwnDeliveryPartnersInfo.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(
      UniqueId uniqueId, StoreOwnDeliveryPartnersInfo entity) {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo>>
      getByIdAndEntity(UniqueId uniqueId, StoreOwnDeliveryPartnersInfo entity) {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo>>
      updateByIdAndEntity(
          UniqueId uniqueId, StoreOwnDeliveryPartnersInfo entity) {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getDriverByIds(
      DatabaseClient db, List<int> ids) async {
    var snapshots = await _driver.find(db,
        finder: Finder(
            filter: Filter.or(
                ids.map((e) => Filter.equals('driverID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{
      for (var snapshot in snapshots)
        snapshot.value['driverID']!.toString(): snapshot
    };
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreOwnDeliveryPartnersInfo>>>
      getAllWithPagination({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    final result = await tryCatch<List<StoreOwnDeliveryPartnersInfo>>(() async {
      final db = await _db;
      return await db.transaction((transaction) async {
        // Finder object can also sort data.
        Finder finder = Finder(
          limit: pageSize,
          offset: pageKey,
        );
        // If
        if (searchText.isNotNull ||
            filter.isNotNull ||
            sorting.isNotNull &&
                (startTimeStamp.isNotNull || endTimeStamp.isNotNull)) {
          var regExp = RegExp('^${searchText?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting?.toLowerCase() ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matches('driverName', '^${searchText}'),
                  Filter.matches('driverName', '${searchText}\$'),
                  Filter.matches('driverName', '${searchText}'),
                  Filter.matches('driverMobileNumber', '^${searchText}'),
                  Filter.matches('driverMobileNumber', '${searchText}\$'),
                  Filter.matches('driverMobileNumber', '${searchText}'),
                  Filter.matches('drivingLicenseNumber', '^${searchText}'),
                  Filter.matches('drivingLicenseNumber', '${searchText}\$'),
                  Filter.matches('drivingLicenseNumber', '${searchText}'),
                  Filter.matches('driverID', '^${searchText}'),
                  Filter.matches('driverID', '${searchText}\$'),
                  Filter.matches('driverID', '${searchText}'),
                  Filter.matchesRegExp(
                    'driverName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'driverMobileNumber',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'drivingLicenseNumber',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'driverID',
                    regExp,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'hasOnline',
                    filterRegExp,
                  ),
                ]),
              ],
            ),
          );
        }
        // Else If
        else if (searchText.isNotNull ||
            filter.isNotNull ||
            sorting.isNotNull) {
          var regExp = RegExp('^${searchText?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting?.toLowerCase() ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matches('driverName', '^${searchText}'),
                  Filter.matches('driverName', '${searchText}\$'),
                  Filter.matches('driverName', '${searchText}'),
                  Filter.matches('driverMobileNumber', '^${searchText}'),
                  Filter.matches('driverMobileNumber', '${searchText}\$'),
                  Filter.matches('driverMobileNumber', '${searchText}'),
                  Filter.matches('drivingLicenseNumber', '^${searchText}'),
                  Filter.matches('drivingLicenseNumber', '${searchText}\$'),
                  Filter.matches('drivingLicenseNumber', '${searchText}'),
                  Filter.matches('driverID', '^${searchText}'),
                  Filter.matches('driverID', '${searchText}\$'),
                  Filter.matches('driverID', '${searchText}'),
                  Filter.matchesRegExp(
                    'driverName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'driverMobileNumber',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'drivingLicenseNumber',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'driverID',
                    regExp,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'hasOnline',
                    filterRegExp,
                  ),
                ]),
              ],
            ),
          );
        }
        // Else
        else {
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
          );
        }
        final recordSnapshots = await _driver.find(
          await _db,
          finder: finder,
        );
        // Making a List<Category> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders =
              StoreOwnDeliveryPartnersInfo.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            driverID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreOwnDeliveryPartnersInfo>>>
      saveAll(
          {required List<StoreOwnDeliveryPartnersInfo> entities,
          bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<StoreOwnDeliveryPartnersInfo>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <StoreOwnDeliveryPartnersInfo>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(
            allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var driverIds = convertOrderToMapObject
              .map((map) => map['driverID'] as int)
              .toList();
          var map = await getDriverByIds(db, driverIds);
          // Watch for deleted item
          var keysToDelete = (await _driver.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['driverID'] as int];
            if (snapshot != null) {
              // The record current key
              var key = snapshot.key;
              // Remove from deletion list
              keysToDelete.remove(key);
              // Don't update if no change
              if (const DeepCollectionEquality()
                  .equals(snapshot.value, order)) {
                // no changes
                continue;
              } else {
                // Update product
                await _driver.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _driver.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _driver.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <StoreOwnDeliveryPartnersInfo>[];
        }
      });
    });
    return result;
  }
}

class StoreOwnDriverBindingWithStoreLocalDbRepository<
        T extends StoreOwnDeliveryPartnersInfo, R extends StoreEntity>
    implements Binding<List<StoreOwnDeliveryPartnersInfo>, List<StoreEntity>> {
  const StoreOwnDriverBindingWithStoreLocalDbRepository({
    required this.storeLocalDbRepository,
    required this.storeOwnDriverLocalDbRepository,
  });

  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  StoreRef<int, Map<String, dynamic>> get _driver =>
      AppDatabase.instance.driver;

  final StoreOwnDeliveryPartnersLocalDbRepository<T>
      storeOwnDriverLocalDbRepository;
  final StoreLocalDbRepository<R> storeLocalDbRepository;

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> binding(
      List<StoreOwnDeliveryPartnersInfo> source,
      List<StoreEntity> destination) async {
    final db = await _db;
    final stores = await storeLocalDbRepository.getAll();
    if (stores.isRight()) {
      var getAllCurrentStore = stores.right.toList();
      Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
      List<StoreOwnDeliveryPartnersInfo> toSelectedAdd = [];
      for (var selectedDestinationStore in destination.toSet().toList()) {
        for (var selectedDriver in source.toSet().toList()) {
          final bool equalityStatus = unOrdDeepEq(
              selectedDestinationStore.storeOwnDeliveryPartnersInfo
                  .toSet()
                  .toList(),
              source.toSet().toList());
          if (equalityStatus) {
            continue;
          } else {
            selectedDestinationStore.storeOwnDeliveryPartnersInfo
                .addAll(source);
          }
        }
      }
      List<StoreOwnDeliveryPartnersInfo> toAdd = [];
      for (var currentStoreStore in getAllCurrentStore) {
        for (var selectedStore in destination) {
          if (selectedStore.storeID == currentStoreStore.storeID) {
            currentStoreStore.storeOwnDeliveryPartnersInfo =
                selectedStore.storeOwnDeliveryPartnersInfo;
          } else {
            continue;
          }
        }
      }

      final result = await tryCatch<List<StoreEntity>>(() async {
        return await db.transaction((txn) async {
          // !Wrong the following code will deadlock
          // Don't use the db object in the transaction
          // await record.put(db, {'name': 'fish'});
          // correct, txn in used
          // Modify the store result
          // Delete all
          await _store.delete(txn);
          // Add all
          await _store.addAll(
              txn, getAllCurrentStore.map((e) => e.toMap()).toList());

          final snapshots = await _store.find(txn);
          if (snapshots.isEmptyOrNull) {
            return <StoreEntity>[];
          } else {
            return snapshots
                .map(
                  (snapshot) => StoreEntity.fromMap(snapshot.value).copyWith(
                    storeID: snapshot.key,
                  ),
                )
                .toList();
          }
        });
      });
      return result;
    } else {
      return Left(stores.left);
    }
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> unbinding(
      List<StoreOwnDeliveryPartnersInfo> source,
      List<StoreEntity> destination) async {
    final db = await _db;
    final stores = await storeLocalDbRepository.getAll();
    if (stores.isRight()) {
      var getAllCurrentStore = stores.right.toList();
      Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
      List<StoreOwnDeliveryPartnersInfo> toSelectedAdd = [];
      List<StoreOwnDeliveryPartnersInfo> listOfDestinationDriver = [];
      for (var selectedDestinationStore in destination.toSet().toList()) {
        listOfDestinationDriver.addAll(selectedDestinationStore
            .storeOwnDeliveryPartnersInfo
            .toSet()
            .toList());
        listOfDestinationDriver
            .removeWhere((element) => source.contains(element));
        selectedDestinationStore.storeOwnDeliveryPartnersInfo =
            listOfDestinationDriver;
      }
      List<StoreOwnDeliveryPartnersInfo> toAdd = [];
      for (var currentStoreStore in getAllCurrentStore) {
        for (var selectedStore in destination) {
          if (selectedStore.storeID == currentStoreStore.storeID) {
            currentStoreStore.storeOwnDeliveryPartnersInfo =
                selectedStore.storeOwnDeliveryPartnersInfo;
          } else {
            continue;
          }
        }
      }

      final result = await tryCatch<List<StoreEntity>>(() async {
        return await db.transaction((txn) async {
          // !Wrong the following code will deadlock
          // Don't use the db object in the transaction
          // await record.put(db, {'name': 'fish'});
          // correct, txn in used
          // Modify the store result
          // Delete all
          await _store.delete(txn);
          // Add all
          await _store.addAll(
              txn, getAllCurrentStore.map((e) => e.toMap()).toList());

          final snapshots = await _store.find(txn);
          if (snapshots.isEmptyOrNull) {
            return <StoreEntity>[];
          } else {
            return snapshots
                .map(
                  (snapshot) => StoreEntity.fromMap(snapshot.value).copyWith(
                    storeID: snapshot.key,
                  ),
                )
                .toList();
          }
        });
      });
      return result;
    } else {
      return Left(stores.left);
    }
  }
}

class StoreOwnDriverBindingWithCurrentUserLocalDbRepository<
        T extends StoreOwnDeliveryPartnersInfo, R extends AppUserEntity>
    implements Binding<List<StoreOwnDeliveryPartnersInfo>, AppUserEntity> {
  const StoreOwnDriverBindingWithCurrentUserLocalDbRepository({
    required this.storeOwnDriverLocalDbRepository,
    required this.userLocalDbRepository,
  });

  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  StoreRef<int, Map<String, dynamic>> get _user => AppDatabase.instance.user;

  final StoreOwnDeliveryPartnersLocalDbRepository<T>
      storeOwnDriverLocalDbRepository;
  final UserLocalDbRepository<R> userLocalDbRepository;

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> binding(
      List<StoreOwnDeliveryPartnersInfo> source,
      AppUserEntity destination) async {
    final db = await _db;
    final users = await userLocalDbRepository.getAll();
    if (users.isRight()) {
      // Todo:(prasant) - Check current user, now skip it
      final currentUserMap = cloneMap(users.right[0].toMap());
      var cacheStores =
          currentUserMap['drivers'] as List<StoreOwnDeliveryPartnersInfo>;

      final result = await tryCatch<AppUserEntity>(() async {
        await db.transaction((txn) async {
          // !Wrong the following code will deadlock
          // Don't use the db object in the transaction
          // await record.put(db, {'name': 'fish'});
          // correct, txn in used
          // Modify the store result
          final record = _user.record(users.right[0].userID);
          final value = await record.get(await txn);
          if (value != null) {
            var currentUser = cloneMap(value);
            currentUser['drivers'] = currentUserMap['drivers']
                as List<StoreOwnDeliveryPartnersInfo>
              ..addAll(source.toList());
            final result =
                await record.update(txn, {'drivers': currentUser['drivers']});
            if (result != null) {
              return AppUserEntity.fromMap(result);
            } else {
              return AppUserEntity.fromMap(currentUser);
            }
          } else {
            return AppUserEntity.fromMap(currentUserMap);
          }
        });
      });
      return result;
    } else {
      return Left(users.left);
    }
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> unbinding(
      List<StoreOwnDeliveryPartnersInfo> source,
      AppUserEntity destination) async {
    // TODO(prasant): implement unbinding
    throw UnimplementedError();
  }
}
