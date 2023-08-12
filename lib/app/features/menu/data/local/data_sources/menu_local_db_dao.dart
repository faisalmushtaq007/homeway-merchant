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
    final result = await tryCatch<List<MenuEntity>>(() async {
      final snapshots = await _menu.find(await _db);
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

class MenuBindingWithStoreLocalDbDbRepository<MenuEntity, StoreEntity> implements Binding<List<MenuEntity>, List<StoreEntity>> {
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _menu => AppDatabase.instance.menu;
  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> binding(List<MenuEntity> source, List<StoreEntity> destination) async {
    // TODO(prasant): implement binding
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> unbinding(List<MenuEntity> source, List<StoreEntity> destination) async {
    // TODO(prasant): implement unbinding
    throw UnimplementedError();
  }
}
