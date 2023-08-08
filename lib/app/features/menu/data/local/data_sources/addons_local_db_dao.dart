part of 'package:homemakers_merchant/app/features/menu/index.dart';

class AddonsLocalDbRepository<Extras extends Addons> implements BaseAddonsLocalDbRepository<Addons> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _addons => AppDatabase.instance.addons;

  @override
  Future<Either<RepositoryBaseFailure, Addons>> add(Addons entity) async {
    final result = await tryCatch<Addons>(() async {
      final int recordID = await _addons.add(await _db, entity.toMap());
      //final Addons recordAddons = entity.copyWith(storeID: recordID.toString());
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
  Future<Either<RepositoryBaseFailure, bool>> deleteById(UniqueId uniqueId) async {
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
            .toList(growable: false);
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
  Future<Either<RepositoryBaseFailure, Addons>> update(Addons entity, UniqueId uniqueId) async {
    final result = await tryCatch<Addons>(() async {
      final int key = entity.addonsID;
      final value = await _addons.record(key).get(await _db);
      final result = await _addons.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return Addons.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, Addons entity) {
    // TODO: implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons>> getByIdAndEntity(UniqueId uniqueId, Addons entity) {
    // TODO: implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons>> updateByIdAndEntity(UniqueId uniqueId, Addons entity) {
    // TODO: implement updateByIdAndEntity
    throw UnimplementedError();
  }
}

class AddonsBindingWithMenuLocalDbDbRepository<Addons, MenuEntity> implements BaseRepositoryBindOperation<Addons, MenuEntity> {
  @override
  BindingSourceToDestinationFunc<Addons, MenuEntity> binding(List<Addons> source, List<MenuEntity> destination) {
    // TODO: implement binding
    throw UnimplementedError();
  }
}
