part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class RateAndReviewLocalDbRepository<T extends RateAndReviewEntity>
    implements BaseRateAndReviewLocalDbRepository<RateAndReviewEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get rateAndReview =>
      AppDatabase.instance.rateAndReview;
  @override
  Future<Either<RepositoryBaseFailure, RateAndReviewEntity>> add(
      RateAndReviewEntity entity) async {
    final result = await tryCatch<RateAndReviewEntity>(() async {
      final int recordID = await rateAndReview.add(await _db, entity.toJson());
      //final RateAndReviewEntity recordRateAndReviewEntity = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(ratingID: recordID), UniqueId(recordID));
      final value = await rateAndReview.record(recordID).get(await _db);
      if (value != null) {
        final storedRateAndReviewEntity = RateAndReviewEntity.fromJson(value);
        final rateAndReviewEntity =
            storedRateAndReviewEntity.copyWith(ratingID: recordID);
        return rateAndReviewEntity;
      } else {
        final rateAndReviewEntity = entity.copyWith(ratingID: recordID);
        return rateAndReviewEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(
      RateAndReviewEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.ratingID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await rateAndReview.delete(
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
        await rateAndReview.delete(transaction);
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
      final value = await rateAndReview.record(uniqueId.value).get(await _db);
      if (value != null) {
        int? count = await rateAndReview.record(uniqueId.value).delete(
          await _db,
        );
        if (count!=null && count >= 0) {
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
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(
      UniqueId uniqueId, RateAndReviewEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<RateAndReviewEntity>>>
      getAll() async {
    final result = await tryCatch<List<RateAndReviewEntity>>(() async {
      final snapshots = await rateAndReview.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <RateAndReviewEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) =>
                  RateAndReviewEntity.fromJson(snapshot.value).copyWith(
                ratingID: snapshot.key,
              ),
            )
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, RateAndReviewEntity?>> getById(
      UniqueId id) async {
    final result = await tryCatch<RateAndReviewEntity?>(() async {
      final value = await rateAndReview.record(id.value).get(await _db);
      if (value != null) {
        return RateAndReviewEntity.fromJson(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, RateAndReviewEntity>> getByIdAndEntity(
      UniqueId uniqueId, RateAndReviewEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, RateAndReviewEntity>> update(
      RateAndReviewEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<RateAndReviewEntity>(() async {
      final int key = uniqueId.value;
      final value = await rateAndReview.record(key).get(await _db);
      if (value != null) {
        final result = await rateAndReview.record(key).update(
              await _db,
              entity.toJson(),
            );
        if (result != null) {
          return RateAndReviewEntity.fromJson(result);
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
  Future<Either<RepositoryBaseFailure, RateAndReviewEntity>>
      updateByIdAndEntity(UniqueId uniqueId, RateAndReviewEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, RateAndReviewEntity>> upsert(
      {UniqueId? id,
      String? token,
      required RateAndReviewEntity entity,
      bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<RateAndReviewEntity>(() async {
      final int key = entity.ratingID;
      final value = await rateAndReview.record(key).get(await _db);
      final result = await rateAndReview
          .record(key)
          .put(await _db, entity.toJson(), merge: (value != null) || false);
      return RateAndReviewEntity.fromJson(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<RateAndReviewEntity>>> saveAll(
      {required List<RateAndReviewEntity> entities,
      bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<RateAndReviewEntity>>(() async {
      final db = await _db;
      await db.transaction((transaction) async {
        // Delete all
        await rateAndReview.delete(transaction);
        // Add all
        await rateAndReview.addAll(
            transaction, entities.map((e) => e.toJson()).toList());
      });
      final result = await getAll();
      return result.fold((l) {
        return <RateAndReviewEntity>[];
      }, (r) {
        return r.toList();
      });
    });
    return result;
  }
}
