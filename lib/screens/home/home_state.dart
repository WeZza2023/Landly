import 'package:landly/models/domain_models/products_entity.dart';
import 'package:landly/models/dto_models/featured_products.dart';

import '../../models/dto_models/seller_sales.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeCarouselIndex extends HomeState {}

class LogoutLoadingState extends HomeState {}

class LogoutSuccessState extends HomeState {}

class LogoutErrorState extends HomeState {
  final String message;
  LogoutErrorState(this.message);
}

class GetFeaturedProductsLoadingState extends HomeState {}

class GetFeaturedProductsSuccessState extends HomeState {}

class GetFeaturedProductsErrorState extends HomeState {}

class GetAllProductsLoadingState extends HomeState {}

class GetAllProductsSuccessState extends HomeState {}

class GetAllProductsErrorState extends HomeState {}

class ContactRequestLoadingState extends HomeState {
  final String productId;

  ContactRequestLoadingState(this.productId);
}

class ContactRequestSuccessState extends HomeState {}

class ContactRequestErrorState extends HomeState {}

class GetSellerSalesLoadingState extends HomeState {}

class GetSellerSalesSuccessState extends HomeState {}

class GetSellerSalesErrorState extends HomeState {}

class RefreshState extends HomeState {}

class GetMoreProductsLoadingState extends HomeState {}

class GetMoreProductsSuccessState extends HomeState {}

class GetMoreProductsErrorState extends HomeState {}

class ClearState extends HomeState {}
