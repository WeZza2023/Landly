import '../models/domain_models/products_entity.dart';
import '../repositories/featured_products_repo/featured_products_repo.dart';

class FeaturedUseCase {
  final FeaturedProductsRepo featuredProductsRepo;
  FeaturedUseCase({required this.featuredProductsRepo});
  Future<FeaturedProductsEntity> getFeaturedProducts() async {
    return featuredProductsRepo.getFeaturedProducts();
  }
}
