import 'package:equatable/equatable.dart';

class RatingAndReviewEntity extends Equatable {
  const RatingAndReviewEntity({
    this.rating = 0.0,
    this.numberOfReviews = 0,
    this.customerReview = '',
    this.ratingId = '',
  });

  factory RatingAndReviewEntity.fromMap(Map<String, dynamic> map) {
    return RatingAndReviewEntity(
      rating: map['rating'] as double,
      numberOfReviews: map['numberOfReviews'] as int,
      customerReview: map['customerReview'] as String,
      ratingId: map['ratingId'] as String,
    );
  }
  final double rating;
  final int numberOfReviews;
  final String customerReview;
  final String ratingId;

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
  List<Object?> get props => [rating, numberOfReviews, customerReview];
}
