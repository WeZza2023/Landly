import 'package:dio/dio.dart';
import '../../models/domain_models/products_entity.dart';
import '../../models/dto_models/featured_products.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import 'featured_products_repo.dart';

class FeaturedProductsRepoImpl implements FeaturedProductsRepo {
  @override
  Future<FeaturedProductsEntity> getFeaturedProducts() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.kFeaturedproducts,
      );
      final dto = FeaturedProductsDTO.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      if (e is DioException) {
        throw Exception(DioHelper.handleDioError(e));
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
