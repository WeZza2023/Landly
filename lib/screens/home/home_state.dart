import 'package:landly/models/dto_models/featured_products.dart';

import '../../models/dto_models/buyer_sales.dart';


abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeCarouselIndex extends HomeState {}

class LogoutLoadingState extends HomeState {}

class LogoutSuccessState extends HomeState {
  final String message;
  LogoutSuccessState(this.message);
}

class LogoutErrorState extends HomeState {
  final String message;
  LogoutErrorState(this.message);
}

class GetFeaturedProductsLoadingState extends HomeState {}

class GetFeaturedProductsSuccessState extends HomeState {
  final FeaturedProductsModel featuredProductsModel;
  GetFeaturedProductsSuccessState(this.featuredProductsModel);
}

class GetFeaturedProductsErrorState extends HomeState {}

class GetAllProductsLoadingState extends HomeState{}

class GetAllProductsSuccessState extends HomeState{}

class GetAllProductsErrorState extends HomeState{}

class ContactRequestLoadingState extends HomeState{

  final String productId;

  ContactRequestLoadingState(this.productId);
}

class ContactRequestSuccessState extends HomeState{}

class ContactRequestErrorState extends HomeState{}

class GetBuyerSalesLoadingState extends HomeState{}

class GetBuyerSalesSuccessState extends HomeState{
  final BuyerSalesModel buyerSalesModel;
  GetBuyerSalesSuccessState(this.buyerSalesModel);
}

class GetBuyerSalesErrorState extends HomeState{}

class RefreshState extends HomeState{}

class GetMoreProductsLoadingState extends HomeState{}

class GetMoreProductsSuccessState extends HomeState{}

class GetMoreProductsErrorState extends HomeState{}

class ClearState extends HomeState{}