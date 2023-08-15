part of 'package:homemakers_merchant/app/features/notification/index.dart';

class SaveNotificationUseCase extends UseCaseIO<NotificationEntity, DataSourceState<NotificationEntity>> {
  SaveNotificationUseCase({
    required this.userNotificationRepository,
  });
  final NotificationRepository userNotificationRepository;
  @override
  Future<DataSourceState<NotificationEntity>> call(NotificationEntity input) async {
    return userNotificationRepository.saveNotification(notificationEntity: input);
  }
}
