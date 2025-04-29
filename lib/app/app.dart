import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:landly/app/router.dart';
import 'package:landly/screens/add_product/add_product_cubit.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/screens/login/login_cubit.dart';
import 'package:landly/screens/notifications/notifications_cubit.dart';
import 'package:landly/screens/sign_up/sign_up_cubit.dart';
import 'package:landly/screens/splash/splash_screen.dart';
import 'package:landly/utils/constants.dart';
import '../components/custom_texts.dart';
import '../generated/l10n.dart';

class LandlyApp extends StatelessWidget {
  const LandlyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    FontSizes.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(
            create: (context) => HomeCubit()
              ..refresh()
              ..InitBannerAd()),
        BlocProvider(
          create: (context) => AddProductCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationsCubit(),
        ),
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
