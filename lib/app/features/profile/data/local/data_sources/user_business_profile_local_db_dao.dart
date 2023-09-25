part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UserBusinessProfileLocalDbRepository<T extends BusinessProfileEntity>
    implements
        BaseUserBusinessProfileEntityLocalDbRepository<BusinessProfileEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _businessProfile =>
      AppDatabase.instance.businessProfile;

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> add(
      BusinessProfileEntity entity) async {
    final result = await tryCatch<BusinessProfileEntity>(() async {
      final int recordID =
          await _businessProfile.add(await _db, entity.toMap());
      //final BusinessProfileEntity recordBusinessProfileEntity = entity.copyWith(businessProfileID: recordID.toString());
      await update(
          entity.copyWith(businessProfileID: recordID), UniqueId(recordID));
      final value = await _businessProfile.record(recordID).get(await _db);
      appLog.d('Save ${value ?? ''}');
      if (value != null) {
        final storedBusinessProfileEntity =
            BusinessProfileEntity.fromMap(value);
        final storeEntity =
            storedBusinessProfileEntity.copyWith(businessProfileID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(businessProfileID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(
      BusinessProfileEntity entity) async {
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
  Future<Either<RepositoryBaseFailure, bool>> deleteById(
      UniqueId uniqueId) async {
    final result = await tryCatch<bool>(() async {
      final value =
          await _businessProfile.record(uniqueId.value).get(await _db);
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
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(
      UniqueId uniqueId, BusinessProfileEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<BusinessProfileEntity>>>
      getAll() async {
    final result = await tryCatch<List<BusinessProfileEntity>>(() async {
      final snapshots = await _businessProfile.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <BusinessProfileEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) =>
                  BusinessProfileEntity.fromMap(snapshot.value).copyWith(
                businessProfileID: snapshot.key,
              ),
            )
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity?>> getById(
      UniqueId id) async {
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
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> getByIdAndEntity(
      UniqueId uniqueId, BusinessProfileEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> update(
      BusinessProfileEntity entity, UniqueId uniqueId) async {
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
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>>
      updateByIdAndEntity(
          UniqueId uniqueId, BusinessProfileEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, BusinessProfileEntity>> upsert(
      {UniqueId? id,
      String? token,
      required BusinessProfileEntity entity,
      bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<BusinessProfileEntity>(() async {
      final int key = entity.businessProfileID;
      final value = await _businessProfile.record(key).get(await _db);
      final result = await _businessProfile
          .record(key)
          .put(await _db, entity.toMap(), merge: (value != null) || false);
      return BusinessProfileEntity.fromMap(result);
    });
    return result;
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>>
      getBusinessProfileEntityByIds(DatabaseClient db, List<int> ids) async {
    var snapshots = await _businessProfile.find(db,
        finder: Finder(
            filter: Filter.or(ids
                .map((e) => Filter.equals('businessProfileID', e))
                .toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{
      for (var snapshot in snapshots)
        snapshot.value['businessProfileID']!.toString(): snapshot
    };
  }

  @override
  Future<Either<RepositoryBaseFailure, List<BusinessProfileEntity>>>
      getAllWithPagination({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    final result = await tryCatch<List<BusinessProfileEntity>>(() async {
      final db = await _db;
      return await db.transaction((transaction) async {
        // Finder object can also sort data.
        Finder finder = Finder(
          limit: pageSize,
          offset: pageKey,
        );
        // If
        if (searchText.isNotNull ||
            filter.isNotNull ||
            sorting.isNotNull &&
                (startTimeStamp.isNotNull || endTimeStamp.isNotNull)) {
          var regExp = RegExp('^${searchText?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting?.toLowerCase() ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matchesRegExp(
                    'userName',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'businessPhoneNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'businessEmailAddress',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'businessName',
                    regExp,
                    anyInList: true,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'businessTypeEntity.businessTypeName',
                    filterRegExp,
                    anyInList: true,
                  ),
                ]),
              ],
            ),
          );
        }
        // Else If
        else if (searchText.isNotNull ||
            filter.isNotNull ||
            sorting.isNotNull) {
          var regExp = RegExp('^${searchText?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter?.toLowerCase() ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting?.toLowerCase() ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matchesRegExp(
                    'userName',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'businessPhoneNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'businessEmailAddress',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'businessName',
                    regExp,
                    anyInList: true,
                  ),
                  // Filter
                  Filter.matchesRegExp(
                    'businessTypeEntity.businessTypeName',
                    filterRegExp,
                    anyInList: true,
                  ),
                ]),
              ],
            ),
          );
        }
        // Else
        else {
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
          );
        }
        final recordSnapshots = await _businessProfile.find(
          await _db,
          finder: finder,
        );
        // Making a List<BusinessProfileEntity> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = BusinessProfileEntity.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            businessProfileID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<BusinessProfileEntity>>> saveAll({
    required List<BusinessProfileEntity> entities,
    bool hasUpdateAll = false,
  }) async {
    final result = await tryCatch<List<BusinessProfileEntity>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <BusinessProfileEntity>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(
            allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var businessProfileIDs = convertOrderToMapObject
              .map((map) => map['businessProfileID'] as int)
              .toList();
          var map = await getBusinessProfileEntityByIds(db, businessProfileIDs);
          // Watch for deleted item
          var keysToDelete =
              (await _businessProfile.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['businessProfileID'].toString()];
            if (snapshot != null) {
              // The record current key
              var key = snapshot.key;
              // Remove from deletion list
              keysToDelete.remove(key);
              // Don't update if no change
              if (const DeepCollectionEquality()
                  .equals(snapshot.value, order)) {
                // no changes
                continue;
              } else {
                // Update product
                await _businessProfile.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _businessProfile.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _businessProfile.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <BusinessProfileEntity>[];
        }
      });
    });
    return result;
  }
}
