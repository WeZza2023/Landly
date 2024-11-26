import 'package:flutter/cupertino.dart';

class AppSizes {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getBaseScale(BuildContext context) {
    return AppSizes.getScreenWidth(context) / 400;
  }
}
