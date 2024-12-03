class NotificationsModel {
  List<Sale>? sale;

  NotificationsModel({this.sale});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
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
}

class Sale {
  int? id;
  int? userSellerId;
  int? userBuyerId;
  int? productId;
  int? isFinished;
  User? user;
  Product? product;

  Sale(
      {this.id,
        this.userSellerId,
        this.userBuyerId,
        this.productId,
        this.isFinished,
        this.user,
        this.product});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userSellerId = json['user_seller_id'];
    userBuyerId = json['user_buyer_id'];
    productId = json['product_id'];
    isFinished = json['is_finished'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_seller_id'] = this.userSellerId;
    data['user_buyer_id'] = this.userBuyerId;
    data['product_id'] = this.productId;
    data['is_finished'] = this.isFinished;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  Null? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.emailVerifiedAt,
        this.roleId,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
