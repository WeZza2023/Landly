import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:landly/components/app_scaffold.dart';
import 'package:landly/components/components.dart';
import 'package:landly/components/custom_texts.dart';
import 'package:landly/extentions/padding.dart';
import 'package:landly/screens/add_product/add_product_cubit.dart';
import 'package:landly/screens/home/home_cubit.dart';
import 'package:landly/screens/home/home_state.dart';
import 'package:landly/screens/notifications/notifications_cubit.dart';
import 'package:landly/screens/notifications/notifications_screen.dart';
import 'package:landly/screens/profile/profile_screen.dart';
import 'package:landly/shared_prefs/cache_helper.dart';
import 'package:landly/utils/app_sizes.dart';
import 'package:landly/utils/colors.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../components/shimmer.dart';
import '../../generated/l10n.dart';
import '../../models/domain_models/products_entity.dart';
import '../../network/api_constants.dart';
import '../../utils/constants.dart';
import '../add_product/add_product_screen.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const id = 'HomeScreen';
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          CacheHelper.removeData(key: AppConstants.userToken);
          CacheHelper.removeData(key: AppConstants.userId);
          ApiConstants.kToken = null;
          ApiConstants.kUserId = null;
          cubit.clear();
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }
      },
      builder: (context, state) {
        return AppScaffold(
          floatingActionButton: cubit.productsList.isNotEmpty
              ? AppFloatingButton(
                  context: context,
                  icon: cubit.toTopVisible == true
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.add,
                  onPressed: cubit.toTopVisible == true
                      ? () {
                          scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastEaseInToSlowEaseOut);
                        }
                      : () {
                          if (ApiConstants.isLoggedIn == false) {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) =>
                                  PleaseLoginBox(context: context),
                            );
                          } else {
                            var addProductCubit =
                                BlocProvider.of<AddProductCubit>(context);
                            if (addProductCubit.areasList.isEmpty ||
                                addProductCubit.typesList.isEmpty) {
                              addProductCubit.getAreas();
                              addProductCubit.getTypes();
                            }
                            Navigator.pushNamed(context, AddProductScreen.id);
                          }
                        },
                  isMini: cubit.toTopVisible)
              : null,
          appBar: CustomAppBar(
            context: context,
            leading: AppMainBtn(
              context: context,
              color: Colors.transparent,
              onTap: () {
                if (ApiConstants.isLoggedIn == false) {
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                  cubit.clear();
                } else {
                  cubit.logoutUser();
                }
                // Navigator.pushNamed(context, ProfileScreen.id);
              },
              icon: ApiConstants.isLoggedIn == false
                  ? Icons.person
                  : Icons.logout_rounded,
            ),
            actions: ApiConstants.isLoggedIn == false
                ? []
                : [
                    AppMainBtn(
                      context: context,
                      icon: Icons.notifications_none_rounded,
                      color: Colors.transparent,
                      onTap: () {
                        BlocProvider.of<NotificationsCubit>(context)
                            .getNotifications();
                        Navigator.pushNamed(context, NotificationsScreen.id);
                      },
                    ).setPadding(end: 5),
                  ],
          ),
          body: DefaultTabController(
            length: cubit.areasList.isEmpty ? 5 : cubit.areasList.length,
            child: LiquidPullToRefresh(
              height: 50,
              color: kMainBtnColor,
              showChildOpacityTransition: false,
              springAnimationDurationInMilliseconds: 500,
              animSpeedFactor: 4,
              onRefresh: () {
                return cubit.refresh();
              },
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: scrollController
                      ..addListener(
                        () {
                          if (cubit.currentPage <= cubit.totalPages &&
                              scrollController.position.pixels ==
                                  scrollController.position.maxScrollExtent &&
                              cubit.isLoading == false) {
                            cubit.getMoreProducts();
                          }
                          if (scrollController.position.pixels >
                                  AppSizes.getScreenHeight(context) &&
                              cubit.toTopVisible == false) {
                            cubit.showToTopBTN();
                          } else if (scrollController.position.pixels <=
                                  AppSizes.getScreenHeight(context) &&
                              cubit.toTopVisible == true) {
                            cubit.hideToTopBTN();
                          }
                        },
                      ),
                    slivers: [
                      // SliverToBoxAdapter(
                      //   child: cubit.isBannerAdReady == true
                      //       ? SizedBox(
                      //           height: cubit.bannerAd?.size.height.toDouble(),
                      //           width: cubit.bannerAd?.size.width.toDouble(),
                      //           child: AdWidget(ad: cubit.bannerAd!),
                      //         ).vP8
                      //       : SizedBox(),
                      // ),
                      SliverToBoxAdapter(
                        child: BodySmallText(
                          S.of(context).special_offers,
                          weight: FontWeight.bold,
                          textAlign: TextAlign.start,
                        ).hP16.tP8,
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: cubit.featuredProductsList!.isEmpty
                                  ? 2
                                  : cubit.featuredProductsList!.length,
                              itemBuilder: (context, index, realIndex) =>
                                  cubit.featuredProductsList!.isEmpty
                                      ? CarouselPH(
                                          enabled: cubit
                                              .featuredProductsList!.isEmpty,
                                        )
                                      : CarouselBox(
                                          context: context,
                                          image: ApiConstants.kUrl +
                                              cubit.featuredProductsList![index]
                                                  .product!.mainPhoto!,
                                          productInfo: cubit
                                              .featuredProductsList![index]
                                              .product!,
                                        ).p16,
                              options: CarouselOptions(
                                height:
                                    AppSizes.getScreenHeight(context) * 0.25,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.easeInOutBack,
                                enlargeCenterPage: true,
                                enlargeFactor: 1,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  cubit.changeCarouselIndex(index);
                                },
                              ),
                            ),
                            cubit.featuredProductsList!.isEmpty
                                ? const SizedBox()
                                : AnimatedSmoothIndicator(
                                    activeIndex: cubit.currentCarouselIndex,
                                    count: cubit.featuredProductsList!.isEmpty
                                        ? 0
                                        : cubit.featuredProductsList!.length,
                                    effect: ExpandingDotsEffect(
                                      dotHeight: 7,
                                      dotWidth: 7,
                                      dotColor: kMainBtnColor.withOpacity(0.4),
                                      activeDotColor: kMainBtnColor,
                                    ),
                                  ).bP16,
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: BodySmallText(
                          S.of(context).all_offers,
                          weight: FontWeight.bold,
                          textAlign: TextAlign.start,
                        ).p16,
                      ),
                      if (ApiConstants.isLoggedIn == true)
                        SliverToBoxAdapter(
                          child: ButtonsTabBar(
                            backgroundColor: cubit.areasList.isEmpty
                                ? kMainTextLightColor.withOpacity(0.1)
                                : kMainBtnColor.withOpacity(0.3),
                            unselectedBackgroundColor:
                                kMainTextLightColor.withOpacity(0.1),
                            physics: BouncingScrollPhysics(),
                            labelStyle: TextStyle(fontFamily: 'Almarai'),
                            unselectedLabelStyle:
                                TextStyle(fontFamily: 'Almarai'),
                            onTap: (index) {
                              if (cubit.areasList.isNotEmpty) {
                                cubit.changeTabIndex(index);
                              }
                            },
                            tabs: List.generate(
                              cubit.areasList.isEmpty
                                  ? 5
                                  : cubit.areasList.length,
                              (index) => cubit.areasList.isEmpty
                                  ? Tab(
                                      child: Skeletonizer(
                                        enabled: cubit.areasList.isEmpty,
                                        child: BodyTinyText('Some Area'),
                                      ),
                                    )
                                  : CustomTabWidget(
                                      title: cubit.areasList[index].areaName,
                                      isSelected:
                                          cubit.currentTabIndex == index),
                            ),
                          ),
                        ),
                      SliverList.builder(
                          itemBuilder: (context, index) {
                            return cubit.productsList.isEmpty
                                ? Skeletonizer(
                                    enabled: cubit.productsList.isEmpty ||
                                        cubit.areasList.isEmpty,
                                    containersColor:
                                        kMainBtnColor.withOpacity(0.1),
                                    child: MainItemBox(
                                      context: context,
                                      productInfo: ProductEntity(),
                                      address: 'some address',
                                      image: '',
                                      // onTap: () {},
                                      title: 'some title',
                                      price: 'some price',
                                    ).p16,
                                  )
                                : cubit.currentTabIndex == 0
                                    ? MainItemBox(
                                            context: context,
                                            productInfo:
                                                cubit.productsList[index],
                                            image: ApiConstants.kUrl +
                                                cubit.productsList[index]
                                                    .mainPhoto!,
                                            title: cubit
                                                .productsList[index].title!,
                                            price: cubit
                                                .productsList[index].price!,
                                            isMyProduct: cubit
                                                    .productsList[index].userId
                                                    .toString() ==
                                                ApiConstants.kUserId,
                                            address: cubit
                                                .productsList[index].address!)
                                        .p16
                                    : cubit.productsList[index].areaId ==
                                            cubit
                                                .areasList[
                                                    cubit.currentTabIndex]
                                                .id
                                        ? MainItemBox(
                                                context: context,
                                                image: ApiConstants.kUrl +
                                                    cubit.productsList[index]
                                                        .mainPhoto!,
                                                title: cubit
                                                    .productsList[index].title!,
                                                price: cubit
                                                    .productsList[index].price!,
                                                isMyProduct: cubit
                                                        .productsList[index]
                                                        .userId
                                                        .toString() ==
                                                    ApiConstants.kUserId,
                                                address: cubit
                                                    .productsList[index]
                                                    .address!,
                                                productInfo:
                                                    cubit.productsList[index])
                                            .p16
                                        : SizedBox();
                          },
                          itemCount: cubit.productsList.isEmpty
                              ? 5
                              : cubit.productsList.length),
                      SliverToBoxAdapter(
                          child: cubit.currentPage > cubit.totalPages
                              ? BodyTinyText(
                                  S.of(context).no_more,
                                  weight: FontWeight.normal,
                                ).vP8
                              : AppLoadingIndicator(context: context).vP8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
