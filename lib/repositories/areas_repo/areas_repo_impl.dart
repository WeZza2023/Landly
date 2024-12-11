import 'package:dio/dio.dart';
import 'package:landly/models/domain_models/areas_entity.dart';

import '../../models/dto_models/areas.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';
import 'areas_repo.dart';

class AreasRepoImpl implements AreasRepo {
  @override
  Future<AreasEntity?> getAreas() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.kAreas,
        token: ApiConstants.kToken,
      );
      final dto = AreasDTO.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      if (e is DioException) {
        throw Exception(DioHelper.handleDioError(e));
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
