part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class DeleteRateAndReviewUseCase
    extends UseCaseByID<RateAndReviewEntity, int, DataSourceState<bool>> {
  DeleteRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;
  @override
  Future<DataSourceState<bool>> call(
      {required int id, RateAndReviewEntity? input}) async {
    return userRateAndReviewRepository.deleteRateAndReview(
        rateAndReviewEntity: input, ratingID: id);
  }
}
