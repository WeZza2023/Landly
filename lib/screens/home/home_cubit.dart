import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landly/network/api_constants.dart';
import 'package:landly/repositories/buyer_sales_repo/buyer_sales_repo_impl.dart';
import 'package:landly/screens/home/home_state.dart';
import 'package:landly/use_cases/auth_use_case.dart';
import 'package:landly/use_cases/featured_use_case.dart';
import 'package:landly/use_cases/main_products_use_case.dart';
import 'package:landly/use_cases/seller_sales_use_case.dart';
import 'package:landly/utils/constants.dart';
import '../../models/domain_models/products_entity.dart';
import '../../models/domain_models/seller_sales_entity.dart';
import '../../repositories/auth_repo/auth_repo_impl.dart';
import '../../repositories/featured_products_repo/featured_products_repo_impl.dart';
import '../../repositories/main_products_repo/main_products_repo_impl.dart';
import '../../repositories/requests_repo/requests_repo_impl.dart';
import '../../use_cases/requests_use_case.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int currentCarouselIndex = 0;
  // ProductsDTO? productsModel;

  MainProductsUseCase mainProductsUseCase =
      MainProductsUseCase(mainProductsRepo: MainProductsRepoImpl());
  AuthUseCase authUseCase = AuthUseCase(authRepo: AuthRepoImpl());
  FeaturedUseCase? featuredUseCase =
      FeaturedUseCase(featuredProductsRepo: FeaturedProductsRepoImpl());
  BuyerSalesUseCase buyerSalesUseCase =
      BuyerSalesUseCase(buyerSalesRepo: BuyerSalesRepoImpl());
  RequestsUseCase requestsUseCase =
      RequestsUseCase(requestsRepo: RequestsRepoImpl());
  int currentPage = 1;
  int totalPages = 0;
  List<ProductEntity> productsList = [];
  List<FeaturedProductEntity>? featuredProductsList = [];
  List<SellerSaleEntity>? buyerSalesList = [];
  bool isLoading = false;

  void changeCarouselIndex(int index) {
    currentCarouselIndex = index;
    emit(ChangeCarouselIndex());
  }

  Future<void> logoutUser() async {
    emit(LogoutLoadingState());
    try {
      await authUseCase.logoutUser();
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
      final fProducts = await featuredUseCase!.getFeaturedProducts();
      featuredProductsList = fProducts.featuredProducts;
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
      final allProducts = await mainProductsUseCase.getMainProducts();
      productsList = allProducts!.data!;
      currentPage = allProducts.currentPage!;
      totalPages = allProducts.lastPage!;
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
    if (ApiConstants.kToken != AppConstants.userToken) {
      await getBuyerSales();
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
    emit(ClearState());
  }
}
