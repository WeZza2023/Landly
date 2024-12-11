class FeaturedProductsEntity {
  final List<FeaturedProductEntity>? featuredProducts;

  FeaturedProductsEntity({
    this.featuredProducts,
  });
}

class FeaturedProductEntity {
  final int? id;
  final int? userId;
  final int? productId;
  final String? startDate;
  final String? endDate;
  final ProductEntity? product;

  FeaturedProductEntity({
    this.id,
    this.userId,
    this.productId,
    this.startDate,
    this.endDate,
    this.product,
  });
}

class ProductsEntity {
  final List<ProductEntity>? products;

  ProductsEntity({
    this.products,
  });
}

class ProductPageInfoEntity {
  final int? currentPage;
  final List<ProductEntity>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<LinksEntity>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  ProductPageInfoEntity({
    this.currentPage,
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
    this.total,
  });
}

class ProductEntity {
  final int? id;
  final int? userId;
  final int? typeId;
  final int? areaId;
  final String? title;
  final String? address;
  final String? description;
  final String? price;
  final String? phoneNumber;
  final String? mainPhoto;
  final List<String>? photos;
  final String? extraService;

  ProductEntity({
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
}

class LinksEntity {
  final String? url;
  final String? label;
  final bool? active;

  LinksEntity({
    this.url,
    this.label,
    this.active,
  });
}
