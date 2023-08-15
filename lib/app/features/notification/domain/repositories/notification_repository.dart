part of 'package:homemakers_merchant/app/features/notification/index.dart';

abstract interface class NotificationRepository {
  Future<DataSourceState<NotificationEntity>> saveNotification({
    required NotificationEntity notificationEntity,
  });

  Future<DataSourceState<NotificationEntity>> editNotification({
    required NotificationEntity notificationEntity,
    required int notificationID,
  });

  Future<DataSourceState<bool>> deleteNotification({
    required int notificationID,
    NotificationEntity? notificationEntity,
  });

  Future<DataSourceState<bool>> deleteAllNotification();

  Future<DataSourceState<NotificationEntity>> getNotification({
    required int notificationID,
    NotificationEntity? notificationEntity,
  });

  Future<DataSourceState<List<NotificationEntity>>> getAllNotification();

  Future<DataSourceState<List<NotificationEntity>>> saveAllNotification({
    required List<NotificationEntity> notificationEntities,
    bool hasUpdateAll = false,
  });
}
