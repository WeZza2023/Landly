import '../../models/dto_models/sign_up_user.dart';

abstract class SignUpState{}

class SignUpInitial extends SignUpState{}

class ChangePasswordVisibility extends SignUpState{}

class ChangeConfirmPasswordVisibility extends SignUpState{}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessState extends SignUpState{
  final SignUpUserModel? signUpUserModel;

  SignUpSuccessState(this.signUpUserModel);
}

class SignUpErrorState extends SignUpState{
  final String message;

  SignUpErrorState(this.message);
}