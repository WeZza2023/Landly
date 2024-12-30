import 'package:dio/dio.dart';
import 'package:landly/repositories/requests_repo/requests_repo.dart';

import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';

class RequestsRepoImpl implements RequestsRepo {
  @override
  Future<void> sendRequest({required Map<String, dynamic> data}) async {
    try {
      await DioHelper.postData(
          url: ApiConstants.kSale, token: ApiConstants.kToken, data: data);
    } catch (e) {
      if (e is DioException) {
        throw Exception(DioHelper.handleDioError(e));
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
