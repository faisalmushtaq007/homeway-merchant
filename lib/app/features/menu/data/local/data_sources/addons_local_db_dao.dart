part of 'package:homemakers_merchant/app/features/menu/index.dart';

class AddonsLocalDbRepository<Extras extends Addons> implements BaseAddonsLocalDbRepository<Addons> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  @override
  Future<Either<RepositoryBaseFailure, Addons>> add(Addons entity) async {
    final result = await tryCatch<Addons>(() async {
      final int recordID = await _store.add(await _db, entity.toMap());
      //final Addons recordAddons = entity.copyWith(storeID: recordID.toString());
      final value = await _store.record(recordID).get(await _db);
      if (value != null) {
        return Addons.fromMap(value).copyWith(addonsID: recordID);
      } else {
        return entity.copyWith(addonsID: recordID);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(Addons entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.addonsID;
      final finder = Finder(filter: Filter.byKey(key));
      await _store.delete(
        await _db,
        finder: finder,
      );
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll(Addons entity) async {
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
  Future<Either<RepositoryBaseFailure, List<Addons>>> getAll() async {
    final result = await tryCatch<List<Addons>>(() async {
      final snapshots = await _store.find(await _db);
      return snapshots
          .map((snapshot) => Addons.fromMap(snapshot.value).copyWith(
                addonsID: snapshot.key,
              ))
          .toList(growable: false);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons?>> getById(UniqueId id) async {
    final result = await tryCatch<Addons?>(() async {
      final value = await _store.record(id.value).get(await _db);
      if (value != null) {
        return Addons.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, Addons>> update(Addons entity, UniqueId uniqueId) async {
    final result = await tryCatch<Addons>(() async {
      final int key = entity.addonsID;
      final value = await _store.record(key).get(await _db);
      final result = await _store.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return Addons.fromMap(result);
    });
    return result;
  }
}
