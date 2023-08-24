part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderLocalDbRepository<T extends OrderEntity> implements BaseOrderLocalDbRepository<OrderEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _order => AppDatabase.instance.notification;

  Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

  @override
  Future<Either<RepositoryBaseFailure, OrderEntity>> add(OrderEntity entity) async {
    final result = await tryCatch<OrderEntity>(() async {
      final int recordID = await _order.add(await _db, entity.toMap());
      //final StoreEntity recordStoreEntity = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(orderID: recordID), UniqueId(recordID));
      final value = await _order.record(recordID).get(await _db);
      if (value != null) {
        final storedStoreEntity = OrderEntity.fromMap(value);
        final storeEntity = storedStoreEntity.copyWith(orderID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(orderID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(OrderEntity entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.orderID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _order.delete(
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
        await _order.delete(transaction);
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
      final value = await _order.record(uniqueId.value).get(await _db);
      if (value != null) {
        int counter = await _order.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, OrderEntity entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAll() async {
    final result = await tryCatch<List<OrderEntity>>(() async {
      final snapshots = await _order.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <OrderEntity>[];
      } else {
        return snapshots
            .map(
              (snapshot) => OrderEntity.fromMap(snapshot.value).copyWith(
                orderID: snapshot.key,
              ),
            )
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, OrderEntity?>> getById(UniqueId id) async {
    final result = await tryCatch<OrderEntity?>(() async {
      final value = await _order.record(id.value).get(await _db);
      if (value != null) {
        return OrderEntity.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, OrderEntity>> getByIdAndEntity(UniqueId uniqueId, OrderEntity entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, OrderEntity>> update(OrderEntity entity, UniqueId uniqueId) async {
    final result = await tryCatch<OrderEntity>(() async {
      final int key = uniqueId.value;
      final value = await _order.record(key).get(await _db);
      if (value != null) {
        final result = await _order.record(key).update(
              await _db,
              entity.toJson(),
            );
        if (result != null) {
          return OrderEntity.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, OrderEntity>> updateByIdAndEntity(UniqueId uniqueId, OrderEntity entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, OrderEntity>> upsert(
      {UniqueId? id, String? token, required OrderEntity entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<OrderEntity>(() async {
      final int key = entity.orderID;
      final value = await _order.record(key).get(await _db);
      final result = await _order.record(key).put(await _db, entity.toJson(), merge: (value != null) || false);
      return OrderEntity.fromMap(result);
    });
    return result;
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getProductsByIds(DatabaseClient db, List<int> ids) async {
    var snapshots = await _order.find(db, finder: Finder(filter: Filter.or(ids.map((e) => Filter.equals('orderID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{for (var snapshot in snapshots) snapshot.value['orderID']!.toString(): snapshot};
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> saveAll({required List<OrderEntity> entities, bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<OrderEntity>>(() async {
      final db = await _db;

      final result = await getAllOrder();
      return result.fold((l) {
        return <OrderEntity>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toJson()).toList();
        final bool equalityStatus = unOrdDeepEq(allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var orderIds = convertOrderToMapObject.map((map) => map['orderID'] as int).toList();
          var map = await getProductsByIds(db, orderIds);
          // Watch for deleted item
          var keysToDelete = (await _order.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['orderID'] as int];
            if (snapshot != null) {
              // The record current key
              var key = snapshot.key;
              // Remove from deletion list
              //keysToDelete.remove(key);
              // Don't update if no change
              if (const DeepCollectionEquality().equals(snapshot.value, order)) {
                // no changes
                continue;
              } else {
                // Update product
                await _order.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _order.add(transaction, order);
            }
          }
          // Delete the one not present any more
          //await _order.records(keysToDelete).delete(transaction);
        });

        final result = await getAllOrder();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <OrderEntity>[];
        }
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllCancelOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.cancel,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    // TODO: implement getAllCancelOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllDeliveryOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.deliver,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    // TODO: implement getAllDeliveryOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllNewOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.newOrder,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    // TODO: implement getAllNewOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllOnProcessOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.onProcess,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    // TODO: implement getAllOnProcessOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.all,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    final result = await tryCatch<List<OrderEntity>>(() async {
      final db = await _db;

      var orderTypeRegExp = RegExp(orderType.name, caseSensitive: false);
      return await db.transaction((transaction) async {
        // Finder object can also sort data.
        Finder finder = Finder(
          /* sortOrders: [
            SortOrder('orderDateTime'),
          ],*/
          limit: pageSize,
          offset: pageKey,
        );
        if (searchText.isNotNull || filter.isNotNull || sorting.isNotNull && (startTimeStamp.isNotNull || endTimeStamp.isNotNull)) {
          var regExp = RegExp(searchText ?? '', caseSensitive: false);
          var filterRegExp = RegExp(filter ?? '', caseSensitive: false);
          var sortingRegExp = RegExp(sorting ?? '', caseSensitive: false);
          finder = Finder(
            /* sortOrders: [
              SortOrder('orderDateTime'),
            ],*/
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matchesRegExp(
                    'store.storeName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'store.storeName.menu.@.menuName',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'store.storeName',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'store.storeName.menu.@.menuName',
                    filterRegExp,
                  ),
                ]),
                Filter.greaterThanOrEquals('orderDateTime', startTimeStamp),
                Filter.lessThan('orderDateTime', endTimeStamp),
              ],
            ),
          );
        } else if (searchText.isNotNull || filter.isNotNull || sorting.isNotNull) {
          var regExp = RegExp(searchText ?? '', caseSensitive: false);
          var filterRegExp = RegExp(filter ?? '', caseSensitive: false);
          var sortingRegExp = RegExp(sorting ?? '', caseSensitive: false);
          finder = Finder(
            /*sortOrders: [
              SortOrder('orderDateTime'),
            ],*/
            limit: pageSize,
            offset: pageKey,
            filter: Filter.or([
              Filter.matchesRegExp(
                'store.storeName',
                regExp,
              ),
              Filter.matchesRegExp(
                'store.storeName.menu.@.menuName',
                regExp,
              ),
              Filter.matchesRegExp(
                'store.storeName',
                filterRegExp,
              ),
              Filter.matchesRegExp(
                'store.storeName.menu.@.menuName',
                filterRegExp,
              ),
            ]),
          );
        } else {
          Finder finder = Finder(
            limit: pageSize,
            offset: pageKey,
          );
        }
        final recordSnapshots = await _order.find(
          await _db,
          finder: finder,
        );
        // Making a List<OrderEntity> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = OrderEntity.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            orderID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllRecentOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    // TODO: implement getAllRecentOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllScheduleOrder(
      {int pageKey = 1,
      int pageSize = 10,
      String? searchText,
      OrderType orderType = OrderType.schedule,
      String? filter,
      String? sorting,
      Timestamp? startTimeStamp,
      Timestamp? endTimeStamp}) async {
    // TODO: implement getAllScheduleOrder
    throw UnimplementedError();
  }
}
