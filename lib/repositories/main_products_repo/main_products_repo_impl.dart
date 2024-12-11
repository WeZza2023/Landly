import 'package:dio/dio.dart';

import '../../models/domain_models/products_entity.dart';
import '../../models/dto_models/products.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import 'main_products_repo.dart';

class MainProductsRepoImpl implements MainProductsRepo {
  @override
  Future<ProductPageInfoEntity?> getMainProducts({int? currentPage}) async {
    try {
      final response = await DioHelper.getData(
          url: ApiConstants.kProducts,
          query: currentPage == null
              ? null
              : {
                  "page": currentPage,
                });
      final dto = ProductsDTO.fromJson(response.data);
      return dto.products?.toDomain();
    } catch (e) {
      if (e is DioException) {
        throw Exception(DioHelper.handleDioError(e));
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
