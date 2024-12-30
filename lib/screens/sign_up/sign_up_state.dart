import 'package:landly/models/domain_models/auth_entity.dart';


abstract class SignUpState{}

class SignUpInitial extends SignUpState{}

class ChangePasswordVisibility extends SignUpState{}

class ChangeConfirmPasswordVisibility extends SignUpState{}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessState extends SignUpState{
  final AuthEntity? userEntity;

  SignUpSuccessState(this.userEntity);
}

class SignUpErrorState extends SignUpState{
  final String message;

  SignUpErrorState(this.message);
}