import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/models/domain_models/auth_entity.dart';
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
      // final user = await authUseCase.loginUser(
      //   phone: phone,
      //   password: password,
      // );
      AuthEntity? user;
      await Future.delayed(
        Duration(seconds: 2),
        () {
          user = AuthEntity(
              user: UserEntity(
                  id: '1',
                  name: 'Moataz',
                  email: 'm.moataz223@gmail.com',
                  phoneNumber: '+201095069803'),
              token: 'scsca555s55s5a5s5aaaaaas');
        },
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
