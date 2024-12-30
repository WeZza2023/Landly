import 'package:landly/models/domain_models/products_entity.dart';

abstract class MainProductsRepo {
  Future<ProductPageInfoEntity?> getMainProducts({int? currentPage});

  Future<void> addNewProduct(
      {required Map<String, dynamic> json,
      required Function(int, int)? onSendProgress});
}
