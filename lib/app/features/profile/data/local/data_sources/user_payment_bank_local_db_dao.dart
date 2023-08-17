part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UserPaymentBankLocalDbRepository<T extends PaymentBankEntity> implements BaseUserPaymentBankLocalDbRepository<PaymentBankEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;
  StoreRef<int, Map<String, dynamic>> get _paymentBank => AppDatabase.instance.paymentBank;
  @override
  Future<Either<RepositoryBaseFailure, PaymentBankEntity>> add(PaymentBankEntity entity) async {
    final result = await tryCatch<PaymentBankEntity>(() async {
      final int recordID = await _paymentBank.add(await _db, entity.toMap());
      //final PaymentBankEntity recordPaymentBankEntity = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(paymentBankID: recordID), UniqueId(recordID));
      final value = await _paymentBank.record(recordID).get(await _db);
      if (value != null) {
        final storedPaymentBankEntity = PaymentBankEntity.fromMap(value);
        final storeEntity = storedPaymentBankEntity.copyWith(paymentBankID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(paymentBankID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(PaymentBankEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.paymentBankID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _paymentBank.delete(
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
        await _paymentBank.delete(transaction);
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
      final value = await _paymentBank.record(uniqueId.value).get(await _db);
      if (value != null) {
        int counter = await _paymentBank.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, PaymentBankEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<PaymentBankEntity>>> getAll() async {
    final result = await tryCatch<List<PaymentBankEntity>>(() async {
      final snapshots = await _paymentBank.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <PaymentBankEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) => PaymentBankEntity.fromMap(snapshot.value).copyWith(
                paymentBankID: snapshot.key,
              ),
            )
            .toList(growable: false);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, PaymentBankEntity?>> getById(UniqueId id) async {
    final result = await tryCatch<PaymentBankEntity?>(() async {
      final value = await _paymentBank.record(id.value).get(await _db);
      if (value != null) {
        return PaymentBankEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, PaymentBankEntity>> getByIdAndEntity(UniqueId uniqueId, PaymentBankEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, PaymentBankEntity>> update(PaymentBankEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<PaymentBankEntity>(() async {
      final int key = uniqueId.value;
      final value = await _paymentBank.record(key).get(await _db);
      if (value != null) {
        final result = await _paymentBank.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return PaymentBankEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, PaymentBankEntity>> updateByIdAndEntity(UniqueId uniqueId, PaymentBankEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, PaymentBankEntity>> upsert(
      {UniqueId? id, String? token, required PaymentBankEntity entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<PaymentBankEntity>(() async {
      final int key = entity.paymentBankID;
      final value = await _paymentBank.record(key).get(await _db);
      final result = await _paymentBank.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return PaymentBankEntity.fromMap(result);
    });
    return result;
  }
}
