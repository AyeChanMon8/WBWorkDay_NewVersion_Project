

import 'dart:convert';


class OvertimeCategory {
  final int id;
  final String name;
  OvertimeCategory({
    this.id = 0,
    this.name = '',
  });


  OvertimeCategory copyWith({
    int? id,
    String? name,
  }) {
    return OvertimeCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'name': name,
    };
  }

  factory OvertimeCategory.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OvertimeCategory(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeCategory.fromJson(String source) => OvertimeCategory.fromMap(json.decode(source));

  @override
  String toString() => 'OvertimeCategory(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OvertimeCategory &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
