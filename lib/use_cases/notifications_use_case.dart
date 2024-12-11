import '../models/domain_models/notifications_entity.dart';
import '../repositories/notifications_repo/notifications_repo.dart';

class NotificationsUseCase {
  NotificationsRepo? notificationsRepo;

  NotificationsUseCase({required this.notificationsRepo});

  Future<NotificationsEntity> getNotifications() {
    return notificationsRepo!.getNotifications();
  }
}
