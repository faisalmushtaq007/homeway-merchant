part of 'package:homemakers_merchant/app/features/menu/index.dart';

abstract interface class BaseMenuLocalDbRepository<T extends MenuEntity>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T>,
        AddOrUpdateUser<T>,
        SaveAll<T>,
        GetAll<T>,
        GetAllWithPagination<T> {}

abstract interface class BaseAddonsLocalDbRepository<T extends Addons>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T>,
        AddOrUpdateUser<T>,
        SaveAll<T>,
        GetAll<T>,
        GetAllWithPagination<T> {}

abstract interface class BaseCategoryLocalDbRepository<T extends Category>
    implements
        ReadOnlyRepository<T>,
        WriteOnlyRepository<T>,
        DeleteAll<T>,
        DeleteById<T>,
        DeleteByIdAndEntity<T>,
        GetByIdAndEntity<T>,
        UpdateByIdAndEntity<T>,
        AddOrUpdateUser<T>,
        SaveAll<T>,
        GetAll<T>,
        GetAllWithPagination<T> {}
