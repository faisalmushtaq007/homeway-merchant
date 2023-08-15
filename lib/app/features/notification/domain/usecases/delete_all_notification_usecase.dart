part of 'package:homemakers_merchant/app/features/notification/index.dart';

class DeleteAllNotificationUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllNotificationUseCase({
    required this.userNotificationRepository,
  });
  final NotificationRepository userNotificationRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    return userNotificationRepository.deleteAllNotification();
  }
}
