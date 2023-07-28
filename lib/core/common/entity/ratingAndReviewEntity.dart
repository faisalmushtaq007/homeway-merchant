import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

class RatingAndReviewEntity with AppEquatable {
  RatingAndReviewEntity({
    required this.rating,
    required this.numberOfReviews,
    required this.customerReview,
    required this.ratingId,
  });

  factory RatingAndReviewEntity.fromMap(Map<String, dynamic> map) {
    return RatingAndReviewEntity(
      rating: map['rating'] as double,
      numberOfReviews: map['numberOfReviews'] as int,
      customerReview: map['customerReview'] as String,
      ratingId: map['ratingId'] as String,
    );
  }
  double rating;
  int numberOfReviews;
  String customerReview;
  String ratingId;

  @override
  String toString() {
    return 'RatingAndReviewEntity{ rating: $rating, numberOfReviews: $numberOfReviews, customerReview: $customerReview, ratingId: $ratingId,}';
  }

  RatingAndReviewEntity copyWith({
    double? rating,
    int? numberOfReviews,
    String? customerReview,
    String? ratingId,
  }) {
    return RatingAndReviewEntity(
      rating: rating ?? this.rating,
      numberOfReviews: numberOfReviews ?? this.numberOfReviews,
      customerReview: customerReview ?? this.customerReview,
      ratingId: ratingId ?? this.ratingId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': this.rating,
      'numberOfReviews': this.numberOfReviews,
      'customerReview': this.customerReview,
      'ratingId': this.ratingId,
    };
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [rating, numberOfReviews, customerReview];
}
