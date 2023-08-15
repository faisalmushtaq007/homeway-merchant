part of 'package:homemakers_merchant/app/features/notification/index.dart';

class NotificationEntity {
  NotificationEntity({
    this.flag = -1,
    this.subtitle = '',
    this.notificationID = -1,
    this.title = '',
    this.clickAction = '',
    this.type = '',
    this.priority = -1,
    required this.body,
    this.timestamp = -1,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) => NotificationEntity(
        flag: json['flag'],
        subtitle: json['subtitle'],
        notificationID: json['notificationID'],
        title: json['title'],
        clickAction: json['click_action'],
        type: json['type'],
        priority: json['priority'],
        body: json['body'] != null ? NotificationBody.fromJson(json['body']) : NotificationBody(),
        timestamp: json['timestamp'],
      );

  int flag;
  String subtitle;
  int notificationID;
  String title;
  String clickAction;
  String type;
  int priority;
  NotificationBody body;
  int timestamp;

  Map<String, dynamic> toJson() => {
        'flag': flag,
        'subtitle': subtitle,
        'notificationID': notificationID,
        'title': title,
        'click_action': clickAction,
        'type': type,
        'priority': priority,
        'body': body.toJson(),
        'timestamp': timestamp,
      };

  NotificationEntity copyWith({
    int? flag,
    String? subtitle,
    int? notificationID,
    String? title,
    String? clickAction,
    String? type,
    int? priority,
    NotificationBody? body,
    int? timestamp,
  }) {
    return NotificationEntity(
      flag: flag ?? this.flag,
      subtitle: subtitle ?? this.subtitle,
      notificationID: notificationID ?? this.notificationID,
      title: title ?? this.title,
      clickAction: clickAction ?? this.clickAction,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class NotificationBody {
  NotificationBody({
    this.imageUrl = '',
    this.iconUrl = '',
    this.category = '',
    this.message = '',
  });

  factory NotificationBody.fromJson(Map<String, dynamic> json) => NotificationBody(
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

  NotificationBody copyWith({
    String? imageUrl,
    String? iconUrl,
    String? category,
    String? message,
  }) {
    return NotificationBody(
      imageUrl: imageUrl ?? this.imageUrl,
      iconUrl: iconUrl ?? this.iconUrl,
      category: category ?? this.category,
      message: message ?? this.message,
    );
  }
}
