part of 'package:homemakers_merchant/app/features/notification/index.dart';

class NotificationRemoteDataSource implements NotificationDataSource {
  @override
  Future<ApiResultState<bool>> deleteAllNotification() {
    // TODO: implement deleteAllNotification
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteNotification({required int notificationID, NotificationEntity? notificationEntity}) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<NotificationEntity>> editNotification({required NotificationEntity notificationEntity, required int notificationID}) {
    // TODO: implement editNotification
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<NotificationEntity>>> getAllNotification() {
    // TODO: implement getAllNotification
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<NotificationEntity>> getNotification({required int notificationID, NotificationEntity? notificationEntity}) {
    // TODO: implement getNotification
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<NotificationEntity>> saveNotification({required NotificationEntity notificationEntity}) {
    // TODO: implement saveNotification
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<NotificationEntity>>> saveAllNotification({
    required List<NotificationEntity> notificationEntities,
    bool hasUpdateAll = false,
  }) {
    // TODO: implement saveAllNotification
    throw UnimplementedError();
  }
}
