import 'package:landly/models/domain_models/seller_sales_entity.dart';

class BuyerSalesDTO {
  List<Sale>? sale;

  BuyerSalesDTO({this.sale});

  BuyerSalesDTO.fromJson(Map<String, dynamic> json) {
    if (json['sale'] != null) {
      sale = <Sale>[];
      json['sale'].forEach((v) {
        sale!.add(new Sale.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sale != null) {
      data['sale'] = this.sale!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  BuyerSalesEntity toDomain() {
    return BuyerSalesEntity(
      sales: sale?.map((e) => e.toDomain()).toList(),
    );
  }
}

class Sale {
  int? id;
  int? userSellerId;
  int? userBuyerId;
  int? productId;
  int? isFinished;

  Sale(
      {this.id,
      this.userSellerId,
      this.userBuyerId,
      this.productId,
      this.isFinished});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userSellerId = json['user_seller_id'];
    userBuyerId = json['user_buyer_id'];
    productId = json['product_id'];
    isFinished = json['is_finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_seller_id'] = this.userSellerId;
    data['user_buyer_id'] = this.userBuyerId;
    data['product_id'] = this.productId;
    data['is_finished'] = this.isFinished;
    return data;
  }

  SellerSaleEntity toDomain() {
    return SellerSaleEntity(
      id: id,
      userSellerId: userSellerId,
      userBuyerId: userBuyerId,
      productId: productId,
      isFinished: isFinished,
    );
  }
}
