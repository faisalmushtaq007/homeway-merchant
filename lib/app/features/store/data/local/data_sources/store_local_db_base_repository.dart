import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';

import 'package:homemakers_merchant/core/local/database/base/repository.dart';

abstract class BaseStoreLocalDbRepository<T extends StoreEntity> implements ReadOnlyRepository<T>, WriteOnlyRepository<T>, DeleteAll<T>, DeleteById<T> {}
