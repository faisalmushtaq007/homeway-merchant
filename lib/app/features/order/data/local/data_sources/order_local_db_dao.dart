part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderLocalDbRepository<T extends OrderEntity> implements BaseOrderLocalDbRepository<OrderEntity> {
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _order => AppDatabase.instance.notification;

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

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> saveAll({required List<OrderEntity> entities, bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<OrderEntity>>(() async {
      final db = await _db;
      await db.transaction((transaction) async {
        // Delete all
        await _order.delete(transaction);
        // Add all
        await _order.addAll(transaction, entities.map((e) => e.toJson()).toList());
      });
      final result = await getAll();
      return result.fold((l) {
        return <OrderEntity>[];
      }, (r) {
        return r.toList();
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
  }) async {
    // TODO: implement getAllOnProcessOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
  }) async {
    // TODO: implement getAllOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<OrderEntity>>> getAllRecentOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
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
