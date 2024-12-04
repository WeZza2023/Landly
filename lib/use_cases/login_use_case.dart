import 'package:landly/repositories/auth_repo/auth_repo.dart';

import '../models/domain_models/login_entity.dart';

class LoginUseCase {
  final AuthRepo authRepo;
  LoginUseCase({required this.authRepo});

  Future<LoginEntity> loginUser(
      {required String phone, required String password}) {
    return authRepo.loginUser(phone: phone, password: password);
  }
}
