import 'package:landly/models/domain_models/types_entity.dart';

abstract class TypesRepo {
  Future<TypesEntity?> getTypes();
}
