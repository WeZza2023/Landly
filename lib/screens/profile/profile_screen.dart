import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/components/custom_texts.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/screens/sign_up/sign_up_screen.dart';
import 'package:landly/utils/app_icons.dart';
import 'package:landly/utils/app_sizes.dart';
import 'package:landly/utils/colors.dart';
import 'package:landly/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const id = 'ProfileScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AdvancedAvatar(
              size: AppSizes.getBaseScale(context) * 100,
              decoration:
                  BoxDecoration(color: kMainBtnColor, shape: BoxShape.circle),
              children: [
                AdvancedAvatar(
                  size: 30,
                  decoration: BoxDecoration(
                      color: kSubBtnColor, shape: BoxShape.circle),
                  child: IconSelector(
                    icon: AppIcons.edit,
                  ),
                )
              ],
              child: Image.asset(
                AppConstants.appLogo,
              ),
            ).bP16,
            BodySmallText(
              'Profile',
              weight: FontWeight.bold,
              color: kMainTextDarkColor,
            ).bP4,
            BodyTinyText(
              'Edit Profile',
              color: kMainTextLightColor,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              overlayColor:
                  WidgetStateProperty.all(kMainBtnColor.withOpacity(0.2)),
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyTinyText('تسجيل الخروج'),
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.red,
                    ),
                  ],
                ).vP8.hP16,
              ),
            ).hP16
          ],
        ),
      ),
    ));
  }
}
