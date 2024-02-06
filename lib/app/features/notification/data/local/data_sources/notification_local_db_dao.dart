part of 'package:homemakers_merchant/app/features/notification/index.dart';

class NotificationLocalDbRepository<T extends NotificationEntity>
    implements BaseNotificationLocalDbRepository<NotificationEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _notification =>
      AppDatabase.instance.notification;
  @override
  Future<Either<RepositoryBaseFailure, NotificationEntity>> add(
      NotificationEntity entity) async {
    final result = await tryCatch<NotificationEntity>(() async {
      final int recordID = await _notification.add(await _db, entity.toJson());
      //final NotificationEntity recordNotificationEntity = entity.copyWith(storeID: recordID.toString());
      await update(
          entity.copyWith(notificationID: recordID), UniqueId(recordID));
      final value = await _notification.record(recordID).get(await _db);
      if (value != null) {
        final storedNotificationEntity = NotificationEntity.fromJson(value);
        final notificationEntity =
            storedNotificationEntity.copyWith(notificationID: recordID);
        return notificationEntity;
      } else {
        final notificationEntity = entity.copyWith(notificationID: recordID);
        return notificationEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(
      NotificationEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.notificationID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _notification.delete(
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
        await _notification.delete(transaction);
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
      final value = await _notification.record(uniqueId.value).get(await _db);
      if (value != null) {
        int? count = await _notification.record(uniqueId.value).delete(
              await _db,
            );
        if (count != null && count >= 0) {
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
      UniqueId uniqueId, NotificationEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<NotificationEntity>>>
      getAll() async {
    final result = await tryCatch<List<NotificationEntity>>(() async {
      final snapshots = await _notification.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <NotificationEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) =>
                  NotificationEntity.fromJson(snapshot.value).copyWith(
                notificationID: snapshot.key,
              ),
            )
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, NotificationEntity?>> getById(
      UniqueId id) async {
    final result = await tryCatch<NotificationEntity?>(() async {
      final value = await _notification.record(id.value).get(await _db);
      if (value != null) {
        return NotificationEntity.fromJson(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, NotificationEntity>> getByIdAndEntity(
      UniqueId uniqueId, NotificationEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, NotificationEntity>> update(
      NotificationEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<NotificationEntity>(() async {
      final int key = uniqueId.value;
      final value = await _notification.record(key).get(await _db);
      if (value != null) {
        final result = await _notification.record(key).update(
              await _db,
              entity.toJson(),
            );
        if (result != null) {
          return NotificationEntity.fromJson(result)
              .copyWith(notificationID: result['notificationID']);
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
  Future<Either<RepositoryBaseFailure, NotificationEntity>> updateByIdAndEntity(
      UniqueId uniqueId, NotificationEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, NotificationEntity>> upsert(
      {UniqueId? id,
      String? token,
      required NotificationEntity entity,
      bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<NotificationEntity>(() async {
      final int key = entity.notificationID;
      final value = await _notification.record(key).get(await _db);
      final result = await _notification
          .record(key)
          .put(await _db, entity.toJson(), merge: (value != null) || false);
      return NotificationEntity.fromJson(result)
          .copyWith(notificationID: result['notificationID']);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<NotificationEntity>>> saveAll(
      {required List<NotificationEntity> entities,
      bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<NotificationEntity>>(() async {
      final db = await _db;
      await db.transaction((transaction) async {
        // Delete all
        await _notification.delete(transaction);
        // Add all
        await _notification.addAll(
            transaction, entities.map((e) => e.toJson()).toList());
      });
      final result = await getAll();
      return result.fold((l) {
        return <NotificationEntity>[];
      }, (r) {
        return r.toList();
      });
    });
    return result;
  }
}
