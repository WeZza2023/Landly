import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/repositories/auth_repo/auth_repo_impl.dart';
import 'package:landly/screens/sign_up/sign_up_state.dart';
import 'package:landly/use_cases/auth_use_case.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final AuthUseCase authUseCase = AuthUseCase(authRepo: AuthRepoImpl());
  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    emit(ChangePasswordVisibility());
  }

  void changeConfirmPasswordVisibility() {
    confirmPasswordVisible = !confirmPasswordVisible;
    emit(ChangeConfirmPasswordVisibility());
  }

  Future<void> signUpUser(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    emit(SignUpLoadingState());
    try {
      final user = await authUseCase.signUpUser(
          name: name, email: email, phone: phone, password: password);
      emit(SignUpSuccessState(user));
    } catch (e) {
      emit(
        SignUpErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
