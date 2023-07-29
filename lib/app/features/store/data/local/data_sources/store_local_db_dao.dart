import 'package:flutter/cupertino.dart';
import 'package:homemakers_merchant/app/features/store/data/local/data_sources/store_local_db_base_repository.dart';
import 'package:homemakers_merchant/core/local/database/app_database.dart';
import 'package:homemakers_merchant/core/local/database/base/identifiable.dart';
import 'package:homemakers_merchant/core/local/database/base/repository_failure.dart';
import 'package:homemakers_merchant/core/local/database/base/tryCatch.dart';
import 'package:homemakers_merchant/utils/functional/either/either.dart';
import 'package:sembast/sembast.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:sembast/utils/value_utils.dart';

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
      await _store.delete(
        await _db,
        finder: finder,
      );
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll(StoreEntity entity) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteById(UniqueId uniqueId) async {
    final result = await tryCatch<bool>(() async {
      final value = await _store.record(uniqueId.value).get(await _db);
      if (value != null) {
        await _store.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<StoreEntity>>> getAll() async {
    final result = await tryCatch<List<StoreEntity>>(() async {
      final snapshots = await _store.find(await _db);
      return snapshots
          .map((snapshot) => StoreEntity.fromMap(snapshot.value).copyWith(
                storeID: snapshot.key,
              ))
          .toList(growable: false);
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
}
