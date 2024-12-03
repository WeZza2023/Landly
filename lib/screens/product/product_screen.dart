import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/components/shimmer.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/screens/home/home_state.dart';
import 'package:landly/screens/product/product_state.dart';
import 'package:landly/screens/product/produt_cubit.dart';

import '../../components/components.dart';
import '../../components/custom_texts.dart';
import '../../generated/l10n.dart';
import '../../utils/app_sizes.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static const id = 'ProductScreen';
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    var cubit = BlocProvider.of<HomeCubit>(context);
    return AppScaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: AppSizes.getBaseScale(context) * 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(15), left: Radius.circular(15)),
                ),
                child: AppNetworkImage(
                  image:
                      '${ApiConstants.kUrl}${args!['productInfo'].mainPhoto}',
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            leading: AppMainBtn(context: context),
            backgroundColor: kBackgroundColor,
          ),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: BodyExtraSmallText(
                      args['productInfo'].title,
                      weight: FontWeight.bold,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      color: kMainTextLightColor,
                    ),
                  ),
                  Flexible(
                    child: BodyExtraSmallText(
                      args['productInfo'].price,
                      maxLines: 3,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              ).bP16,
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: kMainTextLightColor.withOpacity(0.5),
                  ),
                  BodyTinyText(
                    args['productInfo'].address,
                    weight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    color: kMainTextLightColor.withOpacity(0.5),
                  ),
                ],
              ).bP16,
              BodyMediumText(
                S.of(context).description,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
                color: kMainTextLightColor,
              ).bP4,
              BodyExtraSmallText(
                args['productInfo'].description,
                textAlign: TextAlign.start,
                weight: FontWeight.normal,
                color: kMainTextLightColor.withOpacity(0.7),
                maxLines: 5,
              ).bP16,
              BodyMediumText(
                S.of(context).photo_gallery,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
                color: kMainTextLightColor,
              ).bP8,
              SizedBox(
                height: AppSizes.getBaseScale(context) * 100,
                width: AppSizes.getScreenWidth(context),
                child: ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      showAdaptiveDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.8),
                        builder: (context) => AppPopupDialog(
                          body: AppNetworkImage(
                            image:
                                '${ApiConstants.kUrl}public/images/${args['productInfo'].photos[index]}',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: AppSizes.getBaseScale(context) * 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AppNetworkImage(
                        image:
                            '${ApiConstants.kUrl}public/images/${args['productInfo'].photos[index]}',
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: args['productInfo'].photos.length,
                  scrollDirection: Axis.horizontal,
                ),
              ).bP16,
              BodyMediumText(
                S.of(context).extra_services,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
                color: kMainTextLightColor,
              ).bP8,
              BodyExtraSmallText(
                args['productInfo'].extraService,
                textAlign: TextAlign.start,
                weight: FontWeight.normal,
                color: kMainTextLightColor.withOpacity(0.7),
                maxLines: 5,
              ).bP25,
              state is ContactRequestLoadingState &&
                      state.productId == args['productInfo'].id.toString()
                  ? AppLoadingIndicator(context: context)
                  : args['productInfo'].userId.toString() !=
                          ApiConstants.kUserId
                      ? CustomTextButton(
                          text: S.of(context).request_contact,
                          context: context,
                          onPressed: () {
                            if (ApiConstants.kToken == AppConstants.userToken) {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) =>
                                    PleaseLoginBox(context: context),
                              );
                            } else {
                              if (cubit.buyerSalesModel!.sale!.any((e) =>
                                      e.productId == args['productInfo'].id) ==
                                  false) {
                                cubit.contactRequest(
                                    sellerId:
                                        args['productInfo'].userId!.toString(),
                                    productId:
                                        args['productInfo'].id!.toString(),
                                    buyerId: ApiConstants.kUserId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  AppSnackBar(
                                      message: S
                                          .of(context)
                                          .contact_request_already_sent,
                                      error: true),
                                );
                              }
                            }
                          },
                          color: cubit.buyerSalesModel == null
                              ? kMainBtnColor
                              : (cubit.buyerSalesModel!.sale!.any((e) =>
                                      e.productId == args['productInfo'].id)
                                  ? kInActiveColor
                                  : kMainBtnColor),
                        )
                      : const SizedBox()
            ],
          ).p16)
        ],
      ),
    ));
  }
}
