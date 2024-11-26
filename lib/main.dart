import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:landly/network/dio_helper.dart';
import 'package:landly/shared_prefs/cache_helper.dart';
import 'package:landly/utils/constants.dart';

import 'app/app.dart';
import 'network/api_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  bool? isLoggedIn;
  try {
    ApiConstants.kToken = CacheHelper.getData(key: AppConstants.userToken);
    ApiConstants.kUserId = CacheHelper.getData(key: AppConstants.userId);
    isLoggedIn = CacheHelper.getData(key: AppConstants.userToken) != null;
  } catch (e) {
    print(e.toString());
    isLoggedIn = false;
  }
  runApp(LandlyApp(
    isLoggedIn: isLoggedIn,
  ));
}
