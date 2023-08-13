part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressLocalDbRepository<T extends AddressModel> implements BaseAddressBankLocalDbRepository<AddressModel> {
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _address => AppDatabase.instance.address;
  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> add(AddressModel entity) async {
    final result = await tryCatch<AddressModel>(() async {
      final int recordID = await _address.add(await _db, entity.toMap());
      //final AddressModel recordAddressModel = entity.copyWith(storeID: recordID.toString());
      final value = await _address.record(recordID).get(await _db);
      if (value != null) {
        final storedAddressModel = AddressModel.fromJson(value);
        final storeEntity = storedAddressModel.copyWith(addressID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(addressID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(AddressModel entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.addressID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _address.delete(
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
        await _address.delete(transaction);
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
      final value = await _address.record(uniqueId.value).get(await _db);
      if (value != null) {
        int counter = await _address.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, AddressModel entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<AddressModel>>> getAll() async {
    final result = await tryCatch<List<AddressModel>>(() async {
      final snapshots = await _address.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <AddressModel>[];
      } else {
        return snapshots
            .map(
              (snapshot) => AddressModel.fromJson(snapshot.value).copyWith(
                addressID: snapshot.key,
              ),
            )
            .toList(growable: false);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel?>> getById(UniqueId id) async {
    final result = await tryCatch<AddressModel?>(() async {
      final value = await _address.record(id.value).get(await _db);
      if (value != null) {
        return AddressModel.fromJson(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> getByIdAndEntity(UniqueId uniqueId, AddressModel entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> update(AddressModel entity, UniqueId uniqueId) async {
    final result = await tryCatch<AddressModel>(() async {
      final int key = uniqueId.value;
      final value = await _address.record(key).get(await _db);
      if (value != null) {
        final result = await _address.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return AddressModel.fromJson(result);
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
  Future<Either<RepositoryBaseFailure, AddressModel>> updateByIdAndEntity(UniqueId uniqueId, AddressModel entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> upsert(
      {UniqueId? id, String? token, required AddressModel entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<AddressModel>(() async {
      final int key = entity.addressID;
      final value = await _address.record(key).get(await _db);
      final result = await _address.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return AddressModel.fromJson(result);
    });
    return result;
  }
}
