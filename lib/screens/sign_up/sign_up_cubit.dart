import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/models/sign_up_user.dart';
import 'package:landly/screens/sign_up/sign_up_state.dart';

import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  SignUpUserModel? signUpUserModel;

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
      await DioHelper.postData(url: ApiConstants.kRegister, data: {
        'name': name,
        'phone_number': phone,
        'email': email,
        'password': password,
        'role_id': 2
      }).then((value) {
        print(value.data);
        signUpUserModel = SignUpUserModel.fromJson(value.data);
        emit(SignUpSuccessState(signUpUserModel!));
      }).catchError((e) {
        if (e is DioException) {
          if (e.response!.statusCode == 422) {
            print(e.response!.data);
            String message = e.response!.data['message'];
            emit(SignUpErrorState(message));
          }
        } else {
          print(e.toString());
          emit(SignUpErrorState(e.toString()));
        }
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 422) {
          print(e.response!.data);
          String message = e.response!.data['message'];
          emit(SignUpErrorState(message));
        }
      } else {
        print(e.toString());
        emit(SignUpErrorState(e.toString()));
      }
    }
  }
}
