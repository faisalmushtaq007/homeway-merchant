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
  });

  factory RateAndReviewEntity.fromJson(Map<String, dynamic> json) => RateAndReviewEntity(
        flag: json['flag'],
        subtitle: json['subtitle'],
        ratingID: json['ratingID'],
        title: json['title'],
        clickAction: json['click_action'],
        type: json['type'],
        priority: json['priority'],
        body: json['body'] != null ? RateAndReviewBody.fromJson(json['body']) : RateAndReviewBody(),
        timestamp: json['timestamp'],
      );

  int flag;
  String subtitle;
  int ratingID;
  String title;
  String clickAction;
  String type;
  int priority;
  RateAndReviewBody body;
  int timestamp;

  Map<String, dynamic> toJson() => {
        'flag': flag,
        'subtitle': subtitle,
        'ratingID': ratingID,
        'title': title,
        'click_action': clickAction,
        'type': type,
        'priority': priority,
        'body': body.toJson(),
        'timestamp': timestamp,
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
    );
  }
}

class RateAndReviewBody {
  RateAndReviewBody({
    this.imageUrl = '',
    this.iconUrl = '',
    this.category = '',
    this.message = '',
  });

  factory RateAndReviewBody.fromJson(Map<String, dynamic> json) => RateAndReviewBody(
        imageUrl: json['imageUrl'],
        iconUrl: json['iconUrl'],
        category: json['category'],
        message: json['message'],
      );

  String imageUrl;
  String iconUrl;
  String category;
  String message;

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'iconUrl': iconUrl,
        'category': category,
        'message': message,
      };

  RateAndReviewBody copyWith({
    String? imageUrl,
    String? iconUrl,
    String? category,
    String? message,
  }) {
    return RateAndReviewBody(
      imageUrl: imageUrl ?? this.imageUrl,
      iconUrl: iconUrl ?? this.iconUrl,
      category: category ?? this.category,
      message: message ?? this.message,
    );
  }
}
