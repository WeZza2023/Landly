import 'package:dio/dio.dart';
import 'package:landly/models/dto_models/sign_up_user.dart';
import '../../models/domain_models/auth_entity.dart';
import '../../models/dto_models/login_user.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<AuthEntity> loginUser(
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

  @override
  Future<void> logoutUser() async {
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.kLogout,
        token: ApiConstants.kToken,
      );
    } catch (e) {
      if (e is DioException) {
        throw Exception(DioHelper.handleDioError(e));
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  @override
  Future<AuthEntity> signUpUser(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    try {
      final response =
          await DioHelper.postData(url: ApiConstants.kRegister, data: {
        'name': name,
        'phone_number': phone,
        'email': email,
        'password': password,
        'role_id': 2
      });
      final dto = SignUpUserDTO.fromJson(response.data);
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
