import '../../models/domain_models/notifications_entity.dart';
import '../../models/dto_models/notifications.dart';

abstract class NotificationsRepo {
  Future<NotificationsEntity> getNotifications();
}
