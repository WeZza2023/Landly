import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:landly/components/shimmer.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/models/domain_models/products_entity.dart';
import 'package:landly/utils/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../generated/l10n.dart';
import '../models/dto_models/products.dart';
import '../screens/login/login_screen.dart';
import '../screens/product/product_screen.dart';
import '../utils/app_sizes.dart';
import '../utils/constants.dart';
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
  // required Function() onTap,
  required ProductEntity productInfo,
  // Color? btnColor,
  bool? isMyProduct,
  // bool? isLoading,
  // bool? isShow,
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
              Stack(
                children: [
                  AppNetworkImage(
                    image: image,
                    height: AppSizes.getBaseScale(context) * 150,
                    width: AppSizes.getScreenWidth(context),
                  ),
                  if (isMyProduct == true)
                    Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {},
                          child: Lottie.asset(
                            'assets/lottie/premium.json',
                            height: 50,
                            width: 50,
                          ),
                        )),
                ],
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

                  // isLoading == true && isLoading != null
                  //     ? AppLoadingIndicator(context: context)
                  //     : isShow == true ? Center(
                  //         child: CustomTextButton(
                  //           context: context,
                  //           color: btnColor,
                  //           onPressed: onTap,
                  //           text: S.of(context).request_contact,
                  //           isSmall: true,
                  //         ),
                  //       ) : const SizedBox()
                ],
              ).p16
            ],
          ),
        ),
      ),
    );

Widget CarouselBox({
  required String image,
  required BuildContext context,
  required ProductEntity productInfo,
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
      ),
    );

Widget AppMainBtn(
        {required BuildContext context,
        IconData? icon,
        Function()? onTap,
        Color? color}) =>
    IconButton(
        color: kMainBtnColor,
        style:
            IconButton.styleFrom(backgroundColor: color ?? kSubBackgroundColor),
        onPressed: onTap ??
            () {
              Navigator.pop(context);
            },
        icon: Icon(
          icon ?? Icons.arrow_back_ios_new_rounded,
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
  required Widget body,
  String? title,
}) {
  return AlertDialog(
    content: body,
    scrollable: true,
    backgroundColor: kSubBackgroundColor,
    clipBehavior: Clip.antiAlias,
    contentPadding: EdgeInsets.zero,
    actionsAlignment: MainAxisAlignment.center,
    title: title == null
        ? null
        : Center(
            child: BodyExtraSmallText(
              title,
              maxLines: 1,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
  );
}

AppBar MainAppBar({
  required BuildContext context,
  required Widget leading,
  List<Widget>? actions,
  Widget? title,
}) =>
    AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kBackgroundColor,
      leading: leading,
      actions: actions,
      title: title ??
          Image.asset(
            AppConstants.appLogo,
            scale: 10,
          ).p16,
      centerTitle: true,
    );

Widget NotificationsBox(
        {required BuildContext context,
        required String name,
        required String title,
        required String phone,
        required String address,
        required String image}) =>
    Container(
      child: Container(
        clipBehavior: Clip.antiAlias,
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
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: AppNetworkImage(
                image: image,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyExtraSmallText(
                    '$name ${S.of(context).requested_to_contact_you}',
                    weight: FontWeight.bold,
                  ).bP8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: BodyExtraSmallText(title)),
                      Flexible(child: BodyExtraSmallText(phone.toString())),
                    ],
                  ).bP4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.black26,
                      ),
                      Flexible(
                        child: BodyTinyText(
                          address,
                          weight: FontWeight.bold,
                          textAlign: TextAlign.start,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ],
              ).hP16,
            )
          ],
        ),
      ).p8,
    );

Widget PleaseLoginBox({required BuildContext context}) => AppPopupDialog(
    title: S.of(context).sorry,
    body: Column(
      children: [
        Image.asset(
          AppConstants.loginGIF,
          width: AppSizes.getBaseScale(context) * 200,
        ).bP8,
        BodySmallText(S.of(context).you_are_not_logged_in).bP16,
        CustomTextButton(
                context: context,
                isSmall: true,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.id,
                    (route) => false,
                  );
                },
                text: S.of(context).login)
            .bP16,
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: BodyTinyText(
              S.of(context).login_later,
              weight: FontWeight.normal,
            ))
      ],
    ).p16);
