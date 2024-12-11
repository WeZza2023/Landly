import 'package:landly/repositories/auth_repo/auth_repo.dart';

import '../models/domain_models/auth_entity.dart';

class AuthUseCase {
  final AuthRepo authRepo;
  AuthUseCase({required this.authRepo});

  Future<AuthEntity> signUpUser(
      {required String name,
      required String email,
      required String phone,
      required String password}) {
    return authRepo.signUpUser(
        name: name, email: email, phone: phone, password: password);
  }

  Future<AuthEntity> loginUser(
      {required String phone, required String password}) {
    return authRepo.loginUser(phone: phone, password: password);
  }

  Future<void> logoutUser() {
    return authRepo.logoutUser();
  }
}
