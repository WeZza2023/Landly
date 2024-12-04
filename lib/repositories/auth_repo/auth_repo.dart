import 'package:landly/models/domain_models/login_entity.dart';

abstract class AuthRepo {
  Future<LoginEntity> loginUser(
      {required String phone, required String password});
}
