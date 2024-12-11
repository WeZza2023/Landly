import '../domain_models/areas_entity.dart';

class AreasDTO {
  List<Area>? areas;

  AreasDTO({this.areas});

  AreasDTO.fromJson(Map<String, dynamic> json) {
    if (json['areas'] != null) {
      areas = <Area>[];
      json['areas'].forEach((v) {
        areas!.add(new Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  AreasEntity toDomain() {
    return AreasEntity(areas: areas!.map((e) => e.toDomain()).toList());
  }
}

class Area {
  int? id;
  String? areaName;

  Area({this.id, this.areaName});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaName = json['area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area_name'] = this.areaName;
    return data;
  }

  AreaEntity toDomain() {
    return AreaEntity(id: id!, areaName: areaName!);
  }
}
