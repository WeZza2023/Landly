
import 'package:landly/models/domain_models/auth_entity.dart';


abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangePasswordVisibility extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final AuthEntity? loginEntity;

  LoginSuccessState(this.loginEntity);
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}
