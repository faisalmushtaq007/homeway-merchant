part of 'package:homemakers_merchant/app/features/notification/index.dart';

abstract class BaseNotificationLocalDbRepository<T extends NotificationEntity>
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
