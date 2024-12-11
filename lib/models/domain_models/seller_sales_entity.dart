class BuyerSalesEntity {
  List<SellerSaleEntity>? sales;

  BuyerSalesEntity({this.sales});
}

class SellerSaleEntity {
  int? id;
  int? userSellerId;
  int? userBuyerId;
  int? productId;
  int? isFinished;

  SellerSaleEntity(
      {this.id,
      this.userSellerId,
      this.userBuyerId,
      this.productId,
      this.isFinished});
}
