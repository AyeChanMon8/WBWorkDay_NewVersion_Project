
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/employee_id.dart';

class EmployeeCategory {
   int id;
   String name;
   List<EmployeeID>? employee_ids;
  EmployeeCategory({
    this.id = 0,
    this.name = '',
    this.employee_ids,
  });

  EmployeeCategory copyWith({
    int? id,
    String? name,
    List<EmployeeID>? employee_ids,
  }) {
    return EmployeeCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      employee_ids: employee_ids ?? this.employee_ids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employee_ids': employee_ids?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory EmployeeCategory.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return EmployeeCategory(
      id: map['id'],
      name: map['name'],
      employee_ids: List<EmployeeID>.from(map['employee_ids']?.map((x) => EmployeeID.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeCategory.fromJson(String source) => EmployeeCategory.fromMap(json.decode(source));

  @override
  String toString() => 'EmployeeCategory(id: $id, name: $name, employee_ids: $employee_ids)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is EmployeeCategory &&
      o.id == id &&
      o.name == name &&
      listEquals(o.employee_ids, employee_ids);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ employee_ids.hashCode;
}
