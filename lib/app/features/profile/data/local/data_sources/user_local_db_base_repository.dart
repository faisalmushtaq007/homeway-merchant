part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract class BaseUserLocalDbRepository<T extends AppUserEntity>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        AddOrUpdateUser<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T>,
        GetCurrentUser<T>,
        SaveAll<T>,
        GetAll<T>,
        GetAllWithPagination<T> {}

abstract class BaseUserBusinessProfileEntityLocalDbRepository<
        T extends BusinessProfileEntity>
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
        GetAll<T>,
        GetAllWithPagination<T> {}

abstract class BaseUserBusinessDocumentEntityLocalDbRepository<
        T extends NewBusinessDocumentEntity>
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
        GetAll<T>,
        GetAllWithPagination<T> {}

abstract class BaseUserPaymentBankLocalDbRepository<T extends PaymentBankEntity>
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
        GetAll<T>,
        GetAllWithPagination<T> {}
