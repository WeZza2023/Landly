import 'package:landly/models/domain_models/products_entity.dart';

class ProductsDTO {
  Products? products;

  ProductsDTO({this.products});

  ProductsDTO.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }

  ProductsEntity toDomain() {
    return ProductsEntity(
        products: products?.data!.map((e) => e.toDomain()).toList());
  }
}

class Products {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Products(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }

  ProductPageInfoEntity toDomain() {
    return ProductPageInfoEntity(
        data: data?.map((e) => e.toDomain()).toList(),
        currentPage: currentPage,
        firstPageUrl: firstPageUrl,
        from: from,
        lastPage: lastPage,
        lastPageUrl: lastPageUrl,
        links: links?.map((e) => e.toDomain()).toList(),
        nextPageUrl: nextPageUrl,
        path: path,
        perPage: perPage,
        prevPageUrl: prevPageUrl,
        to: to,
        total: total);
  }
}

class Data {
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
  List<String>? photos; // Updated to a list
  String? extraService;

  Data({
    this.id,
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
    this.extraService,
  });

  Data.fromJson(Map<String, dynamic> json) {
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

    // Convert 'photos' string to a list if it's comma-separated
    if (json['photos'] != null) {
      photos = json['photos'].toString().split(',');
    }

    extraService = json['extra_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

    // Join the list of photos back into a single string
    if (data['photos'] != "" || data['photos'] != null) {
      photos = data['photos']
          .toString()
          .split(',')
          .where((e) => e.isNotEmpty)
          .toList();
    } else if (data['photos'] == null || data['photos'] == "") {
      photos = null;
    }

    data['extra_service'] = this.extraService;
    return data;
  }

  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      userId: userId,
      typeId: typeId,
      areaId: areaId,
      title: title,
      address: address,
      description: description,
      price: price,
      phoneNumber: phoneNumber,
      mainPhoto: mainPhoto,
      photos: photos,
      extraService: extraService,
    );
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }

  LinksEntity toDomain() {
    return LinksEntity(
      url: url,
      label: label,
      active: active,
    );
  }
}
