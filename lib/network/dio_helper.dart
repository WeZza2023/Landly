import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:landly/network/api_constants.dart';

class DioHelper {
  static late Dio dioMain;

  static init() {
    dioMain = Dio(BaseOptions(
      baseUrl: ApiConstants.kBaseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dioMain.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Access_control_allow_origin': '*',
    };
    return await dioMain.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
    ProgressCallback? onSendProgress,
  }) async {
    dioMain.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Access_control_allow_origin': '*',
    };
    return dioMain.post(url,
        queryParameters: query, data: data, onSendProgress: onSendProgress);
  }

  static Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dioMain.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Access_control_allow_origin': '*',
    };
    return dioMain.put(url, queryParameters: query, data: data);
  }

  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dioMain.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Access_control_allow_origin': '*',
    };
    return dioMain.patch(url, queryParameters: query);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dioMain.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Access_control_allow_origin': '*',
    };
    return dioMain.delete(url, queryParameters: query);
  }

  static String handleDioError(DioException e) {

    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        return e.response!.data['message'];
      } else if (e.response!.statusCode == 500) {
        return "Something went wrong. Please try again later.";
      } else {
        return "Unknown error. Please try again later.";
      }
    }
    return "Connection error. Please check your internet connection.";
  }
}
