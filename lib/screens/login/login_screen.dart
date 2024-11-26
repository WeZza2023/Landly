import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/components/components.dart';
import 'package:landly/components/custom_texts.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/screens/home/home_screen.dart';
import 'package:landly/screens/login/login_cubit.dart';
import 'package:landly/screens/login/login_state.dart';
import 'package:landly/screens/sign_up/sign_up_screen.dart';
import 'package:landly/utils/app_sizes.dart';
import 'package:landly/utils/colors.dart';
import 'package:landly/utils/constants.dart';
import '../../components/app_scaffold.dart';
import '../../components/default_formfield.dart';
import '../../generated/l10n.dart';
import '../../network/api_constants.dart';
import '../../shared_prefs/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const id = 'LoginScreen';
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LoginCubit>(context);
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    return AppScaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
                key: AppConstants.userToken,
                value: state.loginUserModel!.token);
            ApiConstants.kToken = state.loginUserModel!.token!;
            CacheHelper.saveData(
                key: AppConstants.userId,
                value: state.loginUserModel!.user!.id.toString());
            ApiConstants.kUserId = state.loginUserModel!.user!.id!.toString();
            ApiConstants.kToken = state.loginUserModel!.token!;
            homeCubit.refresh();
            phoneController.clear();
            passwordController.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.id, (route) => false);
          }
          if (state is LoginErrorState) {
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
                    S.of(context).login,
                    weight: FontWeight.bold,
                  ).p25,
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
                    controller: passwordController,
                    type: TextInputType.text,
                    label: S.of(context).password,
                    suffix: cubit.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixPressed: () {
                      cubit.changePasswordVisibility();
                    },
                    isPassword: cubit.passwordVisible ? false : true,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).please_enter_password;
                      } else {
                        return null;
                      }
                    },
                  ).bP16,
                  // InkWell(
                  //   onTap: () {},
                  //   child: BodyTinyText(
                  //     S.of(context).forgot_password,
                  //     weight: FontWeight.normal,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  state is LoginLoadingState
                      ? AppLoadingIndicator(context: context)
                      : CustomTextButton(
                          context: context,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.loginUser(
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: S.of(context).login),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyExtraSmallText(S.of(context).dont_have_an_account),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                          child: BodyExtraSmallText(
                            S.of(context).sign_up,
                            weight: FontWeight.bold,
                          ).hP4),
                    ],
                  ).bP25.vP16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kMainBtnColor,
                        size: AppSizes.getBaseScale(context) * 15,
                      ),
                      InkWell(
                          onTap: () {
                            homeCubit.getAllProducts();
                            homeCubit.getFeaturedProducts();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.id,
                              (route) => false,
                            );
                          },
                          child: BodyExtraSmallText(
                            S.of(context).login_later,
                            weight: FontWeight.bold,
                          ).hP4),
                    ],
                  ),
                ],
              ).p16,
            ),
          ),
        ),
      ),
    );
  }
}
