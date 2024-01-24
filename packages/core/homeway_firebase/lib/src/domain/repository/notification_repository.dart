part 'package:homeway_firebase/src/data/repository/notification_repository_impl.dart';

/// Homeway firebase notification repository
abstract class FirebaseNotificationRepository {
  Future<void> sendNotification();
}
