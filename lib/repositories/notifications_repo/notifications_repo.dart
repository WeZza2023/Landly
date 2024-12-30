import '../../models/domain_models/notifications_entity.dart';

abstract class NotificationsRepo {
  Future<NotificationsEntity> getNotifications();
}
