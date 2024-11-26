import 'package:flutter/material.dart';
import 'package:landly/screens/add_product/add_product_screen.dart';
import 'package:landly/screens/sign_up/sign_up_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/product/product_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.id:
        return _buildAnimatedRoute(LoginScreen(), settings);
      case SignUpScreen.id:
        return _buildAnimatedRoute(SignUpScreen(), settings);
      case HomeScreen.id:
        return _buildAnimatedRoute(HomeScreen(), settings);
      case AddProductScreen.id:
        return _buildAnimatedRoute(AddProductScreen(), settings);
      case ProductScreen.id:
        return _buildAnimatedRoute(ProductScreen(), settings);
      default:
        return _buildAnimatedRoute(LoginScreen(), settings);
    }
  }

  static PageRouteBuilder _buildAnimatedRoute(
      Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInCubic;

        final curvedAnimation =
            CurvedAnimation(parent: animation, curve: curve);

        return ScaleTransition(scale: curvedAnimation, child: child);
      },
    );
  }
}
