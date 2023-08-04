part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreOwnDeliveryPartnersLocalDbRepository<Driver extends StoreOwnDeliveryPartnersInfo>
    implements BaseStoreOwnDriverLocalDbRepository<StoreOwnDeliveryPartnersInfo> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _store => AppDatabase.instance.store;

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo>> add(StoreOwnDeliveryPartnersInfo entity) async {
    final result = await tryCatch<StoreOwnDeliveryPartnersInfo>(() async {
      final int recordID = await _store.add(await _db, entity.toMap());
      //final StoreOwnDeliveryPartnersInfo recordStoreOwnDeliveryPartnersInfo = entity.copyWith(driverID: recordID.toString());
      final value = await _store.record(recordID).get(await _db);
      if (value != null) {
        return StoreOwnDeliveryPartnersInfo.fromMap(value).copyWith(driverID: recordID);
      } else {
        return entity.copyWith(driverID: recordID);
      }
    });
    return result;
    /*final int recordID = await _store.add(await _db, entity.toMap());
    //final StoreOwnDeliveryPartnersInfo recordStoreOwnDeliveryPartnersInfo = entity.copyWith(driverID: recordID.toString());
    final value = await _store.record(recordID).get(await _db);
    if (value != null) {
      debugPrint('Save value ${value}');
      return Right(StoreOwnDeliveryPartnersInfo.fromMap(value).copyWith(driverID: recordID));
    } else {
      return Right(entity.copyWith(driverID: recordID));
    }*/
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(StoreOwnDeliveryPartnersInfo entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.driverID;
      final finder = Finder(filter: Filter.byKey(key));
      await _store.delete(
        await _db,
        finder: finder,
      );
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll(StoreOwnDeliveryPartnersInfo entity) async {
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
  Future<Either<RepositoryBaseFailure, List<StoreOwnDeliveryPartnersInfo>>> getAll() async {
    final result = await tryCatch<List<StoreOwnDeliveryPartnersInfo>>(() async {
      final snapshots = await _store.find(await _db);
      return snapshots
          .map((snapshot) => StoreOwnDeliveryPartnersInfo.fromMap(snapshot.value).copyWith(
                driverID: snapshot.key,
              ))
          .toList(growable: false);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo?>> getById(UniqueId id) async {
    final result = await tryCatch<StoreOwnDeliveryPartnersInfo?>(() async {
      final value = await _store.record(id.value).get(await _db);
      if (value != null) {
        return StoreOwnDeliveryPartnersInfo.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, StoreOwnDeliveryPartnersInfo>> update(StoreOwnDeliveryPartnersInfo entity, UniqueId uniqueId) async {
    final result = await tryCatch<StoreOwnDeliveryPartnersInfo>(() async {
      final int key = entity.driverID;
      final value = await _store.record(key).get(await _db);
      final result = await _store.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return StoreOwnDeliveryPartnersInfo.fromMap(result);
    });
    return result;
  }
}
