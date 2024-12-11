import '../models/domain_models/products_entity.dart';
import '../repositories/main_products_repo/main_products_repo.dart';

class MainProductsUseCase {
  final MainProductsRepo mainProductsRepo;
  MainProductsUseCase({required this.mainProductsRepo});
  Future<ProductPageInfoEntity?> getMainProducts() async {
    return mainProductsRepo.getMainProducts();
  }

  Future<ProductPageInfoEntity?> getMoreProducts({required int currentPage}) async {
    return mainProductsRepo.getMainProducts(currentPage: currentPage);
  }
}
