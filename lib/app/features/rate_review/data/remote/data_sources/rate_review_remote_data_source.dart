part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class RateAndReviewRemoteDataSource implements RateAndReviewDataSource {
  final client = serviceLocator<IRestApiManager>();
  @override
  Future<ApiResultState<bool>> deleteAllRateAndReview() {
    // TODO: implement deleteAllRateAndReview
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteRateAndReview(
      {required int ratingID, RateAndReviewEntity? rateAndReviewEntity}) {
    // TODO: implement deleteRateAndReview
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<RateAndReviewEntity>> editRateAndReview(
      {required RateAndReviewEntity rateAndReviewEntity,
      required int ratingID}) {
    // TODO: implement editRateAndReview
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<RateAndReviewEntity>>> getAllRateAndReview() {
    // TODO: implement getAllRateAndReview
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<RateAndReviewEntity>> getRateAndReview(
      {required int ratingID, RateAndReviewEntity? rateAndReviewEntity}) {
    // TODO: implement getRateAndReview
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<RateAndReviewEntity>>> saveAllRateAndReview(
      {required List<RateAndReviewEntity> rateAndReviewEntities,
      bool hasUpdateAll = false}) {
    // TODO: implement saveAllRateAndReview
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<RateAndReviewEntity>> saveRateAndReview(
      {required RateAndReviewEntity rateAndReviewEntity}) {
    // TODO: implement saveRateAndReview
    throw UnimplementedError();
  }
}
