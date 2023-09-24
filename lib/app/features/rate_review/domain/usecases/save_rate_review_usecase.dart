part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class SaveRateAndReviewUseCase extends UseCaseIO<RateAndReviewEntity,
    DataSourceState<RateAndReviewEntity>> {
  SaveRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;
  @override
  Future<DataSourceState<RateAndReviewEntity>> call(
      RateAndReviewEntity input) async {
    return userRateAndReviewRepository.saveRateAndReview(
        rateAndReviewEntity: input);
  }
}
