part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UserBusinessProfileLocalDbRepository<T extends BusinessProfileEntity> implements BaseUserBusinessProfileEntityLocalDbRepository<BusinessProfileEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _businessProfile => AppDatabase.instance.businessProfile;
  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> add(BusinessProfileEntity entity) async {
    final result = await tryCatch<BusinessProfileEntity>(() async {
      final int recordID = await _businessProfile.add(await _db, entity.toMap());
      //final BusinessProfileEntity recordBusinessProfileEntity = entity.copyWith(businessProfileID: recordID.toString());
      final value = await _businessProfile.record(recordID).get(await _db);
      appLog.d('Save ${value ?? ''}');
      if (value != null) {
        final storedBusinessProfileEntity = BusinessProfileEntity.fromMap(value);
        final storeEntity = storedBusinessProfileEntity.copyWith(businessProfileID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(businessProfileID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(BusinessProfileEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.businessProfileID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _businessProfile.delete(
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
        await _businessProfile.delete(transaction);
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
      final value = await _businessProfile.record(uniqueId.value).get(await _db);
      if (value != null) {
        int counter = await _businessProfile.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, BusinessProfileEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<BusinessProfileEntity>>> getAll() async {
    final result = await tryCatch<List<BusinessProfileEntity>>(() async {
      final snapshots = await _businessProfile.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <BusinessProfileEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) => BusinessProfileEntity.fromMap(snapshot.value).copyWith(
                businessProfileID: snapshot.key,
              ),
            )
            .toList(growable: false);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity?>> getById(UniqueId id) async {
    final result = await tryCatch<BusinessProfileEntity?>(() async {
      final value = await _businessProfile.record(id.value).get(await _db);
      if (value != null) {
        return BusinessProfileEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> getByIdAndEntity(UniqueId uniqueId, BusinessProfileEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> update(BusinessProfileEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<BusinessProfileEntity>(() async {
      final int key = uniqueId.value;
      final value = await _businessProfile.record(key).get(await _db);
      if (value != null) {
        final result = await _businessProfile.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return BusinessProfileEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> updateByIdAndEntity(UniqueId uniqueId, BusinessProfileEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> upsert(
      {UniqueId? id, String? token, required BusinessProfileEntity entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<BusinessProfileEntity>(() async {
      final int key = entity.businessProfileID;
      final value = await _businessProfile.record(key).get(await _db);
      final result = await _businessProfile.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return BusinessProfileEntity.fromMap(result);
    });
    return result;
  }
}
