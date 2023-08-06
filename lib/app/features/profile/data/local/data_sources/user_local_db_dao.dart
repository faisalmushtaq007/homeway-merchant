import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/profile/data/local/data_sources/user_local_db_base_repository.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';

import 'package:homemakers_merchant/core/local/database/app_database.dart';
import 'package:homemakers_merchant/core/local/database/base/identifiable.dart';
import 'package:homemakers_merchant/core/local/database/base/repository_failure.dart';
import 'package:homemakers_merchant/core/local/database/base/tryCatch.dart';
import 'package:homemakers_merchant/utils/functional/either/either.dart';
import 'package:sembast/sembast.dart';

import 'package:sembast/utils/value_utils.dart';

class UserLocalDbRepository<User extends AppUserEntity> implements BaseUserLocalDbRepository<AppUserEntity> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> add(AppUserEntity entity) async {
    final result = await tryCatch<AppUserEntity>(() async {
      final int recordID = await _store.add(await _db, entity.toMap());
      //final AppUserEntity recordAppUserEntity = entity.copyWith(storeID: recordID.toString());
      final value = await _store.record(recordID).get(await _db);
      if (value != null) {
        return AppUserEntity.fromMap(value).copyWith(userID: recordID);
      } else {
        return entity.copyWith(userID: recordID);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(AppUserEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.userID;
      final finder = Finder(filter: Filter.byKey(key));
      await _store.delete(
        await _db,
        finder: finder,
      );
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll() async {
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
  Future<Either<RepositoryBaseFailure, List<AppUserEntity>>> getAll() async {
    final result = await tryCatch<List<AppUserEntity>>(() async {
      final snapshots = await _store.find(await _db);
      return snapshots
          .map((snapshot) => AppUserEntity.fromMap(snapshot.value).copyWith(
                userID: snapshot.key,
              ))
          .toList(growable: false);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity?>> getById(UniqueId id) async {
    final result = await tryCatch<AppUserEntity?>(() async {
      final value = await _store.record(id.value).get(await _db);
      if (value != null) {
        return AppUserEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> update(AppUserEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<AppUserEntity>(() async {
      final int key = entity.userID;
      final value = await _store.record(key).get(await _db);
      final result = await _store.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return AppUserEntity.fromMap(result);
    });
    return result;
  }
}
