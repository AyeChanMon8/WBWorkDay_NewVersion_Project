import 'dart:convert';

class EmployeeModel {
  int id;
  String name;
  EmployeeModel({
    this.id = 0,
    this.name = '',
  });

  EmployeeModel copyWith({
    int? id,
    String? name,
  }) {
    return EmployeeModel(
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

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return EmployeeModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source));

  @override
  String toString() => 'EmployeeModel(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EmployeeModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
