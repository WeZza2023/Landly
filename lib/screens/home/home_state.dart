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

class SendRequestLoadingState extends HomeState {}

class SendRequestSuccessState extends HomeState {}

class SendRequestErrorState extends HomeState {}

class GetBuyerSalesLoadingState extends HomeState {}

class GetBuyerSalesSuccessState extends HomeState {}

class GetBuyerSalesErrorState extends HomeState {}

class RefreshState extends HomeState {}

class GetMoreProductsLoadingState extends HomeState {}

class GetMoreProductsSuccessState extends HomeState {}

class GetMoreProductsErrorState extends HomeState {}

class ClearState extends HomeState {}

class BannerAdInitSuccessState extends HomeState {}

class BannerAdInitErrorState extends HomeState {}

class BannerAdInitDisposeState extends HomeState {}

class ChangeTabIndex extends HomeState {}

class GetAreasLoadingState extends HomeState {}

class GetAreasSuccessState extends HomeState {}

class GetAreasErrorState extends HomeState {}

class ShowToTopState extends HomeState{}

class HideToTopState extends HomeState{}