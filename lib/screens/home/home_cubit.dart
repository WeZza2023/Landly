import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/repositories/buyer_sales_repo/buyer_sales_repo_impl.dart';
import 'package:landly/screens/add_product/add_product_cubit.dart';
import 'package:landly/screens/home/home_state.dart';
import 'package:landly/use_cases/auth_use_case.dart';
import 'package:landly/use_cases/featured_use_case.dart';
import 'package:landly/use_cases/main_products_use_case.dart';
import 'package:landly/use_cases/seller_sales_use_case.dart';
import 'package:landly/utils/constants.dart';
import '../../models/domain_models/areas_entity.dart';
import '../../models/domain_models/products_entity.dart';
import '../../models/domain_models/seller_sales_entity.dart';
import '../../repositories/areas_repo/areas_repo_impl.dart';
import '../../repositories/auth_repo/auth_repo_impl.dart';
import '../../repositories/featured_products_repo/featured_products_repo_impl.dart';
import '../../repositories/main_products_repo/main_products_repo_impl.dart';
import '../../repositories/requests_repo/requests_repo_impl.dart';
import '../../use_cases/areas_use_case.dart';
import '../../use_cases/requests_use_case.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int currentCarouselIndex = 0;
  // ProductsDTO? productsModel;
  int currentPage = 1;
  int totalPages = 0;
  List<ProductEntity> productsList = [];
  List<FeaturedProductEntity>? featuredProductsList = [];
  List<SellerSaleEntity>? buyerSalesList = [];
  bool isLoading = false;
  int currentTabIndex = 0;
  bool toTopVisible = false;
  List<AreaEntity> areasList = [];
  AreasUseCase areasUseCase = AreasUseCase(areasRepo: AreasRepoImpl());

  /// Ads part
  final bool isTest = true;
  late BannerAd? bannerAd;
  bool isBannerAdReady = false;

  /// Ads part

  MainProductsUseCase mainProductsUseCase =
      MainProductsUseCase(mainProductsRepo: MainProductsRepoImpl());
  AuthUseCase authUseCase = AuthUseCase(authRepo: AuthRepoImpl());
  FeaturedUseCase? featuredUseCase =
      FeaturedUseCase(featuredProductsRepo: FeaturedProductsRepoImpl());
  BuyerSalesUseCase buyerSalesUseCase =
      BuyerSalesUseCase(buyerSalesRepo: BuyerSalesRepoImpl());
  RequestsUseCase requestsUseCase =
      RequestsUseCase(requestsRepo: RequestsRepoImpl());

  void changeCarouselIndex(int index) {
    currentCarouselIndex = index;
    emit(ChangeCarouselIndex());
  }

  Future<void> logoutUser() async {
    emit(LogoutLoadingState());
    try {
      // await authUseCase.logoutUser();
      ApiConstants.kToken = null;
      ApiConstants.kUserId = null;
      emit(LogoutSuccessState());
    } catch (e) {
      emit(
        LogoutErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> getFeaturedProducts() async {
    emit(GetFeaturedProductsLoadingState());
    try {
      // final fProducts = await featuredUseCase!.getFeaturedProducts();
      // featuredProductsList = fProducts.featuredProducts;
      Future.delayed(
        Duration(seconds: 2),
        () {
          featuredProductsList?.addAll(List.generate(
            10,
            (index) => FeaturedProductEntity(
                product: ProductEntity(
              title: 'منزل للبيع',
              price: '١٬٢٥٠٬٠٠٠ جنيه',
              phoneNumber: '٠١٠٠٩٩٨٨٧٧٦',
              address: 'الجيزة، حدائق الأهرام، بوابة أ',
              description:
                  'منزل دورين على مساحة ٢٥٠ متر، تشطيب سوبر لوكس، قريب من جميع الخدمات والمدارس.',
              mainPhoto:
                  'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
              photos: [
                'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
                'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
                'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
              ],
              extraService: 'إمكانية التمويل العقاري والتقسيط',
            )),
          ));
        },
      );

      emit(GetFeaturedProductsSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetFeaturedProductsErrorState());
    }
  }

  Future<void> getMoreProducts() async {
    currentPage++;
    if (currentPage <= totalPages && isLoading == false) {
      isLoading = true;
      emit(GetMoreProductsLoadingState());
      try {
        final allProducts =
            await mainProductsUseCase.getMoreProducts(currentPage: currentPage);
        productsList.addAll(allProducts!.data!);
        currentPage = allProducts.currentPage!;
        totalPages = allProducts.lastPage!;
        isLoading = false;
        emit(GetMoreProductsSuccessState());
      } catch (e) {
        print(e.toString());
        isLoading = false;
        emit(GetMoreProductsErrorState());
      }
    }
  }

  Future<void> getAllProducts() async {
    emit(GetAllProductsLoadingState());
    try {
      // final allProducts = await mainProductsUseCase.getMainProducts();
      // productsList = allProducts!.data!;

      // currentPage = allProducts.currentPage!;
      // totalPages = allProducts.lastPage!;
      Future.delayed(
        Duration(seconds: 2),
        () {
          productsList.addAll(List.generate(
              10,
              (index) => ProductEntity(
                    title: 'منزل للبيع',
                    price: '١٬٢٥٠٬٠٠٠ جنيه',
                    phoneNumber: '٠١٠٠٩٩٨٨٧٧٦',
                    address: 'الجيزة، حدائق الأهرام، بوابة أ',
                    description:
                        'منزل دورين على مساحة ٢٥٠ متر، تشطيب سوبر لوكس، قريب من جميع الخدمات والمدارس.',
                    mainPhoto:
                        'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
                    photos: [
                      'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
                      'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
                      'https://na.rdcpix.com/885226ba3304d93c9407b3a99819a3c0w-c2405500198srd_q80.jpg',
                    ],
                    extraService: 'إمكانية التمويل العقاري والتقسيط',
                  )));
        },
      );

      emit(GetAllProductsSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetAllProductsErrorState());
    }
  }

  Future<void> sendRequest({
    required String sellerId,
    required String productId,
    required String buyerId,
  }) async {
    emit(SendRequestLoadingState());
    try {
      await requestsUseCase.sendRequest(data: {
        "user_seller_id": sellerId,
        "user_buyer_id": buyerId,
        "product_id": productId,
        "is_finished": false
      });
      print("request sent");
      emit(SendRequestSuccessState());
    } catch (e) {
      print(e.toString());
      emit(SendRequestErrorState());
    }
  }

  Future<void> getBuyerSales() async {
    try {
      emit(GetBuyerSalesLoadingState());
      final buyerSales = await buyerSalesUseCase.getBuyerSales();
      buyerSalesList = buyerSales!.sales!;
      emit(GetBuyerSalesSuccessState());
    } catch (e) {
      emit(GetBuyerSalesErrorState());
      print(e.toString());
    }
  }

  Future<void> refresh() async {
    clear();
    await getFeaturedProducts();
    await getAllProducts();
    if (ApiConstants.isLoggedIn == true) {
      await getBuyerSales();
      await getAreas();
    }
    emit(RefreshState());
  }

  void clear() {
    featuredProductsList = [];
    buyerSalesList = [];
    productsList = [];
    totalPages = 0;
    currentPage = 1;
    isLoading = false;
    areasList = [];
    emit(ClearState());
  }

  Future<void> InitBannerAd() async {
    bannerAd = BannerAd(
      adUnitId: isTest
          ? AppConstants.testAndroidUnitId
          : AppConstants.releaseAndroidUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerAdReady = true;
          emit(BannerAdInitSuccessState());
        },
        onAdFailedToLoad: (ad, error) {
          isBannerAdReady = false;
          ad.dispose();
          emit(BannerAdInitErrorState());
        },
      ),
    )..load();
  }

  void changeTabIndex(int index) {
    currentTabIndex = index;
    emit(ChangeTabIndex());
  }

  Future<void> getAreas() async {
    emit(GetAreasLoadingState());
    try {
      // final areas = await areasUseCase.getAreas();
      // areasList.addAll(areas!.areas.where(
      //   (element) => !areasList.contains(element),
      // ));
      areasList.addAll(List.generate(
          10, (index) => AreaEntity(id: 0, areaName: 'جميع المدن')));
      areasList.insert(0, AreaEntity(id: 0, areaName: 'جميع المدن'));
      emit(GetAreasSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetAreasErrorState());
    }
  }

  void showToTopBTN() {
    if (toTopVisible == false) {
      toTopVisible = true;
      emit(ShowToTopState());
    }
  }

  void hideToTopBTN() {
    if (toTopVisible == true) {
      toTopVisible = false;
      emit(HideToTopState());
    }
  }
}
