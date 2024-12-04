import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/network/dio_helper.dart';
import 'package:landly/use_cases/login_use_case.dart';

import '../../models/dto_models/login_user.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  bool passwordVisible = false;
  final LoginUseCase loginUseCase;
  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    emit(ChangePasswordVisibility());
  }

  Future<void> loginUser(
      {required String phone, required String password}) async {
    emit(LoginLoadingState());
    try {
      final user =
          await loginUseCase.loginUser(phone: phone, password: password);
      emit(LoginSuccessState(user));
    } catch (e) {
      emit(LoginErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
