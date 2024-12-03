import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/models/dto_models/featured_products.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/screens/home/home_state.dart';
import 'package:landly/utils/constants.dart';
import 'package:logger/logger.dart';
import '../../models/dto_models/buyer_sales.dart';
import '../../models/dto_models/products.dart';
import '../../network/dio_helper.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int currentCarouselIndex = 0;
  FeaturedProductsModel? featuredProductsModel;
  ProductsModel? productsModel;
  BuyerSalesModel? buyerSalesModel;
  int currentPage = 1;
  int totalPages = 0;
  List<Data> productsList = [];
  List<Product> featuredProductsList = [];
  bool isLoading = false;

  void changeCarouselIndex(int index) {
    currentCarouselIndex = index;
    emit(ChangeCarouselIndex());
  }

  Future<void> logoutUser() async {
    emit(LogoutLoadingState());
    try {
      await DioHelper.postData(
              url: ApiConstants.kLogout, token: ApiConstants.kToken)
          .then(
        (value) async {
          String message = value.data['message'];
          clear();
          emit(LogoutSuccessState(message));
        },
      ).catchError((e) {
        print(e.toString());
        emit(LogoutErrorState(e.toString()));
      });
    } catch (e) {
      print(e.toString());
      emit(LogoutErrorState(e.toString()));
    }
  }

  Future<void> getFeaturedProducts() async {
    emit(GetFeaturedProductsLoadingState());
    try {
      await DioHelper.getData(
        url: ApiConstants.kFeaturedproducts,
      ).then(
        (value) {
          // print(value.data);
          featuredProductsModel = FeaturedProductsModel.fromJson(value.data);
          featuredProductsList.addAll(featuredProductsModel!.featuredProducts
              ?.map((e) => e.product)
              .where((e) => e != null).cast<Product>().toList() ?? []);
          emit(GetFeaturedProductsSuccessState(featuredProductsModel!));
        },
      ).catchError((e) {
        print(e.toString());
        emit(GetFeaturedProductsErrorState());
      });
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
        await DioHelper.getData(url: ApiConstants.kProducts, query: {
          "page": currentPage,
        }).then(
          (value) {
            Logger().d(value.data);
            productsModel = ProductsModel.fromJson(value.data);
            productsList.addAll(productsModel!.products!.data!);
            currentPage = productsModel!.products!.currentPage!;
            totalPages = productsModel!.products!.lastPage!;
            isLoading = false;
            emit(GetMoreProductsSuccessState());
          },
        ).catchError((e) {
          print(e.toString());
          isLoading = false;
          emit(GetMoreProductsErrorState());
        });
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
      DioHelper.getData(
        url: ApiConstants.kProducts,
      ).then(
        (value) {
          Logger().d(value.data);
          productsModel = ProductsModel.fromJson(value.data);
          productsList.addAll(productsModel!.products!.data!);
          currentPage = productsModel!.products!.currentPage!;
          totalPages = productsModel!.products!.lastPage!;
          emit(GetAllProductsSuccessState());
        },
      ).catchError((e) {
        print(e.toString());
        emit(GetAllProductsErrorState());
      });
    } catch (e) {
      print(e.toString());
      emit(GetAllProductsErrorState());
    }
  }

  Future<void> contactRequest({
    required String sellerId,
    required String productId,
    required String buyerId,
  }) async {
    emit(ContactRequestLoadingState(productId));
    try {
      DioHelper.postData(
          url: ApiConstants.kSale,
          token: ApiConstants.kToken,
          data: {
            "user_seller_id": sellerId,
            "user_buyer_id": buyerId,
            "product_id": productId,
            "is_finished": false
          }).then((value) {
        print(value.data);
        getBuyerSales();
        emit(ContactRequestSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(ContactRequestErrorState());
      });
    } catch (e) {
      print(e.toString());
      emit(ContactRequestErrorState());
    }
  }

  Future<void> getBuyerSales() async {
    try {
      emit(GetBuyerSalesLoadingState());
      DioHelper.getData(
              url: ApiConstants.kBuyerSaleUser, token: ApiConstants.kToken)
          .then((value) {
        print(value.data);
        buyerSalesModel = BuyerSalesModel.fromJson(value.data);
        emit(GetBuyerSalesSuccessState(buyerSalesModel!));
      }).catchError((e) {
        print(e.toString());
        emit(GetBuyerSalesErrorState());
      });
    } catch (e) {
      print(e.toString());
      emit(GetBuyerSalesErrorState());
    }
  }

  Future<void> refresh() async {
    clear();
    getFeaturedProducts();
    getAllProducts();
    if (ApiConstants.kToken != AppConstants.userToken) {
      getBuyerSales();
    }
    emit(RefreshState());
  }

  void clear() {
    featuredProductsModel = null;
    productsModel = null;
    buyerSalesModel = null;
    productsList = [];
    totalPages = 0;
    currentPage = 1;
    isLoading = false;
    emit(ClearState());
  }
}
