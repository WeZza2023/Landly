import 'package:landly/models/domain_models/auth_entity.dart';

abstract class AuthRepo {
  Future<AuthEntity> signUpUser(
      {required String name,
      required String email,
      required String phone,
      required String password});

  Future<AuthEntity> loginUser(
      {required String phone, required String password});

  Future<void> logoutUser();
}
