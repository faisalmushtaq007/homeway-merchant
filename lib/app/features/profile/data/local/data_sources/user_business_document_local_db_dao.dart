part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UserBusinessDocumentLocalDbRepository<T extends NewBusinessDocumentEntity>
    implements BaseUserBusinessDocumentEntityLocalDbRepository<NewBusinessDocumentEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _businessDocument => AppDatabase.instance.businessDocument;

  @override
  Future<Either<RepositoryBaseFailure, NewBusinessDocumentEntity>> add(NewBusinessDocumentEntity entity) async {
    final result = await tryCatch<NewBusinessDocumentEntity>(() async {
      final int recordID = await _businessDocument.add(await _db, entity.toMap());
      //final NewBusinessDocumentEntity recordNewBusinessDocumentEntity = entity.copyWith(documentID: recordID.toString());
      await update(entity.copyWith(documentID: recordID), UniqueId(recordID));
      final value = await _businessDocument.record(recordID).get(await _db);
      if (value != null) {
        final storedNewBusinessDocumentEntity = NewBusinessDocumentEntity.fromMap(value);
        final storeEntity = storedNewBusinessDocumentEntity.copyWith(documentID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(documentID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(NewBusinessDocumentEntity entity) async {
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
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, NewBusinessDocumentEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<NewBusinessDocumentEntity>>> getAll() async {
    final result = await tryCatch<List<NewBusinessDocumentEntity>>(() async {
      final snapshots = await _businessDocument.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <NewBusinessDocumentEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) => NewBusinessDocumentEntity.fromMap(snapshot.value).copyWith(
                documentID: snapshot.key,
              ),
            )
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, NewBusinessDocumentEntity?>> getById(UniqueId id) async {
    final result = await tryCatch<NewBusinessDocumentEntity?>(() async {
      final value = await _businessDocument.record(id.value).get(await _db);
      if (value != null) {
        return NewBusinessDocumentEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, NewBusinessDocumentEntity>> getByIdAndEntity(UniqueId uniqueId, NewBusinessDocumentEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, NewBusinessDocumentEntity>> update(NewBusinessDocumentEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<NewBusinessDocumentEntity>(() async {
      final int key = uniqueId.value;
      final value = await _businessDocument.record(key).get(await _db);
      if (value != null) {
        final result = await _businessDocument.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return NewBusinessDocumentEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, NewBusinessDocumentEntity>> updateByIdAndEntity(UniqueId uniqueId, NewBusinessDocumentEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, NewBusinessDocumentEntity>> upsert(
      {UniqueId? id, String? token, required NewBusinessDocumentEntity entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<NewBusinessDocumentEntity>(() async {
      final int key = entity.documentID;
      final value = await _businessDocument.record(key).get(await _db);
      final result = await _businessDocument.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return NewBusinessDocumentEntity.fromMap(result);
    });
    return result;
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getDocumentByIds(DatabaseClient db, List<int> ids) async {
    var snapshots = await _businessDocument.find(db, finder: Finder(filter: Filter.or(ids.map((e) => Filter.equals('documentID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{for (var snapshot in snapshots) snapshot.value['documentID']!.toString(): snapshot};
  }

  @override
  Future<Either<RepositoryBaseFailure, List<NewBusinessDocumentEntity>>> getAllWithPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    final result = await tryCatch<List<NewBusinessDocumentEntity>>(() async {
      final db = await _db;
      return await db.transaction((transaction) async {
        // Finder object can also sort data.
        Finder finder = Finder(
          limit: pageSize,
          offset: pageKey,
        );
        // If
        if (searchText.isNotNull || filter.isNotNull || sorting.isNotNull && (startTimeStamp.isNotNull || endTimeStamp.isNotNull)) {
          var regExp = RegExp(searchText ?? '', caseSensitive: false);
          var filterRegExp = RegExp(filter ?? '', caseSensitive: false);
          var sortingRegExp = RegExp(sorting ?? '', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matchesRegExp(
                    'documentIDNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'documentType',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'documentType',
                    filterRegExp,
                    anyInList: true,
                  ),
                ]),
              ],
            ),
          );
        }
        // Else If
        else if (searchText.isNotNull || filter.isNotNull || sorting.isNotNull) {
          var regExp = RegExp(searchText ?? '', caseSensitive: false);
          var filterRegExp = RegExp(filter ?? '', caseSensitive: false);
          var sortingRegExp = RegExp(sorting ?? '', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matchesRegExp(
                    'documentIDNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'documentType',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'documentType',
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
        final recordSnapshots = await _businessDocument.find(
          await _db,
          finder: finder,
        );
        // Making a List<NewBusinessDocumentEntity> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = NewBusinessDocumentEntity.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            documentID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<NewBusinessDocumentEntity>>> saveAll(
      {required List<NewBusinessDocumentEntity> entities, bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<NewBusinessDocumentEntity>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <NewBusinessDocumentEntity>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var documentIDs = convertOrderToMapObject.map((map) => map['documentID'] as int).toList();
          var map = await getDocumentByIds(db, documentIDs);
          // Watch for deleted item
          var keysToDelete = (await _businessDocument.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['documentID'] as int];
            if (snapshot != null) {
              // The record current key
              var key = snapshot.key;
              // Remove from deletion list
              keysToDelete.remove(key);
              // Don't update if no change
              if (const DeepCollectionEquality().equals(snapshot.value, order)) {
                // no changes
                continue;
              } else {
                // Update product
                await _businessDocument.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _businessDocument.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _businessDocument.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <NewBusinessDocumentEntity>[];
        }
      });
    });
    return result;
  }
}
