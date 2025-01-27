// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// import 'package:winbrother_hr_app/models/employee_id.dart';

// class DepartmentEmpIds {
//   final int id;
//   final String name;
//   List<EmployeeID> employee_ids;
//   DepartmentEmpIds({
//     this.id,
//     this.name,
//     this.employee_ids,
//   });

//   DepartmentEmpIds copyWith({
//     int id,
//     String name,
//     List<EmployeeID> employee_ids,
//   }) {
//     return DepartmentEmpIds(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       employee_ids: employee_ids ?? this.employee_ids,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'employee_ids': employee_ids?.map((x) => x?.toMap())?.toList(),
//     };
//   }

//   factory DepartmentEmpIds.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return DepartmentEmpIds(
//       id: map['id'] ?? 0,
//       name: map['name'] ?? '',
//       employee_ids: List<EmployeeID>.from(
//           map['employee_ids']?.map((x) => EmployeeID.fromMap(x)) ?? ''),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DepartmentEmpIds.fromJson(String source) =>
//       DepartmentEmpIds.fromMap(json.decode(source));

//   @override
//   String toString() =>
//       'DepartmentEmpIds(id: $id, name: $name, employee_ids: $employee_ids)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is DepartmentEmpIds &&
//         o.id == id &&
//         o.name == name &&
//         listEquals(o.employee_ids, employee_ids);
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ employee_ids.hashCode;
// }

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'employee_id.dart';

class DepartmentEmpIds {

  final int id;
  final String name;
  List<EmployeeID> employee_ids;
  DepartmentEmpIds({
    this.id = 0,
    this.name = '',
    required this.employee_ids,
  });

  DepartmentEmpIds copyWith({
    int? id,
    String? name,
    required List<EmployeeID> employee_ids,
  }) {
    return DepartmentEmpIds(
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

  factory DepartmentEmpIds.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DepartmentEmpIds(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      employee_ids: List<EmployeeID>.from(
          map['employee_ids']?.map((x) => EmployeeID.fromMap(x)) ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory DepartmentEmpIds.fromJson(String source) =>
      DepartmentEmpIds.fromMap(json.decode(source));

  @override
  String toString() =>
      'DepartmentEmpIds(id: $id, name: $name, employee_ids: $employee_ids)';

  
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DepartmentEmpIds &&
        o.id == id &&
        o.name == name &&
        listEquals(o.employee_ids, employee_ids);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ employee_ids.hashCode;
}
