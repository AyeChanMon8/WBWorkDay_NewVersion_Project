import 'dart:convert';

class CategoryEmployeeID {
  int id;
  String name;
  CategoryEmployeeID({
    this.id = 0,
    this.name = '',
  });

  CategoryEmployeeID copyWith({
    int? id,
    String? name,
  }) {
    return CategoryEmployeeID(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryEmployeeID.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return CategoryEmployeeID(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryEmployeeID.fromJson(String source) =>
      CategoryEmployeeID.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryEmployeeID(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoryEmployeeID && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
