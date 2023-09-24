part of 'package:homemakers_merchant/app/features/notification/index.dart';

class SaveAllNotificationUseCase extends UseCaseIO<List<NotificationEntity>,
    DataSourceState<List<NotificationEntity>>> {
  SaveAllNotificationUseCase({
    required this.userNotificationRepository,
  });
  final NotificationRepository userNotificationRepository;
  @override
  Future<DataSourceState<List<NotificationEntity>>> call(
      List<NotificationEntity> input) async {
    return userNotificationRepository.saveAllNotification(
      notificationEntities: input,
      hasUpdateAll: false,
    );
  }
}
