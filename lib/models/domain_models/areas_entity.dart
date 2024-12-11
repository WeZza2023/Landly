class AreasEntity {
  final List<AreaEntity> areas;

  AreasEntity({required this.areas});
}

class AreaEntity {
  final int id;
  final String areaName;

  AreaEntity({required this.id, required this.areaName});
}
