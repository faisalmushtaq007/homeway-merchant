part of 'package:homemakers_merchant/app/features/menu/index.dart';

abstract interface class BaseMenuLocalDbRepository<T extends MenuEntity>
    implements ReadOnlyRepository<T>, WriteOnlyRepository<T>, DeleteAll<T>, DeleteById<T> {}

abstract interface class BaseAddonsLocalDbRepository<T extends Addons> implements ReadOnlyRepository<T>, WriteOnlyRepository<T>, DeleteAll<T>, DeleteById<T> {}
