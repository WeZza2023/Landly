import 'package:flutter/material.dart';
import 'package:landly/extentions/padding.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/app_sizes.dart';
import '../utils/colors.dart';

Widget CarouselPH({required bool enabled}) => Skeletonizer(
      enabled: enabled,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
          color: kSubBackgroundColor,
          image: const DecorationImage(
            image: AssetImage('assets/images/white_logo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ).p16,
    );


Widget ImagePH ({required BuildContext context}) =>Skeletonizer(
  enabled: true,
  child: SizedBox(
    height: AppSizes.getBaseScale(context) * 150,
    width: AppSizes.getScreenWidth(context),
    child: Image.asset(
      'assets/images/white_logo.png',
      fit: BoxFit.cover,
    ),
  ),
);