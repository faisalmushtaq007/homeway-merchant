part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreLocalDbRepository<Store extends StoreEntity>
    implements BaseStoreLocalDbRepository<StoreEntity> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity>> add(
      StoreEntity entity) async {
    final result = await tryCatch<StoreEntity>(() async {
      final int recordID = await _store.add(await _db, entity.toMap());
      //final StoreEntity recordStoreEntity = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(storeID: recordID), UniqueId(recordID));
      final value = await _store.record(recordID).get(await _db);
      if (value != null) {
        final storedStoreEntity = StoreEntity.fromMap(value);
        final storeEntity = storedStoreEntity.copyWith(storeID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(storeID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(StoreEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.storeID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _store.delete(
        await _db,
        finder: finder,
      );
      if (count >= 0) {
        return true;
      } else {
        return false;
      }
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
        await _store.delete(transaction);
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
      final value = await _store.record(uniqueId.value).get(await _db);
      if (value != null) {
        final int count = await _store.delete(
          await _db,
        );
        if (count >= 0) {
          return true;
        } else {
          return false;
        }
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> getAll() async {
    final result = await tryCatch<List<StoreEntity>>(() async {
      final snapshots = await _store.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <StoreEntity>[];
      } else {
        return snapshots
            .map((snapshot) => StoreEntity.fromMap(snapshot.value).copyWith(
                  storeID: snapshot.key,
                ))
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity?>> getById(
      UniqueId id) async {
    final result = await tryCatch<StoreEntity?>(() async {
      final value = await _store.record(id.value).get(await _db);
      if (value != null) {
        return StoreEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity>> update(
      StoreEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<StoreEntity>(() async {
      final int key = uniqueId.value;
      final value = await _store.record(key).get(await _db);
      if (value != null) {
        final result = await _store.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return StoreEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, StoreEntity>> upsert(
      {UniqueId? id,
      String? token,
      required StoreEntity entity,
      bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<StoreEntity>(() async {
      final int key = entity.storeID;
      final value = await _store.record(key).get(await _db);
      final result = await _store
          .record(key)
          .put(await _db, entity.toMap(), merge: (value != null) || false);
      return StoreEntity.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(
      UniqueId uniqueId, StoreEntity entity) {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity>> getByIdAndEntity(
      UniqueId uniqueId, StoreEntity entity) {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity>> updateByIdAndEntity(
      UniqueId uniqueId, StoreEntity entity) {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getStoreByIds(
      DatabaseClient db, List<int> ids) async {
    var snapshots = await _store.find(db,
        finder: Finder(
            filter: Filter.or(
                ids.map((e) => Filter.equals('storeID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{
      for (var snapshot in snapshots)
        snapshot.value['storeID']!.toString(): snapshot
    };
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>>
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
    final result = await tryCatch<List<StoreEntity>>(() async {
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
                  Filter.matchesRegExp(
                    'storeName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'menuEntities.@.menuName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'storeAvailableFoodTypes.@.title',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'storeAvailableFoodPreparationType.@.title',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'addons.@.title',
                    regExp,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'hasStoreOwnDeliveryPartners',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasNewStore',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasStoreOpened',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasReadyToPickupOrder',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasMenuAvailable',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasReadyToPickupOrder',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'addons.@.title',
                    filterRegExp,
                  ),
                  Filter.greaterThanOrEquals(
                      'storeOpeningTime', startTimeStamp ?? 0),
                  Filter.lessThanOrEquals(
                      'storeClosingTime', endTimeStamp ?? 0),
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
                  Filter.matchesRegExp(
                    'storeName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'menuEntities.@.menuName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'storeAvailableFoodTypes.@.title',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'storeAvailableFoodPreparationType.@.title',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'addons.@.title',
                    regExp,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'hasStoreOwnDeliveryPartners',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasNewStore',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasStoreOpened',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasReadyToPickupOrder',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasMenuAvailable',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'hasReadyToPickupOrder',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'addons.@.title',
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
        final recordSnapshots = await _store.find(
          await _db,
          finder: finder,
        );
        // Making a List<Category> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = StoreEntity.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            storeID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> saveAll({
    required List<StoreEntity> entities,
    bool hasUpdateAll = false,
  }) async {
    final result = await tryCatch<List<StoreEntity>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <StoreEntity>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(
            allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var storeIDs = convertOrderToMapObject
              .map((map) => map['storeID'] as int)
              .toList();
          var map = await getStoreByIds(db, storeIDs);
          // Watch for deleted item
          var keysToDelete = (await _store.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['storeID'] as int];
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
                await _store.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _store.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _store.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <StoreEntity>[];
        }
      });
    });
    return result;
  }
}

class StoreBindingWithUserLocalDbRepository<T extends StoreEntity,
        R extends AppUserEntity>
    implements Binding<List<StoreEntity>, AppUserEntity> {
  const StoreBindingWithUserLocalDbRepository({
    required this.storeLocalDbRepository,
    required this.userLocalDbRepository,
  });

  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _user => AppDatabase.instance.user;

  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  final StoreLocalDbRepository<T> storeLocalDbRepository;
  final UserLocalDbRepository<R> userLocalDbRepository;

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> binding(
      List<StoreEntity> source, AppUserEntity destination) async {
    final db = await _db;
    final users = await userLocalDbRepository.getAll();
    if (users.isRight()) {
      // Todo:(prasant) - Check current user, now skip it
      final currentUserMap = cloneMap(users.right[0].toMap());
      var cacheStores = currentUserMap['stores'] as List<StoreEntity>;

      final result = await tryCatch<AppUserEntity>(() async {
        await db.transaction((txn) async {
          // !Wrong the following code will deadlock
          // Don't use the db object in the transaction
          // await record.put(db, {'name': 'fish'});
          // correct, txn in used
          // Modify the store result
          final record = _user.record(users.right[0].userID);
          final value = await record.get(txn);
          if (value != null) {
            final currentUser = cloneMap(value);
            currentUser['stores'] = currentUserMap['stores']!
                as List<StoreEntity>
              ..addAll(source.toList());
            final result =
                await record.update(txn, {'stores': currentUser['stores']});
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
      List<StoreEntity> source, AppUserEntity destination) async {
    final db = await _db;
    final result = await tryCatch<AppUserEntity>(() async {
      await db.transaction((txn) async {
        // !Wrong the following code will deadlock
        // Don't use the db object in the transaction
        // await record.put(db, {'name': 'fish'});
        // correct, txn in used
      });
    });
    return result;
  }
}
