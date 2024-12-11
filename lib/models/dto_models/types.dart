import 'package:landly/models/domain_models/types_entity.dart';

class TypesDTO {
  List<Types>? types;

  TypesDTO({this.types});

  TypesDTO.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TypesEntity toDomain() {
    return TypesEntity(types: types!.map((e) => e.toDomain()).toList());
  }
}

class Types {
  int? id;
  String? typeName;

  Types({this.id, this.typeName});

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    return data;
  }

  TypeEntity toDomain() {
    return TypeEntity(id: id!, typeName: typeName!);
  }
}
