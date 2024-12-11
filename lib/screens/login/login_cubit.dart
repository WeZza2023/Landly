import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/use_cases/auth_use_case.dart';
import '../../repositories/auth_repo/auth_repo_impl.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool passwordVisible = false;
  AuthUseCase authUseCase = AuthUseCase(authRepo: AuthRepoImpl());
  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    emit(ChangePasswordVisibility());
  }

  Future<void> loginUser(
      {required String phone, required String password}) async {
    emit(LoginLoadingState());
    try {
      final user = await authUseCase.loginUser(
        phone: phone,
        password: password,
      );
      emit(LoginSuccessState(user));
    } catch (e) {
      emit(
        LoginErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
