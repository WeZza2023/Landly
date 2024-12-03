class AreasModel {
  List<Area>? areas;

  AreasModel({this.areas});

  AreasModel.fromJson(Map<String, dynamic> json) {
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
}
