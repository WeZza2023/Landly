import '../models/domain_models/types_entity.dart';
import '../repositories/types_repo/types_repo.dart';

class TypesUseCase {
  final TypesRepo typesRepo;

  TypesUseCase({required this.typesRepo});

  Future<TypesEntity?> getTypes() {
    return typesRepo.getTypes();
  }
}
