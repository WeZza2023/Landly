import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:landly/app/router.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/repositories/featured_products_repo/featured_products_repo_impl.dart';
import 'package:landly/screens/add_product/add_product_cubit.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/screens/login/login_cubit.dart';
import 'package:landly/screens/notifications/notifications_cubit.dart';
import 'package:landly/screens/sign_up/sign_up_cubit.dart';
import 'package:landly/screens/splash/splash_screen.dart';
import 'package:landly/shared_prefs/cache_helper.dart';
import 'package:landly/use_cases/auth_use_case.dart';
import 'package:landly/utils/constants.dart';

import '../generated/l10n.dart';
import '../repositories/auth_repo/auth_repo_impl.dart';
import '../screens/home/home_screen.dart';

class LandlyApp extends StatelessWidget {
  const LandlyApp({super.key, required this.isLoggedIn});
  final bool? isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => HomeCubit()..refresh()),
        BlocProvider(
          create: (context) => AddProductCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationsCubit(),
        ),
        // BlocProvider(
        //   create: (context) => ProductCubit(),
        // ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          fontFamily: 'Almarai',
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
