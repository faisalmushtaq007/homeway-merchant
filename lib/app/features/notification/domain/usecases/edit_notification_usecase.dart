part of 'package:homemakers_merchant/app/features/notification/index.dart';

class EditNotificationUseCase extends UseCaseByIDAndEntity<NotificationEntity, int, DataSourceState<NotificationEntity>> {
  EditNotificationUseCase({
    required this.userNotificationRepository,
  });
  final NotificationRepository userNotificationRepository;

  @override
  Future<DataSourceState<NotificationEntity>> call({required NotificationEntity input, required int id}) async {
    return userNotificationRepository.editNotification(notificationEntity: input, notificationID: id);
  }
}
