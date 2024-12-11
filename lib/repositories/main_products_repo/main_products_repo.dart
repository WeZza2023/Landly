import 'package:landly/models/domain_models/products_entity.dart';

abstract class MainProductsRepo {
  Future<ProductPageInfoEntity?> getMainProducts({int? currentPage});
}