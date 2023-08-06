part of 'package:homemakers_merchant/app/features/store/index.dart';

abstract interface class BaseStoreLocalDbRepository<T extends StoreEntity>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T> {}

abstract interface class BaseStoreOwnDriverLocalDbRepository<T extends StoreOwnDeliveryPartnersInfo>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T> {}
