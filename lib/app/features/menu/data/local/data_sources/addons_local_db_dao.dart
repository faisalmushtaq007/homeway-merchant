part of 'package:homemakers_merchant/app/features/menu/index.dart';

class AddonsLocalDbRepository<Extras extends Addons>
    implements BaseAddonsLocalDbRepository<Addons> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _addons =>
      AppDatabase.instance.addons;

  @override
  Future<Either<RepositoryBaseFailure, Addons>> add(Addons entity) async {
    final result = await tryCatch<Addons>(() async {
      final int recordID = await _addons.add(await _db, entity.toMap());
      //final Addons recordAddons = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(addonsID: recordID), UniqueId(recordID));
      final value = await _addons.record(recordID).get(await _db);
      if (value != null) {
        final addonsEntity = Addons.fromMap(value);
        final addons = addonsEntity.copyWith(addonsID: recordID);
        return addons;
      } else {
        final addons = entity.copyWith(addonsID: recordID);
        return addons;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(Addons entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.addonsID;
      final finder = Finder(filter: Filter.byKey(key));
      await _addons.delete(
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
        await _addons.delete(transaction);
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
      final value = await _addons.record(uniqueId.value).get(await _db);
      if (value != null) {
        await _addons.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<Addons>>> getAll() async {
    final result = await tryCatch<List<Addons>>(() async {
      final snapshots = await _addons.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <Addons>[];
      } else {
        return snapshots
            .map((snapshot) => Addons.fromMap(snapshot.value).copyWith(
                  addonsID: snapshot.key,
                ))
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons?>> getById(UniqueId id) async {
    final result = await tryCatch<Addons?>(() async {
      final value = await _addons.record(id.value).get(await _db);
      if (value != null) {
        return Addons.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons>> update(
      Addons entity, UniqueId uniqueId) async {
    final result = await tryCatch<Addons>(() async {
      final int key = uniqueId.value;
      final value = await _addons.record(key).get(await _db);
      if (value != null) {
        final result = await _addons.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return Addons.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, Addons>> upsert(
      {UniqueId? id,
      String? token,
      required Addons entity,
      bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<Addons>(() async {
      final int key = entity.addonsID;
      final value = await _addons.record(key).get(await _db);
      final result = await _addons
          .record(key)
          .put(await _db, entity.toMap(), merge: (value != null) || false);
      return Addons.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(
      UniqueId uniqueId, Addons entity) {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons>> getByIdAndEntity(
      UniqueId uniqueId, Addons entity) {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons>> updateByIdAndEntity(
      UniqueId uniqueId, Addons entity) {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>>
      getCategoryByIds(DatabaseClient db, List<int> ids) async {
    var snapshots = await _addons.find(db,
        finder: Finder(
            filter: Filter.or(
                ids.map((e) => Filter.equals('addonsID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{
      for (var snapshot in snapshots)
        snapshot.value['addonsID']!.toString(): snapshot
    };
  }

  @override
  Future<Either<RepositoryBaseFailure, List<Addons>>> saveAll(
      {required List<Addons> entities, bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<Addons>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <Addons>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(
            allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var addonsIds = convertOrderToMapObject
              .map((map) => map['addonsID'] as int)
              .toList();
          var map = await getCategoryByIds(db, addonsIds);
          // Watch for deleted item
          var keysToDelete = (await _addons.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['addonsID'] as int];
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
                await _addons.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _addons.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _addons.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <Category>[];
        }
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<Addons>>> getAllWithPagination({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    final result = await tryCatch<List<Addons>>(() async {
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
                    'addons.title',
                    regExp,
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
            /*sortOrders: [
          SortOrder('orderDateTime'),
        ],*/
            limit: pageSize,
            offset: pageKey,
            filter: Filter.or([
              Filter.matchesRegExp(
                'addons.title',
                regExp,
              ),
            ]),
          );
        }
        // Else
        else {
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
          );
        }
        final recordSnapshots = await _addons.find(
          await _db,
          finder: finder,
        );
        // Making a List<Category> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = Addons.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            addonsID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }
}

class AddonsBindingWithMenuLocalDbDbRepository<T extends Addons,
    R extends MenuEntity> implements Binding<List<Addons>, List<MenuEntity>> {
  const AddonsBindingWithMenuLocalDbDbRepository({
    required this.addonsLocalDbRepository,
    required this.menuLocalDbRepository,
  });

  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _menu => AppDatabase.instance.menu;

  StoreRef<int, Map<String, dynamic>> get _addons =>
      AppDatabase.instance.addons;
  final AddonsLocalDbRepository<T> addonsLocalDbRepository;
  final MenuLocalDbRepository<R> menuLocalDbRepository;

  @override
  Future<Either<RepositoryBaseFailure, List<MenuEntity>>> binding(
      List<Addons> source, List<MenuEntity> destination) async {
    final db = await _db;
    final menus = await menuLocalDbRepository.getAll();
    if (menus.isRight()) {
      var cacheCurrentMenu = menus.right.toList();
      final result = await tryCatch<List<MenuEntity>>(() async {
        await db.transaction((txn) async {
          // !Wrong the following code will deadlock
          // Don't use the db object in the transaction
          // await record.put(db, {'name': 'fish'});
          // correct, txn in used
          // Modify the store result
          if (!cacheCurrentMenu.isNotNullOrEmpty) {
            cacheCurrentMenu.asMap().forEach((parentMenuKey, parentMenuValue) {
              destination
                  .asMap()
                  .forEach((destinationMenuKey, destinationMenuValue) async {
                if (parentMenuValue.menuId == destinationMenuValue.menuId) {
                  // Match
                  final record = _menu.record(destinationMenuValue.menuId);
                  final value = await record.get(txn);
                  var currentTempMenu = cloneMap(value!);
                  parentMenuValue.addons.asMap().forEach((key, value) async {
                    source.asMap().forEach((addonsKey, addonsValue) async {
                      // Check if the record exists before adding or updating it.
                      // Look of existing record
                      var finder = Finder(
                          filter: Filter.equals(
                              'menus.@.addons', addonsValue.addonsID));
                      var existing =
                          await _menu.query(finder: finder).getSnapshot(txn);
                      if (existing == null) {
                        // code not found, add
                        final data = currentTempMenu['addons']! as List<Addons>
                          ..add(addonsValue);
                        final result =
                            await record.update(txn, {'addons': data.toList()});
                      } else {
                        // Update existing
                        await existing.ref.update(txn, addonsValue.toMap());
                      }
                    });
                  });
                } else {
                  // Not Match
                }
              });
            });
          } else {
            // Null or empty
          }
          return menuLocalDbRepository.getAll();
        });
      });
      return result;
    } else {
      return Left(menus.left);
    }
  }

  @override
  Future<Either<RepositoryBaseFailure, List<MenuEntity>>> unbinding(
      List<Addons> source, List<MenuEntity> destination) async {
    // TODO(prasant): implement unbinding
    throw UnimplementedError();
  }
}

class AddonsBindingWithCurrentUserLocalDbDbRepository<T extends Addons,
    R extends AppUserEntity> implements Binding<List<Addons>, AppUserEntity> {
  const AddonsBindingWithCurrentUserLocalDbDbRepository({
    required this.addonsLocalDbRepository,
    required this.userLocalDbRepository,
  });

  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _addons =>
      AppDatabase.instance.addons;

  StoreRef<int, Map<String, dynamic>> get _user => AppDatabase.instance.user;

  final AddonsLocalDbRepository<T> addonsLocalDbRepository;
  final UserLocalDbRepository<R> userLocalDbRepository;

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> binding(
      List<Addons> source, AppUserEntity destination) async {
    final db = await _db;
    final users = await userLocalDbRepository.getAll();
    if (users.isRight()) {
      // Todo:(prasant) - Check current user, now skip it
      final currentUserMap = cloneMap(users.right[0].toMap());
      var cacheAddons = currentUserMap['addons'] as List<Addons>;

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
            var currentUser = cloneMap(value);
            currentUser['addons'] = currentUserMap['addons'] as List<Addons>
              ..addAll(source.toList());
            final result =
                await record.update(txn, {'addons': currentUser['addons']});
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
      List<Addons> source, AppUserEntity destination) async {
    // TODO(prasant): implement unbinding
    throw UnimplementedError();
  }
}
