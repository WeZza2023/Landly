import '../models/domain_models/seller_sales_entity.dart';
import '../repositories/buyer_sales_repo/buyer_sales_repo.dart';

class BuyerSalesUseCase {
  final BuyerSalesRepo buyerSalesRepo;

  BuyerSalesUseCase({required this.buyerSalesRepo});
  Future<BuyerSalesEntity?> getBuyerSales() async {
    return buyerSalesRepo.getBuyerSales();
  }
}
