part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuLocalDbRepository<Menu extends MenuEntity> implements BaseMenuLocalDbRepository<MenuEntity> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _menu => AppDatabase.instance.menu;

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity>> add(MenuEntity entity) async {
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
  Future<Either<RepositoryBaseFailure, bool>> deleteById(UniqueId uniqueId) async {
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
    /*final result = await tryCatch<List<MenuEntity>>(() async {
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
    return result;*/
    final snapshots = await _menu.find(await _db);
    appLog.d("Menu: ${snapshots[0].value}");
    if (snapshots.isEmptyOrNull) {
      return Right(<MenuEntity>[]);
    } else {
      return Right(snapshots
          .map(
            (snapshot) => MenuEntity.fromMap(snapshot.value).copyWith(
              menuId: snapshot.key,
            ),
          )
          .toList(growable: false));
    }
  }

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity?>> getById(UniqueId id) async {
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
  Future<Either<RepositoryBaseFailure, MenuEntity>> update(MenuEntity entity, UniqueId uniqueId) async {
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
  Future<Either<RepositoryBaseFailure, MenuEntity>> upsert({UniqueId? id, String? token, required MenuEntity entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<MenuEntity>(() async {
      final int key = entity.menuId;
      final value = await _menu.record(key).get(await _db);
      final result = await _menu.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return MenuEntity.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, MenuEntity entity) {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity>> getByIdAndEntity(UniqueId uniqueId, MenuEntity entity) {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, MenuEntity>> updateByIdAndEntity(UniqueId uniqueId, MenuEntity entity) {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }
}

class MenuBindingWithStoreLocalDbDbRepository<T extends MenuEntity, R extends StoreEntity> implements Binding<List<MenuEntity>, List<StoreEntity>> {
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
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> binding(List<MenuEntity> source, List<StoreEntity> destination) async {
    final db = await _db;
    final stores = await storeLocalDbRepository.getAll();
    if (stores.isRight()) {
      var cacheCurrentStore = stores.right.toList();
      final result = await tryCatch<List<StoreEntity>>(() async {
        await db.transaction((txn) async {
          // !Wrong the following code will deadlock
          // Don't use the db object in the transaction
          // await record.put(db, {'name': 'fish'});
          // correct, txn in used
          // Modify the store result
          if (!cacheCurrentStore.isNotNullOrEmpty) {
            cacheCurrentStore.asMap().forEach((parentStoreKey, parentStoreValue) {
              destination.asMap().forEach((destinationStoreKey, destinationStoreValue) async {
                if (parentStoreValue.storeID == destinationStoreValue.storeID) {
                  // Match
                  final record = _store.record(destinationStoreValue.storeID);
                  final value = await record.get(txn);
                  var currentTempMenu = cloneMap(value!);
                  parentStoreValue.menuEntities.asMap().forEach((key, value) async {
                    source.asMap().forEach((menuKey, menuValue) async {
                      // Check if the record exists before adding or updating it.
                      // Look of existing record
                      var finder = Finder(filter: Filter.equals('stores.@.menus', menuValue.menuId));
                      var existing = await _store.query(finder: finder).getSnapshot(txn);
                      if (existing == null) {
                        // code not found, add
                        final data = currentTempMenu['menus']! as List<MenuEntity>..add(menuValue);
                        final result = await record.update(txn, {'menus': data.toList()});
                      } else {
                        // Update existing
                        await existing.ref.update(txn, menuValue.toMap());
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
          return storeLocalDbRepository.getAll();
        });
      });
      return result;
    } else {
      return Left(stores.left);
    }
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> unbinding(List<MenuEntity> source, List<StoreEntity> destination) async {
    // TODO(prasant): implement unbinding
    throw UnimplementedError();
  }
}

class MenuBindingWithCurrentUserLocalDbDbRepository<T extends MenuEntity, R extends AppUserEntity> implements Binding<List<MenuEntity>, AppUserEntity> {
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
  Future<Either<RepositoryBaseFailure, AppUserEntity>> binding(List<MenuEntity> source, AppUserEntity destination) async {
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
            currentUser['menus'] = currentUserMap['menus'] as List<MenuEntity>..addAll(source.toList());
            final result = await record.update(txn, {'menus': currentUser['menus']});
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
  Future<Either<RepositoryBaseFailure, AppUserEntity>> unbinding(List<MenuEntity> source, AppUserEntity destination) async {
    // TODO(prasant): implement unbinding
    throw UnimplementedError();
  }
}
