

import 'dart:convert';

class MaintenanceWorkshopList {
  String id;
  String name;
  MaintenanceWorkshopList({this.id = "", this.name = ''});

  MaintenanceWorkshopList copyWith({String? id, String? name}) {
    return MaintenanceWorkshopList(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'value': name};
  }

  factory MaintenanceWorkshopList.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return MaintenanceWorkshopList(
      id: map['id'] ?? "",
      name: map['value'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceWorkshopList.fromJson(String source) =>
      MaintenanceWorkshopList.fromMap(json.decode(source));

  @override
  String toString() => 'MaintenanceWorkshopList(id: $id, value: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MaintenanceWorkshopList && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
