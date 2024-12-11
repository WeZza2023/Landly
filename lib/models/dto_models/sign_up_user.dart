import 'package:landly/models/domain_models/auth_entity.dart';

class SignUpUserDTO {
  User? user;
  String? token;

  SignUpUserDTO({this.user, this.token});

  SignUpUserDTO.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }

  AuthEntity toDomain() {
    return AuthEntity(user: user!.toDomain(), token: token!);
  }
}

class User {
  String? name;
  String? email;
  String? phoneNumber;
  int? roleId;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.name,
      this.email,
      this.phoneNumber,
      this.roleId,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    roleId = json['role_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['role_id'] = this.roleId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }

  UserEntity toDomain() {
    return UserEntity(
      id: id.toString(),
      name: name.toString(),
      email: email.toString(),
      phoneNumber: phoneNumber.toString(),
    );
  }
}
