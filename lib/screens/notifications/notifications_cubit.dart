import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/network/dio_helper.dart';
import 'package:landly/screens/notifications/notifications_state.dart';

import '../../models/dto_models/notifications.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  NotificationsModel? notificationsModel;

  Future<void> getNotifications() async {
    try {
      emit(GetNotificationsLoadingState());
      await DioHelper.getData(
              url: ApiConstants.kSellerSaleUser, token: ApiConstants.kToken)
          .then((value) {
        print(value.data);
        notificationsModel = NotificationsModel.fromJson(value.data);
        emit(GetNotificationsSuccessState(notificationsModel!));
      }).catchError((e) {
        print(e.toString());
        emit(GetNotificationsErrorState());
      });
    } catch (e) {
      emit(GetNotificationsErrorState());
      print(e.toString());
    }
  }
}
