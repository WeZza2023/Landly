import '../../models/domain_models/areas_entity.dart';
import '../../models/dto_models/areas.dart';

abstract class AreasRepo {
  Future<AreasEntity?> getAreas();
}