part of 'package:homemakers_merchant/app/features/notification/index.dart';

class GetNotificationUseCase extends UseCaseByID<NotificationEntity, int, DataSourceState<NotificationEntity>> {
  GetNotificationUseCase({
    required this.userNotificationRepository,
  });
  final NotificationRepository userNotificationRepository;
  @override
  Future<DataSourceState<NotificationEntity>> call({required int id, NotificationEntity? input}) async {
    return userNotificationRepository.getNotification(notificationEntity: input, notificationID: id);
  }
}
