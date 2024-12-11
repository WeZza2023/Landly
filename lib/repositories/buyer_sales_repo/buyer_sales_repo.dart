import '../../models/domain_models/seller_sales_entity.dart';

abstract class BuyerSalesRepo {
  Future<BuyerSalesEntity?> getBuyerSales();
}