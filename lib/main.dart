import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:landly/network/dio_helper.dart';
import 'package:landly/shared_prefs/cache_helper.dart';
import 'package:landly/utils/constants.dart';

import 'app/app.dart';
import 'components/custom_texts.dart';
import 'network/api_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  // MobileAds.instance.initialize();

  /// test mode
  // RequestConfiguration requestConfiguration = RequestConfiguration(
  //   testDeviceIds: [
  //     "491f4a12-928a-4866-aeee-b419dbaee60b",
  //   ],
  // );
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  /// test mode

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  try {
    ApiConstants.kToken = CacheHelper.getData(key: AppConstants.userToken);
    ApiConstants.kUserId = CacheHelper.getData(key: AppConstants.userId);
  } catch (e) {
    print(e.toString());

  }
  runApp(LandlyApp());
}
