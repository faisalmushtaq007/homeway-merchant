part of 'package:homemakers_merchant/app/features/order/index.dart';

abstract class BaseOrderLocalDbRepository<T extends OrderEntity>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        AddOrUpdateUser<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T>,
        SaveAll<T>,
        GetAllOrder<T>,
        GetAllRecentOrder<T>,
        GetAllOnProcessOrder<T>,
        GetAllNewOrder<T>,
        GetAllCancelOrder<T>,
        GetAllDeliveryOrder<T>,
        GetAllScheduleOrder<T> {}

abstract class GetAllOrder<EntityType>
    extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAllOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}

abstract class GetAllRecentOrder<EntityType>
    extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAllRecentOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}

abstract class GetAllOnProcessOrder<EntityType>
    extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAllOnProcessOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.onProcess,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}

abstract class GetAllNewOrder<EntityType>
    extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAllNewOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.newOrder,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}

abstract class GetAllCancelOrder<EntityType>
    extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAllCancelOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.cancel,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}

abstract class GetAllDeliveryOrder<EntityType>
    extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAllDeliveryOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.deliver,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}

abstract class GetAllScheduleOrder<EntityType>
    extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAllScheduleOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.schedule,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}
