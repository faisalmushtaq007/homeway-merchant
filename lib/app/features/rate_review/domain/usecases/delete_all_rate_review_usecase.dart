part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class DeleteAllRateAndReviewUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    return userRateAndReviewRepository.deleteAllRateAndReview();
  }
}
