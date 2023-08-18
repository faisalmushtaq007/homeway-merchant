part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class RateAndReviewEntity {
  RateAndReviewEntity({
    this.flag = -1,
    this.subtitle = '',
    this.ratingID = -1,
    this.title = '',
    this.clickAction = '',
    this.type = '',
    this.priority = -1,
    required this.body,
    this.timestamp = -1,
    this.userName = '',
    this.userImage = '',
    this.userID = -1,
  });

  factory RateAndReviewEntity.fromJson(Map<String, dynamic> json) => RateAndReviewEntity(
        flag: (json['flag'] != null) ? json['flag'] : 0,
        subtitle: json['subtitle'],
        ratingID: json['ratingID'],
        title: json['title'],
        clickAction: json['click_action'],
        type: json['type'],
        priority: json['priority'],
        body: json['body'] != null ? RateAndReviewBody.fromJson(json['body']) : RateAndReviewBody(),
        timestamp: json['timestamp'],
        userImage: json['user_image'],
        userID: json['userID'],
        userName: json['user_name'],
      );

  final int flag;
  final String subtitle;
  final int ratingID;
  final String title;
  final String clickAction;
  final String type;
  final int priority;
  RateAndReviewBody body;
  int timestamp;
  final String userName;
  final int userID;
  final String userImage;

  Map<String, dynamic> toJson() => {
        'flag': flag,
        'subtitle': subtitle,
        'ratingID': ratingID,
        'title': title,
        'click_action': clickAction,
        'type': type,
        'priority': priority,
        'body': (body.isNotNull) ? body.toJson() : RateAndReviewBody().toJson(),
        'timestamp': timestamp,
        'user_image': userImage,
        'userID': userID,
        'user_name': userName,
      };

  RateAndReviewEntity copyWith({
    int? flag,
    String? subtitle,
    int? ratingID,
    String? title,
    String? clickAction,
    String? type,
    int? priority,
    RateAndReviewBody? body,
    int? timestamp,
    String? userName,
    int? userId,
    String? userImage,
  }) {
    return RateAndReviewEntity(
      flag: flag ?? this.flag,
      subtitle: subtitle ?? this.subtitle,
      ratingID: ratingID ?? this.ratingID,
      title: title ?? this.title,
      clickAction: clickAction ?? this.clickAction,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      userName: userName ?? this.userName,
      userID: userId ?? this.userID,
      userImage: userImage ?? this.userImage,
    );
  }
}

class RateAndReviewBody {
  RateAndReviewBody({
    this.imageUrl = '',
    this.iconUrl = '',
    this.category = '',
    this.message = '',
    this.rating = 0.0,
    this.reviewDescription = '',
    this.ratingOrderDetails,
  });

  factory RateAndReviewBody.fromJson(Map<String, dynamic> json) => RateAndReviewBody(
      imageUrl: json['imageUrl'],
      iconUrl: json['iconUrl'],
      category: json['category'],
      message: json['message'],
      rating: json['rating'],
      reviewDescription: json['reviewDescription'],
      ratingOrderDetails: json['order_details'] != null ? RatingOrderDetails.fromJson(json['order_details']) : RatingOrderDetails());

  final String imageUrl;
  final String iconUrl;
  final String category;
  final String message;
  final double rating;
  final String reviewDescription;
  final RatingOrderDetails? ratingOrderDetails;

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'iconUrl': iconUrl,
        'category': category,
        'message': message,
        'reviewDescription': reviewDescription,
        'rating': rating,
        'order_details': (ratingOrderDetails.isNotNull) ? ratingOrderDetails?.toJson() : RatingOrderDetails().toJson(),
      };

  RateAndReviewBody copyWith({
    String? imageUrl,
    String? iconUrl,
    String? category,
    String? message,
    String? reviewDescription,
    double? rating,
  }) {
    return RateAndReviewBody(
      imageUrl: imageUrl ?? this.imageUrl,
      iconUrl: iconUrl ?? this.iconUrl,
      category: category ?? this.category,
      message: message ?? this.message,
      reviewDescription: reviewDescription ?? this.reviewDescription,
      rating: rating ?? this.rating,
    );
  }
}

class RatingOrderDetails {
  RatingOrderDetails({
    this.orderID = -1,
    this.menuName = '',
    this.orderDate = -1,
  });

  factory RatingOrderDetails.fromJson(Map<String, dynamic> json) => RatingOrderDetails(
        orderID: json['orderID'],
        menuName: json['menu_name'],
        orderDate: json['order_date'],
      );
  final int orderID;
  final String menuName;
  final int orderDate;

  RatingOrderDetails copyWith({
    int? orderID,
    String? menuName,
    int? orderDate,
  }) =>
      RatingOrderDetails(
        orderID: orderID ?? this.orderID,
        menuName: menuName ?? this.menuName,
        orderDate: orderDate ?? this.orderDate,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'orderID': orderID,
        'menu_name': menuName,
        'order_date': orderDate,
      };
}
