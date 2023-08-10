import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';

import 'package:homemakers_merchant/core/local/database/base/repository.dart';

abstract class BaseUserLocalDbRepository<T extends AppUserEntity>
    implements ReadOnlyRepository<T>, WriteOnlyRepository<T>, DeleteAll<T>, DeleteById<T>, AddOrUpdateUser<T> {}
