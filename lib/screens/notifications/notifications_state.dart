
import '../../models/dto_models/notifications.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsLoadingState extends NotificationsState{}

class GetNotificationsSuccessState extends NotificationsState{
}

class GetNotificationsErrorState extends NotificationsState{}