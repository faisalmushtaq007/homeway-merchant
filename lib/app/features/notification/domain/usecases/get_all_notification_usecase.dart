part of 'package:homemakers_merchant/app/features/notification/index.dart';

class GetAllNotificationUseCase extends UseCase<DataSourceState<List<NotificationEntity>>> {
  GetAllNotificationUseCase({
    required this.userNotificationRepository,
  });
  final NotificationRepository userNotificationRepository;
  @override
  Future<DataSourceState<List<NotificationEntity>>> call() async {
    return userNotificationRepository.getAllNotification();
  }
}
