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
        SaveAll<T> {}
