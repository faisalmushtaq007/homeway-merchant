part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

abstract interface class RateAndReviewDataSource {
  Future<ApiResultState<RateAndReviewEntity>> saveRateAndReview({
    required RateAndReviewEntity rateAndReviewEntity,
  });

  Future<ApiResultState<RateAndReviewEntity>> editRateAndReview({
    required RateAndReviewEntity rateAndReviewEntity,
    required int ratingID,
  });

  Future<ApiResultState<bool>> deleteRateAndReview({
    required int ratingID,
    RateAndReviewEntity? rateAndReviewEntity,
  });

  Future<ApiResultState<bool>> deleteAllRateAndReview();

  Future<ApiResultState<RateAndReviewEntity>> getRateAndReview({
    required int ratingID,
    RateAndReviewEntity? rateAndReviewEntity,
  });

  Future<ApiResultState<List<RateAndReviewEntity>>> getAllRateAndReview();
  Future<ApiResultState<List<RateAndReviewEntity>>> saveAllRateAndReview({
    required List<RateAndReviewEntity> rateAndReviewEntities,
    bool hasUpdateAll = false,
  });
}
