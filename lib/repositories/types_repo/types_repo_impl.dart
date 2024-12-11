import 'package:dio/dio.dart';
import 'package:landly/repositories/types_repo/types_repo.dart';

import '../../models/domain_models/types_entity.dart';
import '../../models/dto_models/types.dart';
import '../../network/api_constants.dart';
import '../../network/dio_helper.dart';

class TypesRepoImpl implements TypesRepo {
  @override
  Future<TypesEntity?> getTypes() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.kTypes,
        token: ApiConstants.kToken,
      );
      final dto = TypesDTO.fromJson(response.data);
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
