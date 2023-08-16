part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

abstract class BaseRateAndReviewLocalDbRepository<T extends RateAndReviewEntity>
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
