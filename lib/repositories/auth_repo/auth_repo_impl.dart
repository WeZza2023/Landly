import 'package:dio/dio.dart';

import '../../models/domain_models/login_entity.dart';
import '../../models/dto_models/login_user.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<LoginEntity> loginUser(
      {required String phone, required String password}) async {
    try {
      final response = await DioHelper.postData(
          url: ApiConstants.kLogin,
          data: {'phone_number': phone, 'password': password});
      final dto = LoginUserDTO.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      if (e is DioException) {
        throw Exception(DioHelper.handleDioError(e) == 'Wrong Credentials'
            ? 'بيانات الدخول غير صحيحة'
            : DioHelper.handleDioError(e));
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
