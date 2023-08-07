part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreLocalDbRepository<Store extends StoreEntity> implements BaseStoreLocalDbRepository<StoreEntity> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity>> add(StoreEntity entity) async {
    final result = await tryCatch<StoreEntity>(() async {
      final int recordID = await _store.add(await _db, entity.toMap());
      //final StoreEntity recordStoreEntity = entity.copyWith(storeID: recordID.toString());
      final value = await _store.record(recordID).get(await _db);
      if (value != null) {
        return StoreEntity.fromMap(value).copyWith(storeID: recordID);
      } else {
        return entity.copyWith(storeID: recordID);
      }
    });
    return result;
    /*final int recordID = await _store.add(await _db, entity.toMap());
    //final StoreEntity recordStoreEntity = entity.copyWith(storeID: recordID.toString());
    final value = await _store.record(recordID).get(await _db);
    if (value != null) {
      debugPrint('Save value ${value}');
      return Right(StoreEntity.fromMap(value).copyWith(storeID: recordID));
    } else {
      return Right(entity.copyWith(storeID: recordID));
    }*/
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
  Future<Either<RepositoryBaseFailure, bool>> deleteById(UniqueId uniqueId) async {
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
            .toList(growable: false);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity?>> getById(UniqueId id) async {
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
  Future<Either<RepositoryBaseFailure, StoreEntity>> update(StoreEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<StoreEntity>(() async {
      final int key = entity.storeID;
      final value = await _store.record(key).get(await _db);
      final result = await _store.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return StoreEntity.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, StoreEntity entity) {
    // TODO: implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity>> getByIdAndEntity(UniqueId uniqueId, StoreEntity entity) {
    // TODO: implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreEntity>> updateByIdAndEntity(UniqueId uniqueId, StoreEntity entity) {
    // TODO: implement updateByIdAndEntity
    throw UnimplementedError();
  }
}
