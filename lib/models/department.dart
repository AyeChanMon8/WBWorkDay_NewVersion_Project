// import 'dart:convert';

// import 'package:winbrother_hr_app/models/employee_id.dart';

// class Department {
//   final int id;
//   final String name;
//   String complete_name;
//   List<EmployeeID> employee_ids;
//   Department({
//     this.id,
//     this.name,
//     this.complete_name,
//   });

//   Department copyWith({
//     int id,
//     String name,
//   }) {
//     return Department(
//       id: id ?? this.id,
//       name: name ?? this.name,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       // 'name': name,
//     };
//   }

//   factory Department.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Department(
//         id: map['id'], name: map['name'], complete_name: map['complete_name']);
//   }

//   String toJson() => json.encode(toMap());

//   factory Department.fromJson(String source) =>
//       Department.fromMap(json.decode(source));

//   @override
//   String toString() => 'Department(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Department && o.id == id && o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'employee_id.dart';

class Department {
  final int id;
  final String name;
   final String? complete_name;
  final List<EmployeeID>? employee_ids;
  Department({
    this.id = 0,
    this.name = '',
     this.complete_name,
     this.employee_ids,
  });

  Department copyWith({
    int? id,
    String? name,
    String? complete_name,
    List<EmployeeID>? employee_ids,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
       complete_name: complete_name ?? this.complete_name,
       employee_ids: employee_ids ?? this.employee_ids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
       'complete_name': complete_name,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Department(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
       complete_name: map['complete_name'] ?? '',
       employee_ids: map['employee_ids'] == null
          ? null
          : List<EmployeeID>.from(
              map['employee_ids']?.map((x) => EmployeeID.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Department.fromJson(String source) =>
      Department.fromMap(json.decode(source));

  @override
  String toString() =>
      'Department(id: $id, name: $name,complete_name: $complete_name)'; // complete_name: $complete_name

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Department && o.id == id && o.name == name &&listEquals(o.employee_ids, employee_ids); // &&listEquals(o.employee_ids, employee_ids);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode^employee_ids.hashCode;
}
