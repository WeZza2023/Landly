
import '../../models/dto_models/notifications.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsLoadingState extends NotificationsState{}

class GetNotificationsSuccessState extends NotificationsState{
  NotificationsModel notificationsModel ;

  GetNotificationsSuccessState(this.notificationsModel);
}

class GetNotificationsErrorState extends NotificationsState{}