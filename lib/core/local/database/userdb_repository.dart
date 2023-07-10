import 'dart:async';
import 'dart:developer';

import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

import './base/identifiable.dart';
import './base/repository.dart';
import './base/repository_failure.dart';
import 'package:homemakers_merchant/utils/functional/functional.dart';

// Should be a private class but kept public for testing purposes
class UserLocalDbRepository implements Repository<AppUserEntity> {
  bool isInitialized = false;
  late StoreRef<int, Map<String, dynamic>> store;
  late Database database;
  late RecordRef<int, Map<String, dynamic>> record;
  var factory = databaseFactoryWeb;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

  @override
  Future<Either<RepositoryBaseFailure, Database>> init() async {
    try {
      store = StoreRef<int, Map<String, dynamic>>.main();
      factory = databaseFactoryWeb;
      database = await factory.openDatabase('homewaymerchant');
      return Right(database);
      // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
      if (_dbOpenCompleter == null) {
        _dbOpenCompleter = Completer();
        // Calling _openDatabase will also complete the completer with database instance
        // Open the database
        //store = intMapStoreFactory.store('users');
        store = StoreRef<int, Map<String, dynamic>>.main();
        factory = databaseFactoryWeb;
        database = await factory.openDatabase('homewaymerchant');

        // Any code awaiting the Completer's future will now start executing
        isInitialized = true;
        _dbOpenCompleter?.complete(database);
      }
      // If the database is already opened, awaiting the future will happen instantly.
      // Otherwise, awaiting the returned future will take some time - until complete() is called
      // on the Completer in _openDatabase() below.
      await _dbOpenCompleter?.future;
      return Right(database);
    } catch (e) {
      isInitialized = false;
      _dbOpenCompleter?.completeError(e);
      return Left(RepositoryFailure.localdb(e.toString()));
    }
  }

