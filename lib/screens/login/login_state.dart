
import '../../models/dto_models/login_user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangePasswordVisibility extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginUserModel? loginUserModel;

  LoginSuccessState(this.loginUserModel);
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}
