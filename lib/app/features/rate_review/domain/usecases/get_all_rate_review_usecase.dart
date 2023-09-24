part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class GetAllRateAndReviewUseCase
    extends UseCase<DataSourceState<List<RateAndReviewEntity>>> {
  GetAllRateAndReviewUseCase({
    required this.userRateAndReviewRepository,
  });
  final RateAndReviewRepository userRateAndReviewRepository;
  @override
  Future<DataSourceState<List<RateAndReviewEntity>>> call() async {
    return userRateAndReviewRepository.getAllRateAndReview();
  }
}
