import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/models/domain_models/products_entity.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/screens/home/home_state.dart';
import 'package:landly/utils/app_icons.dart';

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
    final args = ModalRoute.of(context)?.settings.arguments
        as Map<String, ProductEntity>?;
    var cubit = BlocProvider.of<HomeCubit>(context);
    return AppScaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SendRequestSuccessState) {
          cubit.getBuyerSales();
        }
      },
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
                      '${ApiConstants.kUrl}${args!['productInfo']!.mainPhoto}',
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
                      args['productInfo']!.title!,
                      weight: FontWeight.bold,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      color: kMainTextDarkColor,
                    ),
                  ),
                  Flexible(
                    child: BodyExtraSmallText(
                      args['productInfo']!.price!,
                      maxLines: 3,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              ).bP16,
              Row(
                children: [
                  IconSelector(icon: AppIcons.location).hP4,
                  BodyTinyText(
                    args['productInfo']!.address!,
                    weight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    color: kMainTextLightColor,
                  ),
                ],
              ).bP16,
              BodyMediumText(
                S.of(context).description,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
                color: kMainTextDarkColor,
              ).bP4,
              BodyExtraSmallText(
                args['productInfo']!.description!,
                textAlign: TextAlign.start,
                weight: FontWeight.normal,
                color: kMainTextLightColor,
                maxLines: 5,
              ).bP16,
              BodyMediumText(
                S.of(context).photo_gallery,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
                color: kMainTextDarkColor,
              ).bP8,
              SizedBox(
                height: AppSizes.getBaseScale(context) * 100,
                width: AppSizes.getScreenWidth(context),
                child: (args['productInfo']!.photos!.isEmpty)
                    ? const Center(
                        child: BodyTinyText('لا يوجد صور'),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            showAdaptiveDialog(
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.8),
                              builder: (context) => AppPopupDialog(
                                body: AppNetworkImage(
                                  image:
                                      // '${ApiConstants.kUrl}public/images/${args['productInfo']!.photos![index]}',
                                      args['productInfo']!.photos![index],
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
                              image: args['productInfo']!.photos![index],
                              // '${ApiConstants.kUrl}public/images/${args['productInfo']!.photos![index]}',
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: args['productInfo']!.photos!.length,
                        scrollDirection: Axis.horizontal,
                      ),
              ).bP16,
              BodyMediumText(
                S.of(context).extra_services,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
                color: kMainTextDarkColor,
              ).bP8,
              BodyExtraSmallText(
                args['productInfo']!.extraService!,
                textAlign: TextAlign.start,
                weight: FontWeight.normal,
                color: kMainTextLightColor,
                maxLines: 5,
              ).bP25,
              state is SendRequestLoadingState
                  ? AppLoadingIndicator(context: context)
                  : args['productInfo']!.userId.toString() !=
                          ApiConstants.kUserId.toString()
                      ? CustomTextButton(
                          text: S.of(context).request_contact,
                          context: context,
                          onPressed: () {
                            if (ApiConstants.isLoggedIn == false) {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) =>
                                    PleaseLoginBox(context: context),
                              );
                            } else {
                              if (cubit.buyerSalesList!.any((e) =>
                                      e.productId == args['productInfo']!.id) ==
                                  false) {
                                cubit.sendRequest(
                                    sellerId:
                                        args['productInfo']!.userId!.toString(),
                                    productId:
                                        args['productInfo']!.id!.toString(),
                                    buyerId: ApiConstants.kUserId!);
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
                          color: cubit.buyerSalesList!.isEmpty
                              ? kMainBtnColor
                              : (cubit.buyerSalesList!.any((e) =>
                                      e.productId == args['productInfo']!.id)
                                  ? kInActiveColor
                                  : kMainBtnColor),
                        )
                      : Stack(
                          children: [
                            CustomTextButton(
                                    context: context,
                                    onPressed: () {
                                      showAdaptiveDialog(
                                        context: context,
                                        builder: (context) =>
                                            ContactUsPopup(context: context),
                                      );
                                    },
                                    color: kGoldColor,
                                    text: S.of(context).make_your_ad_featured)
                                .p(AppSizes.getBaseScale(context) * 8),
                            Image.asset(
                              'assets/images/coronet.png',
                              width: AppSizes.getBaseScale(context) * 25,
                              height: AppSizes.getBaseScale(context) * 25,
                            ),
                          ],
                        )
            ],
          ).p16)
        ],
      ),
    ));
  }
}
