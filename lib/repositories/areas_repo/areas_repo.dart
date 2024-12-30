import '../../models/domain_models/areas_entity.dart';

abstract class AreasRepo {
  Future<AreasEntity?> getAreas();
}