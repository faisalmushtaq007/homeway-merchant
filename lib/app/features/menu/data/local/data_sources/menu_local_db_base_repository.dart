import 'package:homemakers_merchant/app/features/menu/index.dart';

import 'package:homemakers_merchant/core/local/database/base/repository.dart';

abstract class BaseMenuLocalDbRepository<T extends MenuEntity> implements ReadOnlyRepository<T>, WriteOnlyRepository<T>, DeleteAll<T>, DeleteById<T> {}

abstract class BaseAddonsLocalDbRepository<T extends Addons> implements ReadOnlyRepository<T>, WriteOnlyRepository<T>, DeleteAll<T>, DeleteById<T> {}