  Future<void> close() async {
    // Close the database
    await store.delete(database);
    await database.close();
    currentUserToken = null;
    currentUserId = null;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(AppUserEntity entity) async {
    final result = await tryCatch<bool>(() async {
      var userModel = entity;
      var filter = Filter.byKey(userModel.id);
      var finder = Finder(filter: filter);
      final key = await store.delete(database, finder: finder);
      return true;
    });
    return result.fold(Left.new, (r) => Right(r));
  }

  @override
  Future<Either<RepositoryBaseFailure, List<AppUserEntity>>> getAll() async {
    try {
      List<AppUserEntity> userList = [];
      // Look for the last created record
      var finder = Finder(sortOrders: [SortOrder(Field.key, false)]);
      var record = await store.findFirst(database, finder: finder);
      if (record != null && record.value != null) {
        userList.clear();
        userList.add(AppUserEntity.fromMap(record.value));
        log('GetAll localdb success -> ${record.value}');
        return Right(userList.toList() as List<AppUserEntity>);
      } else {
        log('GetAll localdb -> empty');
        return Right(userList.toList() as List<AppUserEntity>);
      }
    } catch (e) {
      log('GetAll localdb error -> ${e.toString()}');
      return Left(RepositoryFailure.localdb('Collection is empty'));
    }
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> getById(UniqueId id) async {
    return Left(RepositoryFailure.localdb('Not found'));
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> update(
      AppUserEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<AppUserEntity>(() async {
      int key = uniqueId.value;
      var updatedModel =
          await store.record(key).update(database, entity.toMap());
      if (updatedModel != null) {
        return AppUserEntity.fromMap(updatedModel);
      } else {
        updatedModel =
            await store.record(key).put(database, entity.toMap(), merge: true);
        return AppUserEntity.fromMap(updatedModel);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> add(AppUserEntity entity) async {
    return await tryCatch<AppUserEntity>(() async {
      final int key = await store.add(database, entity.toMap());
      var copyUserModel = entity.copyWith(id: key, token: entity.token);
      currentUserId = key;
      currentUserToken = entity.token;
      authStatus = true;
      return copyUserModel as AppUserEntity;
    });
  }

  @override
  Future<Either<RepositoryBaseFailure, String>> getCurrentUserTokenByID(
      UniqueId id) async {
    return await tryCatch<String>(() async {
      final userJson = await store.record(id.value).get(database);
      if (userJson != null) {
        return AppUserEntity.fromMap(userJson).token;
      } else {
        return '';
      }
    });
  }

  @override
  String? currentUserToken;

  @override
  int? currentUserId;
  @override
  bool authStatus = false;

  Future<Either<RepositoryBaseFailure, AppUserEntity>> findUserByToken(String token) async {
    var finder = Finder(
      filter: Filter.equals('token', token),
    );
    var userInfo = await store.find(database, finder: finder);
    if (userInfo != null) {
      return Right(AppUserEntity.fromMap(userInfo.last.value) as AppUserEntity);
    } else {
      var record = await store.findFirst(database,
          finder: Finder(filter: Filter.equals('token', token)));
      if (record != null) {
        return Right(AppUserEntity.fromMap(record.value) as AppUserEntity);
      }
      return Left(RepositoryFailure.localdb('User Not found by token'));
    }
  }

  Future<Either<RepositoryBaseFailure, AppUserEntity>> findUserByUserID(UniqueId id) async {
    return await tryCatch<AppUserEntity>(() async {
      var result = await store.record(id.value).get(database);
      if (result != null) {
        return AppUserEntity.fromMap(result);
      } else {
        return AppUserEntity();
      }
    });
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll(AppUserEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final result = await store.delete(database);
      currentUserToken = null;
      currentUserId = null;
      authStatus = false;
      return true;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteById(
      UniqueId uniqueId) async {
    final result = await tryCatch<bool>(() async {
      final deletedKey = await store.record(uniqueId.value).delete(database);
      if (deletedKey != null) {
        currentUserToken = null;
        currentUserId = null;
        authStatus = false;
        return true;
      } else {
        var filter = Filter.byKey(uniqueId.value);
        var finder = Finder(filter: filter);
        final key = await store.delete(database, finder: finder);
        currentUserToken = null;
        currentUserId = null;
        return true;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, void>> clear() async {
    final result = await tryCatch<void>(() async {
      await store.delete(database);
      await database.close();
      currentUserToken = null;
      currentUserId = null;
      authStatus = false;
      return;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> findUserByTokenOrID(
      {UniqueId? id, String? token}) async {
    return await tryCatch<AppUserEntity>(() async {
      String referenceToken = '';
      int referenceUserId = -1;
      if (id != null && id.value != -1) {
        referenceUserId = id.value;
      }
      if (token != null && token.isNotEmpty) {
        referenceToken = token;
      }
      var finder = Finder(
        filter: Filter.or([
          Filter.equals('key', referenceUserId),
          Filter.equals('token', referenceToken),
        ]),
      );
      var userInfo = await store.find(database, finder: finder);
      if (userInfo != null) {
        return AppUserEntity.fromMap(userInfo.last.value) as AppUserEntity;
      } else {
        var record = await store.findFirst(database,
            finder: Finder(filter: Filter.equals('token', token)));
        if (record != null) {
          return AppUserEntity.fromMap(record.value) as AppUserEntity;
        }
        return AppUserEntity();
      }
    });
  }

  @override
  Future<Either<RepositoryBaseFailure, AppUserEntity>> addOrUpdateUser(
      {UniqueId? id,
      String? token,
      required AppUserEntity entity,
      bool checkIfUserLoggedIn = false}) async {
    // Check if the record exists before adding or updating it.
    var userId =
        currentUserId ??
            id?.value ??
            -1;
    var userToken = token ??
        currentUserToken ??
        '';
    var result =
        await findUserByTokenOrID(token: userToken, id: UniqueId(userId));
    return result.fold((l) async {
      await store.delete(database);
      final key = await store.add(database, entity.toMap());
      var copyUserModel = entity.copyWith(id: key);
      currentUserId = key;
      currentUserToken = entity.token;
      authStatus = true;

      return Right(copyUserModel as AppUserEntity);
    }, (r) async {
      if (!checkIfUserLoggedIn && r.token == null && r.token!.isEmpty || r.id != -1) {
        await store.delete(database);
        final key = await store.add(database, entity.toMap());
        var copyUserModel = entity.copyWith(id: key);
        currentUserId = key;
        currentUserToken = entity.token;
        authStatus = true;
        return Right(copyUserModel as AppUserEntity);
      } else {
        // Update existing
        var tempUserModel = entity as AppUserEntity;
        AppUserEntity cacheUserModel = AppUserEntity().copyWith(
          hasUserAuthenticated: true,
          token: tempUserModel.token,
          id: tempUserModel.id,
        );
        final returnUserModel = await store
            .record(tempUserModel.id ?? userId)
            .update(database, cacheUserModel.toMap());
        if (returnUserModel != null) {
          final updatedUserModel = AppUserEntity.fromMap(returnUserModel);
          updatedUserModel.copyWith(id: tempUserModel.id ?? userId);
          currentUserId = updatedUserModel.id;
          currentUserToken = entity.token;
          authStatus = true;
          return Right(updatedUserModel as AppUserEntity);
        } else {
          return Left(RepositoryFailure.localdb(
              'User info is neither add or update in local db'));
        }
      }
    });
  }
}

Future<Either<RepositoryBaseFailure, E>> tryCatch<E>(Function f) async {
  try {
    //final result = await f.call();
    return Right(await f.call());
  } catch (e, st) {
    return Left(RepositoryFailure.localdb(
      e.toString(),
      stacktrace: st,
    ));
  }
}
