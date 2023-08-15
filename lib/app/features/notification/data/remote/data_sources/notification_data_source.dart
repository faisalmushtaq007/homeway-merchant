part of 'package:homemakers_merchant/app/features/notification/index.dart';

abstract interface class NotificationDataSource {
  Future<ApiResultState<NotificationEntity>> saveNotification({
    required NotificationEntity notificationEntity,
  });

  Future<ApiResultState<NotificationEntity>> editNotification({
    required NotificationEntity notificationEntity,
    required int notificationID,
  });

  Future<ApiResultState<bool>> deleteNotification({
    required int notificationID,
    NotificationEntity? notificationEntity,
  });

  Future<ApiResultState<bool>> deleteAllNotification();

  Future<ApiResultState<NotificationEntity>> getNotification({
    required int notificationID,
    NotificationEntity? notificationEntity,
  });

  Future<ApiResultState<List<NotificationEntity>>> getAllNotification();
  Future<ApiResultState<List<NotificationEntity>>> saveAllNotification({
    required List<NotificationEntity> notificationEntities,
    bool hasUpdateAll = false,
  });
}
