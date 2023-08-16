part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class GetRateAndReviewUseCase extends UseCaseByID<RateAndReviewEntity, int, DataSourceState<RateAndReviewEntity>> {
  GetRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;
  @override
  Future<DataSourceState<RateAndReviewEntity>> call({required int id, RateAndReviewEntity? input}) async {
    return userRateAndReviewRepository.getRateAndReview(rateAndReviewEntity: input, ratingID: id);
  }
}
