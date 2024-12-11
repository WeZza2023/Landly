class AuthEntity {
  final UserEntity user;
  final String token;
  AuthEntity({
    required this.user,
    required this.token,
  });
}

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
