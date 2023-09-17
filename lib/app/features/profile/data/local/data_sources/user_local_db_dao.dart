part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UserLocalDbRepository<User extends AppUserEntity> implements BaseUserLocalDbRepository<AppUserEntity> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _user => AppDatabase.instance.user;

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> add(AppUserEntity entity) async {
    final result = await tryCatch<AppUserEntity>(() async {
      final int recordID = await _user.add(await _db, entity.toMap());
      //final AppUserEntity recordAppUserEntity = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(userID: recordID), UniqueId(recordID));
      final value = await _user.record(recordID).get(await _db);
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
      await _user.delete(
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
        await _user.delete(transaction);
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
      final value = await _user.record(uniqueId.value).get(await _db);
      if (value != null) {
        await _user.delete(
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
      final snapshots = await _user.find(await _db);
      return snapshots
          .map((snapshot) => AppUserEntity.fromMap(snapshot.value).copyWith(
                userID: snapshot.key,
              ))
          .toList();
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity?>> getById(UniqueId id) async {
    final result = await tryCatch<AppUserEntity?>(() async {
      final value = await _user.record(id.value).get(await _db);
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
      final int key = uniqueId.value;
      final value = await _user.record(key).get(await _db);
      if (value != null) {
        final result = await _user.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return AppUserEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, AppUserEntity>> upsert(
      {UniqueId? id, String? token, required AppUserEntity entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<AppUserEntity>(() async {
      final int key = entity.userID;
      final value = await _user.record(key).get(await _db);
      final result = await _user.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return AppUserEntity.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, AppUserEntity entity) {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> getByIdAndEntity(UniqueId uniqueId, AppUserEntity entity) {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> updateByIdAndEntity(UniqueId uniqueId, AppUserEntity entity) {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity?>> getCurrentUser({
    AppUserEntity? entity,
    Map<String, dynamic> metaInfo = const {},
    String byID = '',
    String byToken = '',
  }) async {
    final result = await tryCatch<AppUserEntity>(() async {
      final db = await _db;
      final result = await db.transaction<AppUserEntity?>(
        (txn) async {
          //var regExpByID = RegExp(byID ?? '', caseSensitive: false);
          //var regExpByToken = RegExp(byToken ?? '', caseSensitive: false);
          //var regExpByPhoneNumberWithoutDialCode = RegExp(entity?.phoneNumberWithoutDialCode ?? '', caseSensitive: false);
          //var regExpByPhoneNumber = RegExp(entity?.phoneNumber ?? '', caseSensitive: false);
          final record = await _user.findFirst(
            txn,
            finder: Finder(
              filter: Filter.or([
                Filter.equals('hasCurrentUser', true,anyInList: true,),
                Filter.equals(
                  'phoneNumberWithoutDialCode',
                  entity?.phoneNumberWithoutDialCode ?? '',
                  anyInList: true,
                ),
                Filter.equals(
                  'phoneNumber',
                  entity?.phoneNumber ?? '',anyInList: true,
                ),
                Filter.equals(
                  'access_token',
                  byToken,anyInList: true,
                ),
                Filter.equals(
                  'access_token',
                  entity?.access_token ?? '',anyInList: true,
                ),
                Filter.equals(
                  'uid',
                  byID,anyInList: true,
                ),
                Filter.equals(
                  'uid',
                  entity?.uid ?? entity?.userID,anyInList: true,
                ),
                Filter.equals(
                  'userID',
                  byID,anyInList: true,
                ),
                Filter.equals(
                  'userID',
                  entity?.uid ?? entity?.userID,anyInList: true,
                ),
              ]),
            ),
          );
          if (record != null) {
            appLog.d('Current user:- ${record.value}');
            return AppUserEntity.fromMap(record.value);
          }/*else{
            final result=await getAll();
            if(result.isRight()){
              appLog.d(result.right);
            }else{
              appLog.d(result.left.toString());
            }
          }*/
          return null;
        },
      );
      return result;
    });
    return result;
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getUserProfileEntityByIds(DatabaseClient db, List<int> ids) async {
    var snapshots = await _user.find(db, finder: Finder(filter: Filter.or(ids.map((e) => Filter.equals('userID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{for (var snapshot in snapshots) snapshot.value['userID']!.toString(): snapshot};
  }
  
  @override
  Future<Either<RepositoryBaseFailure, List<AppUserEntity>>> getAllWithPagination({int pageKey = 0, int pageSize = 10, String? searchText, Map<String, dynamic> extras = const <String, dynamic>{}, String? filter, String? sorting, Timestamp? startTimeStamp, Timestamp? endTimeStamp,})async {
    final result = await tryCatch<List<AppUserEntity>>(() async {
      final db = await _db;
      return await db.transaction((transaction) async {
        AppUserEntity entity=AppUserEntity.fromMap(extras);
        // Finder object can also sort data.
        Finder finder = Finder(
          limit: pageSize,
          offset: pageKey,
        );
        // If
        if (searchText.isNotNull || filter.isNotNull) {
          var regExp = searchText;//RegExp(searchText ?? '', caseSensitive: false);
          var filterRegExp = filter;//RegExp(filter ?? '', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.equals('hasCurrentUser', true,anyInList: true,),
                  Filter.equals(
                    'phoneNumberWithoutDialCode',
                    entity.phoneNumberWithoutDialCode ?? '',
                    anyInList: true,
                  ),
                  Filter.equals(
                    'phoneNumber',
                    entity.phoneNumber ?? '',anyInList: true,
                  ),
                  Filter.equals(
                    'access_token',
                    entity.token,anyInList: true,
                  ),
                  Filter.equals(
                    'access_token',
                    entity.access_token ?? '',anyInList: true,
                  ),
                  Filter.equals(
                    'uid',
                    entity.uid,anyInList: true,
                  ),
                  Filter.equals(
                    'uid',
                    entity.uid ?? entity.userID,anyInList: true,
                  ),
                  Filter.equals(
                    'userID',
                    entity.userID,anyInList: true,
                  ),
                  Filter.equals(
                    'userID',
                    entity.uid ?? entity.userID,anyInList: true,
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
        final recordSnapshots = await _user.find(
          await _db,
          finder: finder,
        );
        // Making a List<BusinessProfileEntity> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = AppUserEntity.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            userID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<AppUserEntity>>> saveAll({required List<AppUserEntity> entities, bool hasUpdateAll = false,}) async {
    final result = await tryCatch<List<AppUserEntity>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <AppUserEntity>[];
      }, (r) async {
        //final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        //final bool equalityStatus = unOrdDeepEq(allOrderList.toSet().toList(), newList.toSet().toList());
        await db.transaction((transaction) async {
          var userProfileIDs = convertOrderToMapObject.map((map) => map['userID'] as int).toList();
          var map = await getUserProfileEntityByIds(db, userProfileIDs);
          // Watch for deleted item
          var keysToDelete = (await _user.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['userID'] as int];
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
                await _user.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _user.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _user.records(keysToDelete).delete(transaction);
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
