import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/models/login_user.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/network/dio_helper.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool passwordVisible = false;
  LoginUserModel? loginUserModel;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    emit(ChangePasswordVisibility());
  }


  Future<void> loginUser({required String phone, required String password}) async {
    emit(LoginLoadingState());
    try {
      await DioHelper.postData(url: ApiConstants.kLogin, data: {
        'phone_number': phone,
        'password': password
      }).then((value) {
        print(value.data);
        loginUserModel = LoginUserModel.fromJson(value.data);
        emit(LoginSuccessState(loginUserModel!));
      }).catchError((e) {
        if (e is DioException) {
          if (e.response!.statusCode == 401) {
            print(e.response!.data);
            String message = e.response!.data['message'];
            emit(LoginErrorState(message));
          }
        } else {
          print(e.toString());
          emit(LoginErrorState(e.toString()));
        }
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          print(e.response!.data);
          String message = e.response!.data['message'];
          emit(LoginErrorState(message));
        }
      } else {
        print(e.toString());
        emit(LoginErrorState(e.toString()));
      }
    }
  }


}