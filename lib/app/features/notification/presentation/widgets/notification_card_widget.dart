part of 'package:homemakers_merchant/app/features/notification/index.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    required this.notificationEntity,
  });
  final NotificationEntity notificationEntity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notificationEntity.title),
    );
  }
}
