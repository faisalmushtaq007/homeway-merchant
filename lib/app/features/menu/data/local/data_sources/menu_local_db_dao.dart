part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuLocalDbRepository<Menu extends MenuEntity>
    implements BaseMenuLocalDbRepository<MenuEntity> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _menu => AppDatabase.instance.menu;

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity>> add(
      MenuEntity entity) async {
    final result = await tryCatch<MenuEntity>(() async {
      final int recordID = await _menu.add(await _db, entity.toMap());
      //final MenuEntity recordMenuEntity = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(menuId: recordID), UniqueId(recordID));
      final value = await _menu.record(recordID).get(await _db);
      if (value != null) {
        final storeEntity = MenuEntity.fromMap(value);
        final menuEntity = storeEntity.copyWith(menuId: recordID);
        return menuEntity;
      } else {
        final menuEntity = entity.copyWith(menuId: recordID);
        return menuEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(MenuEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.menuId;
      final finder = Finder(filter: Filter.byKey(key));
      await _menu.delete(
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
        await _menu.delete(transaction);
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
      final value = await _menu.record(uniqueId.value).get(await _db);
      if (value != null) {
        int counter = await _menu.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<MenuEntity>>> getAll() async {
    final result = await tryCatch<List<MenuEntity>>(() async {
      final snapshots = await _menu.find(await _db);
      appLog.d("Menu: ${snapshots[0].value}");
      if (snapshots.isEmptyOrNull) {
        return <MenuEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) => MenuEntity.fromMap(snapshot.value).copyWith(
                menuId: snapshot.key,
              ),
            )
            .toList(growable: false);
      }
    });
    return result;
    /*final snapshots = await _menu.find(await _db);
    if (snapshots.isEmptyOrNull) {
      return Right(<MenuEntity>[]);
    } else {
      return Right(snapshots
          .map(
            (snapshot) => MenuEntity.fromMap(snapshot.value).copyWith(
              menuId: snapshot.key,
            ),
          )
          .toList());
    }*/
  }

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity?>> getById(
      UniqueId id) async {
    final result = await tryCatch<MenuEntity?>(() async {
      final value = await _menu.record(id.value).get(await _db);
      if (value != null) {
        return MenuEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity>> update(
      MenuEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<MenuEntity>(() async {
      final int key = uniqueId.value;
      final value = await _menu.record(key).get(await _db);
      if (value != null) {
        final result = await _menu.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return MenuEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, MenuEntity>> upsert(
      {UniqueId? id,
      String? token,
      required MenuEntity entity,
      bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<MenuEntity>(() async {
      final int key = entity.menuId;
      final value = await _menu.record(key).get(await _db);
      final result = await _menu
          .record(key)
          .put(await _db, entity.toMap(), merge: (value != null) || false);
      return MenuEntity.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(
      UniqueId uniqueId, MenuEntity entity) {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity>> getByIdAndEntity(
      UniqueId uniqueId, MenuEntity entity) {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity>> updateByIdAndEntity(
      UniqueId uniqueId, MenuEntity entity) {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>>
      getCategoryByIds(DatabaseClient db, List<int> ids) async {
    var snapshots = await _menu.find(db,
        finder: Finder(
            filter: Filter.or(
                ids.map((e) => Filter.equals('menuId', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{
      for (var snapshot in snapshots)
        snapshot.value['menuId']!.toString(): snapshot
    };
  }

  @override
  Future<Either<RepositoryBaseFailure, List<MenuEntity>>> saveAll(
      {required List<MenuEntity> entities, bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<MenuEntity>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <MenuEntity>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(
            allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var menuIds = convertOrderToMapObject
              .map((map) => map['menuId'] as int)
              .toList();
          var map = await getCategoryByIds(db, menuIds);
          // Watch for deleted item
          var keysToDelete = (await _menu.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['menuId'] as int];
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
                await _menu.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _menu.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _menu.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <MenuEntity>[];
        }
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<MenuEntity>>> getAllWithPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    final result = await tryCatch<List<MenuEntity>>(() async {
      final db = await _db;
      return await db.transaction((transaction) async {
        // Finder object can also sort data.
        Finder finder = Finder(
          limit: pageSize,
          offset: pageKey,
        );
        // If
        if ((searchText.isNotNull || filter.isNotNull || sorting.isNotNull && (searchText!.isNotEmpty || filter!.isNotEmpty || sorting!.isNotEmpty)) &&
                (startTimeStamp.isNotNull || endTimeStamp.isNotNull)) {
          var regExp = RegExp('^${searchText ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matches('menuName', '^${searchText}'),
                  Filter.matches('menuName', '${searchText}\$'),
                  Filter.matches('menuName', '${searchText}'),
                  Filter.matchesRegExp(
                    'menuName',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('menuCategories.@.title', '^${searchText}'),
                  Filter.matches('menuCategories.@.title', '${searchText}\$'),
                  Filter.matches('menuCategories.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'menuCategories.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('ingredients.@.title', '^${searchText}'),
                  Filter.matches('ingredients.@.title', '${searchText}\$'),
                  Filter.matches('ingredients.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'ingredients.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('storeAvailableFoodTypes.@.title', '^${searchText}'),
                  Filter.matches('storeAvailableFoodTypes.@.title', '${searchText}\$'),
                  Filter.matches('storeAvailableFoodTypes.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'storeAvailableFoodTypes.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('storeAvailableFoodPreparationType.@.title', '^${searchText}'),
                  Filter.matches('storeAvailableFoodPreparationType.@.title', '${searchText}\$'),
                  Filter.matches('storeAvailableFoodPreparationType.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'storeAvailableFoodPreparationType.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('addons.@.title', '^${searchText}'),
                  Filter.matches('addons.@.title', '${searchText}\$'),
                  Filter.matches('addons.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'addons.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'menuName',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'menuCategories.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'ingredients.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'storeAvailableFoodTypes.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'hasMenuAvailable',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'hasReadyToPickupOrder',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'addons.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                ]),
              ],
            ),
          );
        }
        // Else If
        else if (searchText.isNotNull || filter.isNotNull || sorting.isNotNull && (searchText!.isNotEmpty || filter!.isNotEmpty || sorting!.isNotEmpty)) {
          if(searchText!.isEmpty){
            finder = Finder(
              limit: pageSize,
              offset: pageKey,
            );
          }else {
          var regExp = RegExp('^${searchText ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matches('menuName', '^${searchText}'),
                  Filter.matches('menuName', '${searchText}\$'),
                  Filter.matches('menuName', '${searchText}'),
                  Filter.matchesRegExp(
                    'menuName',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('menuCategories.@.title', '^${searchText}'),
                  Filter.matches('menuCategories.@.title', '${searchText}\$'),
                  Filter.matches('menuCategories.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'menuCategories.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('ingredients.@.title', '^${searchText}'),
                  Filter.matches('ingredients.@.title', '${searchText}\$'),
                  Filter.matches('ingredients.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'ingredients.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('storeAvailableFoodTypes.@.title', '^${searchText}'),
                  Filter.matches('storeAvailableFoodTypes.@.title', '${searchText}\$'),
                  Filter.matches('storeAvailableFoodTypes.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'storeAvailableFoodTypes.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('storeAvailableFoodPreparationType.@.title', '^${searchText}'),
                  Filter.matches('storeAvailableFoodPreparationType.@.title', '${searchText}\$'),
                  Filter.matches('storeAvailableFoodPreparationType.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'storeAvailableFoodPreparationType.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matches('addons.@.title', '^${searchText}'),
                  Filter.matches('addons.@.title', '${searchText}\$'),
                  Filter.matches('addons.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'addons.@.title',
                    regExp,
                    anyInList: true,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'menuName',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'menuCategories.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'ingredients.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'storeAvailableFoodTypes.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'hasMenuAvailable',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'hasReadyToPickupOrder',
                    filterRegExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'addons.@.title',
                    filterRegExp,
                    anyInList: true,
                  ),
                ]),
              ],
            ),
          );}
        }
        // Else
        else {
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
          );
        }
        final recordSnapshots = await _menu.find(
          await _db,
          finder: finder,
        );
        // Making a List<Category> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = MenuEntity.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            menuId: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }
}

class MenuBindingWithStoreLocalDbDbRepository<T extends MenuEntity,
        R extends StoreEntity>
    implements Binding<List<MenuEntity>, List<StoreEntity>> {
  const MenuBindingWithStoreLocalDbDbRepository({
    required this.menuLocalDbRepository,
    required this.storeLocalDbRepository,
  });

  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _menu => AppDatabase.instance.menu;

  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  final MenuLocalDbRepository<T> menuLocalDbRepository;
  final StoreLocalDbRepository<R> storeLocalDbRepository;

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> binding(
      List<MenuEntity> source, List<StoreEntity> destination) async {
    final db = await _db;
    final stores = await storeLocalDbRepository.getAll();
    if (stores.isRight()) {
      var getAllCurrentStore = stores.right.toList();
      Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
      List<MenuEntity> toSelectedAdd = [];
      for (var selectedDestinationStore in destination.toSet().toList()) {
        for (var selectedMenu in source.toSet().toList()) {
          final bool equalityStatus = unOrdDeepEq(
              selectedDestinationStore.menuEntities.toSet().toList(),
              source.toSet().toList());
          if (equalityStatus) {
            continue;
          } else {
            selectedDestinationStore.menuEntities.addAll(source);
          }
        }
      }
      List<MenuEntity> toAdd = [];
      for (var currentStoreStore in getAllCurrentStore) {
        for (var selectedStore in destination) {
          if (selectedStore.storeID == currentStoreStore.storeID) {
            currentStoreStore.menuEntities = selectedStore.menuEntities;
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
      List<MenuEntity> source, List<StoreEntity> destination) async {
    final db = await _db;
    final stores = await storeLocalDbRepository.getAll();
    if (stores.isRight()) {
      var getAllCurrentStore = stores.right.toList();
      Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
      List<MenuEntity> toSelectedAdd = [];
      List<MenuEntity> listOfDestinationMenu = [];
      for (var selectedDestinationStore in destination.toSet().toList()) {
        listOfDestinationMenu
            .addAll(selectedDestinationStore.menuEntities.toSet().toList());
        listOfDestinationMenu
            .removeWhere((element) => source.contains(element));
        selectedDestinationStore.menuEntities = listOfDestinationMenu;
      }
      List<MenuEntity> toAdd = [];
      for (var currentStoreStore in getAllCurrentStore) {
        for (var selectedStore in destination) {
          if (selectedStore.storeID == currentStoreStore.storeID) {
            currentStoreStore.menuEntities = selectedStore.menuEntities;
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

class MenuBindingWithCurrentUserLocalDbDbRepository<T extends MenuEntity,
        R extends AppUserEntity>
    implements Binding<List<MenuEntity>, AppUserEntity> {
  const MenuBindingWithCurrentUserLocalDbDbRepository({
    required this.menuLocalDbRepository,
    required this.userLocalDbRepository,
  });

  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _menu => AppDatabase.instance.menu;

  StoreRef<int, Map<String, dynamic>> get _user => AppDatabase.instance.user;

  final MenuLocalDbRepository<T> menuLocalDbRepository;
  final UserLocalDbRepository<R> userLocalDbRepository;

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> binding(
      List<MenuEntity> source, AppUserEntity destination) async {
    final db = await _db;
    final users = await userLocalDbRepository.getAll();
    if (users.isRight()) {
      // Todo:(prasant) - Check current user, now skip it
      final currentUserMap = cloneMap(users.right[0].toMap());
      var cacheMenus = currentUserMap['menus'] as List<MenuEntity>;

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
            currentUser['menus'] = currentUserMap['menus'] as List<MenuEntity>
              ..addAll(source.toList());
            final result =
                await record.update(txn, {'menus': currentUser['menus']});
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
      List<MenuEntity> source, AppUserEntity destination) async {
    // TODO(prasant): implement unbinding
    throw UnimplementedError();
  }
}
