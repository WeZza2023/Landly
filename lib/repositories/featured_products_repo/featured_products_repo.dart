import '../../models/domain_models/products_entity.dart';

abstract class FeaturedProductsRepo {
  Future<FeaturedProductsEntity> getFeaturedProducts();
}
