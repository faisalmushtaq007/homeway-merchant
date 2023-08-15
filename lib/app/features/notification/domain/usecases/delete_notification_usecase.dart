part of 'package:homemakers_merchant/app/features/notification/index.dart';

class DeleteNotificationUseCase extends UseCaseByID<NotificationEntity, int, DataSourceState<bool>> {
  DeleteNotificationUseCase({
    required this.userNotificationRepository,
  });
  final NotificationRepository userNotificationRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, NotificationEntity? input}) async {
    return userNotificationRepository.deleteNotification(notificationEntity: input, notificationID: id);
  }
}
