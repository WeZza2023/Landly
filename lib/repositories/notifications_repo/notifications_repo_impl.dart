import 'package:dio/dio.dart';
import 'package:landly/models/domain_models/notifications_entity.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/network/dio_helper.dart';

import '../../models/dto_models/notifications.dart';
import 'notifications_repo.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  @override
  Future<NotificationsEntity> getNotifications() async {
    try {
      final response = await DioHelper.getData(
          url: ApiConstants.kSellerSaleUser, token: ApiConstants.kToken);
      final dto = NotificationsDTO.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      if (e is DioException) {
        throw Exception(DioHelper.handleDioError(e));
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
