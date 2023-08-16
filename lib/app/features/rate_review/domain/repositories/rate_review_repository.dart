part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

abstract interface class RateAndReviewRepository {
  Future<DataSourceState<RateAndReviewEntity>> saveRateAndReview({
    required RateAndReviewEntity rateAndReviewEntity,
  });

  Future<DataSourceState<RateAndReviewEntity>> editRateAndReview({
    required RateAndReviewEntity rateAndReviewEntity,
    required int ratingID,
  });

  Future<DataSourceState<bool>> deleteRateAndReview({
    required int ratingID,
    RateAndReviewEntity? rateAndReviewEntity,
  });

  Future<DataSourceState<bool>> deleteAllRateAndReview();

  Future<DataSourceState<RateAndReviewEntity>> getRateAndReview({
    required int ratingID,
    RateAndReviewEntity? rateAndReviewEntity,
  });

  Future<DataSourceState<List<RateAndReviewEntity>>> getAllRateAndReview();

  Future<DataSourceState<List<RateAndReviewEntity>>> saveAllRateAndReview({
    required List<RateAndReviewEntity> rateAndReviewEntities,
    bool hasUpdateAll = false,
  });
}
