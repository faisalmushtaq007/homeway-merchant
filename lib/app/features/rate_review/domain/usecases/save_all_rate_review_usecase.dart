part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class SaveAllRateAndReviewUseCase extends UseCaseIO<List<RateAndReviewEntity>, DataSourceState<List<RateAndReviewEntity>>> {
  SaveAllRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;
  @override
  Future<DataSourceState<List<RateAndReviewEntity>>> call(List<RateAndReviewEntity> input) async {
    return userRateAndReviewRepository.saveAllRateAndReview(
      rateAndReviewEntities: input,
      hasUpdateAll: false,
    );
  }
}
