class TypesEntity {
  final List<TypeEntity> types;

  TypesEntity({required this.types});
}

class TypeEntity {
  final int id;
  final String typeName;

  TypeEntity({required this.id, required this.typeName});
}
