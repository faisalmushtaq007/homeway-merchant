part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UserBusinessDocumentLocalDbRepository<T extends BusinessDocumentUploadedEntity>
    implements BaseUserBusinessDocumentEntityLocalDbRepository<BusinessDocumentUploadedEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _businessDocument => AppDatabase.instance.businessDocument;
  @override
  Future<Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity>> add(BusinessDocumentUploadedEntity entity) async {
    final result = await tryCatch<BusinessDocumentUploadedEntity>(() async {
      final int recordID = await _businessDocument.add(await _db, entity.toMap());
      //final BusinessDocumentUploadedEntity recordBusinessDocumentUploadedEntity = entity.copyWith(documentID: recordID.toString());
      final value = await _businessDocument.record(recordID).get(await _db);
      if (value != null) {
        final storedBusinessDocumentUploadedEntity = BusinessDocumentUploadedEntity.fromMap(value);
        final storeEntity = storedBusinessDocumentUploadedEntity.copyWith(documentID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(documentID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(BusinessDocumentUploadedEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.documentID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _businessDocument.delete(
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
        await _businessDocument.delete(transaction);
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
      final value = await _businessDocument.record(uniqueId.value).get(await _db);
      if (value != null) {
        int counter = await _businessDocument.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, BusinessDocumentUploadedEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<BusinessDocumentUploadedEntity>>> getAll() async {
    final result = await tryCatch<List<BusinessDocumentUploadedEntity>>(() async {
      final snapshots = await _businessDocument.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <BusinessDocumentUploadedEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) => BusinessDocumentUploadedEntity.fromMap(snapshot.value).copyWith(
                documentID: snapshot.key,
              ),
            )
            .toList(growable: false);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity?>> getById(UniqueId id) async {
    final result = await tryCatch<BusinessDocumentUploadedEntity?>(() async {
      final value = await _businessDocument.record(id.value).get(await _db);
      if (value != null) {
        return BusinessDocumentUploadedEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity>> getByIdAndEntity(UniqueId uniqueId, BusinessDocumentUploadedEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity>> update(BusinessDocumentUploadedEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<BusinessDocumentUploadedEntity>(() async {
      final int key = uniqueId.value;
      final value = await _businessDocument.record(key).get(await _db);
      if (value != null) {
        final result = await _businessDocument.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return BusinessDocumentUploadedEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity>> updateByIdAndEntity(UniqueId uniqueId, BusinessDocumentUploadedEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessDocumentUploadedEntity>> upsert(
      {UniqueId? id, String? token, required BusinessDocumentUploadedEntity entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<BusinessDocumentUploadedEntity>(() async {
      final int key = entity.documentID;
      final value = await _businessDocument.record(key).get(await _db);
      final result = await _businessDocument.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return BusinessDocumentUploadedEntity.fromMap(result);
    });
    return result;
  }
}
