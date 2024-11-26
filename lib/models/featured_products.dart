class FeaturedProductsModel {
  List<FeaturedProducts>? featuredProducts;

  FeaturedProductsModel({this.featuredProducts});

  FeaturedProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['featuredProducts'] != null) {
      featuredProducts = <FeaturedProducts>[];
      json['featuredProducts'].forEach((v) {
        featuredProducts!.add(new FeaturedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featuredProducts != null) {
      data['featuredProducts'] =
          this.featuredProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedProducts {
  int? id;
  int? userId;
  int? productId;
  String? startDate;
  String? endDate;
  Product? product;

  FeaturedProducts(
      {this.id,
      this.userId,
      this.productId,
      this.startDate,
      this.endDate,
      this.product});

  FeaturedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  int? userId;
  int? typeId;
  int? areaId;
  String? title;
  String? address;
  String? description;
  String? price;
  String? phoneNumber;
  String? mainPhoto;
  String? photos;
  String? extraService;

  Product(
      {this.id,
      this.userId,
      this.typeId,
      this.areaId,
      this.title,
      this.address,
      this.description,
      this.price,
      this.phoneNumber,
      this.mainPhoto,
      this.photos,
      this.extraService});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    typeId = json['type_id'];
    areaId = json['area_id'];
    title = json['title'];
    address = json['address'];
    description = json['description'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    mainPhoto = json['main_photo'];
    photos = json['photos'];
    extraService = json['extra_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type_id'] = this.typeId;
    data['area_id'] = this.areaId;
    data['title'] = this.title;
    data['address'] = this.address;
    data['description'] = this.description;
    data['price'] = this.price;
    data['phone_number'] = this.phoneNumber;
    data['main_photo'] = this.mainPhoto;
    data['photos'] = this.photos;
    data['extra_service'] = this.extraService;
    return data;
  }
}
