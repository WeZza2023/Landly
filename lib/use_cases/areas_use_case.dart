import '../models/domain_models/areas_entity.dart';
import '../repositories/areas_repo/areas_repo.dart';

class AreasUseCase {
  final AreasRepo areasRepo;

  AreasUseCase({required this.areasRepo});

  Future<AreasEntity?> getAreas() => areasRepo.getAreas();
}
