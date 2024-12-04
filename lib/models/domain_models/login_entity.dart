import 'package:landly/models/domain_models/user_entity.dart';

class LoginEntity {
  final UserEntity user;
  final String token;
  LoginEntity({
    required this.user,
    required this.token,
  });
}
