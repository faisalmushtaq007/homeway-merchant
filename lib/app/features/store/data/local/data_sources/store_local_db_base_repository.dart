part of 'package:homemakers_merchant/app/features/store/index.dart';

abstract interface class BaseStoreLocalDbRepository<T extends StoreEntity>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T>,
        AddOrUpdateUser<T> {}

abstract interface class BaseStoreOwnDriverLocalDbRepository<T extends StoreOwnDeliveryPartnersInfo>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T>,
        AddOrUpdateUser<T> {}

abstract interface class BaseStoreBindingWithUser<T extends StoreEntity, R extends AppUserEntity> implements Binding<T, R> {}
