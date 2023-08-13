part of 'package:homemakers_merchant/app/features/address/index.dart';

abstract class BaseAddressBankLocalDbRepository<T extends AddressModel>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        AddOrUpdateUser<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T> {}
