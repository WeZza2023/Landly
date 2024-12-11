import 'auth_entity.dart';

class NotificationsEntity {
  List<NotificationSaleEntity>? sales;

  NotificationsEntity({this.sales});
}

class NotificationSaleEntity {
  final int id;
  final int userSellerId;
  final int userBuyerId;
  final int productId;
  final int isFinished;
  final UserEntity user;
  final NotificationProductEntity product;

  NotificationSaleEntity({
    required this.id,
    required this.userSellerId,
    required this.userBuyerId,
    required this.productId,
    required this.isFinished,
    required this.user,
    required this.product,
  });
}

class NotificationProductEntity {
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
  final String? photos;
  final String? extraService;

  NotificationProductEntity({
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
