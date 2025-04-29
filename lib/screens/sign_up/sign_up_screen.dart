import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/screens/sign_up/sign_up_cubit.dart';
import 'package:landly/screens/sign_up/sign_up_state.dart';
import 'package:landly/shared_prefs/cache_helper.dart';

import '../../components/components.dart';
import '../../components/custom_texts.dart';
import '../../components/default_formfield.dart';
import '../../generated/l10n.dart';
import '../../utils/constants.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const id = 'SignUpScreen';
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SignUpCubit>(context);
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    return AppScaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            CacheHelper.saveData(
                key: AppConstants.userToken, value: state.userEntity!.token);
            ApiConstants.kToken = state.userEntity!.token;
            CacheHelper.saveData(
                key: AppConstants.userId, value: state.userEntity!.user.id);
            ApiConstants.kUserId = state.userEntity!.user.id.toString();
            ApiConstants.isLoggedIn = true;
            homeCubit.refresh();
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.id, (route) => false);
          }
          if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar(message: state.message, error: true),
            );
          }
        },
        builder: (context, state) => Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppConstants.appLogo,
                    scale: 5,
                  ).p16,
                  BodyExtraLargeText(
                    S.of(context).sign_up,
                    weight: FontWeight.bold,
                  ).p25,
                  DefaultFormField(
                    controller: firstNameController,
                    type: TextInputType.text,
                    label: S.of(context).first_name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).please_enter_first_name;
                      } else {
                        return null;
                      }
                    },
                  ).bP16,
                  DefaultFormField(
                    controller: lastNameController,
                    type: TextInputType.text,
                    label: S.of(context).last_name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).please_enter_last_name;
                      } else {
                        return null;
                      }
                    },
                  ).bP16,
                  DefaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: S.of(context).phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).please_enter_phone;
                      } else {
                        return null;
                      }
                    },
                  ).bP16,
                  DefaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: S.of(context).email,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).please_enter_email;
                      } else {
                        return null;
                      }
                    },
                  ).bP16,
                  DefaultFormField(
                    controller: passwordController,
                    type: TextInputType.text,
                    label: S.of(context).password,
                    isPassword: cubit.passwordVisible ? false : true,
                    suffix: cubit.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixPressed: () {
                      cubit.changePasswordVisibility();
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).please_enter_password;
                      } else {
                        return null;
                      }
                    },
                  ).bP16,
                  DefaultFormField(
                    controller: confirmPasswordController,
                    type: TextInputType.text,
                    label: S.of(context).confirm_password,
                    isPassword: cubit.confirmPasswordVisible ? false : true,
                    suffix: cubit.confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixPressed: () {
                      cubit.changeConfirmPasswordVisibility();
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).please_enter_confirm_password;
                      } else if (value != passwordController.text) {
                        return S.of(context).confirm_password_does_not_match;
                      } else {
                        return null;
                      }
                    },
                  ).bP16,
                  const SizedBox(
                    height: 16,
                  ),
                  state is SignUpLoadingState
                      ? AppLoadingIndicator(context: context)
                      : CustomTextButton(
                          context: context,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.signUpUser(
                                name:
                                    '${firstNameController.text} ${lastNameController.text}',
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: S.of(context).sign_up),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyExtraSmallText(S.of(context).already_have_an_account),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: BodyExtraSmallText(
                            S.of(context).login,
                            weight: FontWeight.bold,
                          ).hP4)
                    ],
                  ).tP16
                ],
              ).p16,
            ),
          ),
        ),
      ),
    );
  }
}
