import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/network/dio_helper.dart';
import 'package:landly/screens/notifications/notifications_state.dart';

import '../../models/domain_models/notifications_entity.dart';
import '../../models/dto_models/notifications.dart';
import '../../repositories/notifications_repo/notifications_repo_impl.dart';
import '../../use_cases/notifications_use_case.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  NotificationsUseCase notificationsUseCase =
      NotificationsUseCase(notificationsRepo: NotificationsRepoImpl());

  List<NotificationSaleEntity> notificationsList = [];

  Future<void> getNotifications() async {
    try {
      emit(GetNotificationsLoadingState());
      final notifications = await notificationsUseCase.getNotifications();
      notificationsList = notifications.sales!;
      emit(GetNotificationsSuccessState());
    } catch (e) {
      emit(GetNotificationsErrorState());
      print(e.toString());
    }
  }
}
