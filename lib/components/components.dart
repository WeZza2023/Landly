
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:landly/components/shimmer.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/utils/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../generated/l10n.dart';
import '../models/products.dart';
import '../screens/product/product_screen.dart';
import '../utils/app_sizes.dart';
import 'custom_texts.dart';

Widget CustomTextButton({
  required BuildContext context,
  required Function()? onPressed,
  required String text,
  Color? color,
  Color? textColor,
  isSmall = false,
}) =>
    TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? kMainBtnColor,
          overlayColor:
              WidgetStateColor.resolveWith((states) => kBackgroundColor),
          fixedSize: isSmall == true
              ? null
              : Size(AppSizes.getScreenWidth(context),
                  AppSizes.getBaseScale(context) * 52),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSizes.getBaseScale(context) * 16),
          ),
        ),
        child: BodySmallText(
          text,
          color: kBackgroundColor,
        ));

Widget AppLoadingIndicator(
        {required BuildContext context, Color? color, double? percent}) =>
    Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CircularProgressIndicator(
          color: color ?? kMainBtnColor,
          strokeWidth: 2,
          value: percent,
          strokeAlign: -5 * AppSizes.getBaseScale(context),
          strokeCap: StrokeCap.round,
        ),
      ),
    );

SnackBar AppSnackBar({
  required String message,
  bool? error = false,
}) {
  return SnackBar(
    duration: const Duration(seconds: 2),
    backgroundColor: error == true ? Colors.red : Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      ),
    ),
    content: Center(
      child: BodyExtraSmallText(
        message,
        color: Colors.white,
        maxLines: 10,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget MainItemBox({
  required BuildContext context,
  required String image,
  required String title,
  required String price,
  required String address,
  required Function() onTap,
  required Data productInfo,
  Color? btnColor,
  bool? isLoading,
}) =>
    InkWell(
      borderRadius: BorderRadius.circular(20),
      overlayColor: WidgetStateProperty.all(kMainBtnColor.withOpacity(0.2)),
      onTap: () {
        Navigator.pushNamed(context, ProductScreen.id, arguments: {
          'productInfo': productInfo,
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: kSubBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              AppNetworkImage(
                image: image,
                height: AppSizes.getBaseScale(context) * 150,
                width: AppSizes.getScreenWidth(context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodySmallText(
                    price,
                    weight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  BodyTinyText(
                    title,
                    weight: FontWeight.w600,
                    textAlign: TextAlign.start,
                    color: Colors.black54,
                  ).vP4,
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.black26,
                      ),
                      BodyTinyText(
                        address,
                        weight: FontWeight.bold,
                        textAlign: TextAlign.start,
                        color: Colors.black26,
                      ),
                    ],
                  ).bP16,
                  isLoading == true && isLoading != null
                      ? AppLoadingIndicator(context: context)
                      : Center(
                          child: CustomTextButton(
                            context: context,
                            color: btnColor,
                            onPressed: onTap,
                            text: S.of(context).request_contact,
                            isSmall: true,
                          ),
                        )
                ],
              ).p16
            ],
          ),
        ),
      ),
    );

Widget CarouselBox({
  required String image,
}) =>
    Container(
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
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );

Widget AppBackBtn({required BuildContext context}) => IconButton(
    color: kMainBtnColor,
    style: IconButton.styleFrom(backgroundColor: kSubBackgroundColor),
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_back_ios_new_rounded,
      color: kMainBtnColor,
    ));

Widget AppNetworkImage(
        {required String image, double? height, double? width}) =>
    Image.network(
      image,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => ImagePH(context: context),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return ImagePH(context: context);
        }
      },
    );

Widget AppPopupDialog({
  required List<Widget> body,
   String? title,
}) {
  return AlertDialog(
    elevation: 0.1,
    content: SingleChildScrollView(
      child: Column(
        children: body,
      ),
    ),
    clipBehavior: Clip.antiAlias,
    contentPadding: EdgeInsets.zero,
    title:title == null ? null : Center(
      child: BodyMediumText(
        title,
        maxLines: 4,
        textAlign: TextAlign.center,
      ),
    ),
  );
}