part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract class BaseUserLocalDbRepository<T extends AppUserEntity>
    implements ReadOnlyRepository<T>, WriteOnlyRepository<T>, DeleteAll<T>, DeleteById<T>, AddOrUpdateUser<T> {}
