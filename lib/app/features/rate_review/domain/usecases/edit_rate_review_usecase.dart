part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class EditRateAndReviewUseCase extends UseCaseByIDAndEntity<RateAndReviewEntity,
    int, DataSourceState<RateAndReviewEntity>> {
  EditRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;

  @override
  Future<DataSourceState<RateAndReviewEntity>> call(
      {required RateAndReviewEntity input, required int id}) async {
    return userRateAndReviewRepository.editRateAndReview(
        rateAndReviewEntity: input, ratingID: id);
  }
}
