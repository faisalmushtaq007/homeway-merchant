part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class EditAllRateAndReviewUseCase extends UseCaseIO<List<RateAndReviewEntity>,
    DataSourceState<List<RateAndReviewEntity>>> {
  EditAllRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;
  @override
  Future<DataSourceState<List<RateAndReviewEntity>>> call(
      List<RateAndReviewEntity> input) async {
    return userRateAndReviewRepository.saveAllRateAndReview(
      rateAndReviewEntities: input,
      hasUpdateAll: true,
    );
  }
}
