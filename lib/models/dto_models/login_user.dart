import 'package:landly/models/domain_models/login_entity.dart';
import 'package:landly/models/domain_models/user_entity.dart';

class LoginUserDTO {
  User? user;
  String? token;

  LoginUserDTO({this.user, this.token});

  LoginUserDTO.fromJson(Map<String, dynamic> json) {
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

  LoginEntity toDomain() {
    return LoginEntity(
      user: user!.toDomain(),
      token: token.toString(),
    );
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  dynamic emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
