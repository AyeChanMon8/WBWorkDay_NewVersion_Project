

import 'dart:convert';

class MaintenanceTeamList {
  int id;
  String name;
  int partnerId;
  String partnerName;
  MaintenanceTeamList({this.id = 0, this.name = '',this.partnerId = 0, this.partnerName = ''});

  MaintenanceTeamList copyWith({int? id, String? name, int? partnerId, String? partnerName}) {
    return MaintenanceTeamList(
      id: id ?? this.id,
      name: name ?? this.name,
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'partner_id': partnerId, 'partner_name': partnerName};
  }

  factory MaintenanceTeamList.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return MaintenanceTeamList(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      partnerId: map['partner_id'] ?? 0,
      partnerName: map['partner_name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceTeamList.fromJson(String source) =>
      MaintenanceTeamList.fromMap(json.decode(source));

  @override
  String toString() => 'MaintenanceTeamList(id: $id, name: $name, partnerId: $partnerId, partnerName: $partnerName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MaintenanceTeamList && o.id == id && o.name == name && o.partnerId == partnerId && o.partnerName == partnerName;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ partnerId.hashCode ^ partnerName.hashCode;
}