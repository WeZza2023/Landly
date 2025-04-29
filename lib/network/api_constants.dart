import 'package:landly/utils/constants.dart';

import '../shared_prefs/cache_helper.dart';

class ApiConstants {
  // static const kBaseUrl = 'https://realestate.ahmedmattar.tech/api';
  static const kBaseUrl = 'https://680f9ea467c5abddd1960629.mockapi.io/api';
  static const kUrl = '';

  static const kAuthorizationHeader = "authorization";

  static String? kToken;
  static String? kUserId;
  static bool isLoggedIn = (kToken != null && kUserId != null) ? true : false;

  static const String _kAuth = "/auth";
  static const String kRegister = "$_kAuth/register";
  static const String kLogin = "$_kAuth/login";
  static const String kLogout = "$_kAuth/logout";
  static const String kForgetPasswordSetPhone = "$_kAuth/password/forget";
  static const String kForgetPasswordSetPass = "$_kAuth/password/reset";
  static const String kGetUser = "$_kAuth/user";
  static const String kUpdateImge = "$_kAuth/update-logo";
  static String kEditProfile = "$kGetUser/update/{$kUserId}";
  static const String kSetFcm = "$kGetUser/set-fcm-token";

  static const String kHome = "/home";
  static const String kSearch = "$kHome/search";

  static const String kSale = "/sale";
  static const String kSales = "/sales";

  static String kBuyerSaleUser = "/buyersaleuser/${kUserId}";
  static String kSellerSaleUser = "/sellersaleuser/${kUserId}";

  static const String kProduct = "/product";
  static const String kProducts = "/products";
  static const String kProductId = "product_id";
  static const String kProductDetails = "$kProducts/{$kProductId}/show";
  static const String kCategories = "/categories";
  static const String kFeaturedproducts = "/featuredproducts";

  static const String kCart = "/cart";
  static const String kAddToCart = "$kCart/item";
  static const String kCartItemId = "cart_item_id";
  static const String kDeleteItem = "$kCart/items/{$kCartItemId}";
  static const String kApplyCoupon = "/coupon/apply";
  static const String kSetAddressInCart = "$kCart/set-address";

  static const String kOrderId = "/order_id";
  static const String kOrders = "/orders";
  static const String kOrderDetails = "/$kOrders/{$kOrderId}";

  static const String kReservations = "/reservations/customer";
  static const String kCreateReservations = "/reservations/customer";
  static const String kGetReservationAppointments =
      "$kCenterDetails/reservation-appointments";

  static const String kCenterId = "center_id";
  static const String kCenters = "/centers";
  static const String kCenterDetails = "$kCenters/{$kCenterId}";
  static const String kBuyPulses = "$kCenters/buy-pulses";
  static const String kBuyOffer = "/offers/buy";

  static const String _kLocations = "/locations";
  static const String kAreas = "/areas";
  static const String kTypes = "/types";
  static const String kGovId = "gov_id";
  static const String kCities = "$_kLocations/{$kGovId}";
  static const String kAddressId = "address_id";
  static const String kUpdateAddress = "/addresses/{$kAddressId}";

  static const String kNotifications = '/notifications';
  static const String kMarkAsRead = '$kNotifications/mark-as-read';
  static const String kPushNotification = "$kNotifications/status";
}
