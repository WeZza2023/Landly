import 'package:dio/dio.dart';

import '../../models/domain_models/seller_sales_entity.dart';
import '../../models/dto_models/seller_sales.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import 'buyer_sales_repo.dart';

class BuyerSalesRepoImpl implements BuyerSalesRepo {
  @override
  Future<BuyerSalesEntity?> getBuyerSales() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.kBuyerSaleUser,
        token: ApiConstants.kToken,
      );
      final dto = BuyerSalesDTO.fromJson(response.data);
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
