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
            .toList();
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

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getPaymentBankEntityByIds(DatabaseClient db, List<int> ids) async {
    var snapshots = await _paymentBank.find(db, finder: Finder(filter: Filter.or(ids.map((e) => Filter.equals('paymentBankID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{for (var snapshot in snapshots) snapshot.value['paymentBankID']!.toString(): snapshot};
  }

  @override
  Future<Either<RepositoryBaseFailure, List<PaymentBankEntity>>> getAllWithPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    final result = await tryCatch<List<PaymentBankEntity>>(() async {
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
                    'bankName',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'accountNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'ibanNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'bankHolderName',
                    regExp,
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
                    'bankName',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'accountNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'ibanNumber',
                    regExp,
                    anyInList: true,
                  ),
                  Filter.matchesRegExp(
                    'bankHolderName',
                    regExp,
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
        final recordSnapshots = await _paymentBank.find(
          await _db,
          finder: finder,
        );
        // Making a List<PaymentBankEntity> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = PaymentBankEntity.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            paymentBankID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<PaymentBankEntity>>> saveAll({
    required List<PaymentBankEntity> entities,
    bool hasUpdateAll = false,
  }) async {
    final result = await tryCatch<List<PaymentBankEntity>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <PaymentBankEntity>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var paymentBankIDs = convertOrderToMapObject.map((map) => map['paymentBankID'] as int).toList();
          var map = await getPaymentBankEntityByIds(db, paymentBankIDs);
          // Watch for deleted item
          var keysToDelete = (await _paymentBank.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['paymentBankID'] as int];
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
                await _paymentBank.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _paymentBank.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _paymentBank.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <PaymentBankEntity>[];
        }
      });
    });
    return result;
  }
}
