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
          var regExpByID = RegExp(byID ?? '', caseSensitive: false);
          //var regExpByToken = RegExp(byToken ?? '', caseSensitive: false);
          //var regExpByPhoneNumberWithoutDialCode = RegExp(entity?.phoneNumberWithoutDialCode ?? '', caseSensitive: false);
          //var regExpByPhoneNumber = RegExp(entity?.phoneNumber ?? '', caseSensitive: false);
          final record = await _user.findFirst(
            txn,
            finder: Finder(
              filter: Filter.or([
                Filter.equals('hasCurrentUser', true),
                Filter.equals(
                  'phoneNumberWithoutDialCode',
                  entity?.phoneNumberWithoutDialCode ?? '',
                ),
                Filter.equals(
                  'phoneNumber',
                  entity?.phoneNumber ?? '',
                ),
                Filter.equals(
                  'access_token',
                  byToken,
                ),
                Filter.equals(
                  'access_token',
                  entity?.access_token ?? '',
                ),
                Filter.equals(
                  'uid',
                  byID,
                ),
                Filter.equals(
                  'uid',
                  entity?.uid ?? entity?.userID,
                ),
              ]),
            ),
          );
          if (record != null) {
            appLog.d('Current user:- ${record.value}');
            return AppUserEntity.fromMap(record.value);
          }else{
            final result=await getAll();
            if(result.isRight()){
              appLog.d(result.right);
            }else{
              appLog.d(result.left.toString());
            }
          }
          return null;
        },
      );
      return result;
    });
    return result;
  }
}
