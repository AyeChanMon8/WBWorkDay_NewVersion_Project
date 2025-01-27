

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/warning_employee.dart';

class Warning {
  int id;
  List<WarningEmployee>? employee_id;
  String date;
  String description;
  double mark;
  Warning({
    this.id = 0,
    this.employee_id,
    this.date = '',
    this.description = '',
    this.mark = 0.0
  });


  Warning copyWith({
    int? id,
  List<WarningEmployee>? employee_id,
  String? date,
  String? description,
  double? mark,
  }) {
    return Warning(
      id: id ?? this.id,
      employee_id: employee_id ?? this.employee_id,
      date: date ?? this.date,
      description: description ?? this.description,
      mark: mark ?? this.mark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employee_id?.map((x) => x?.toMap())?.toList(),
      'date': date,
      'description': description,
      'mark': mark,
      // 'name': name,
    };
  }

  factory Warning.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Warning(
      id: map['id'],
      employee_id: List<WarningEmployee>.from(
          map['employee_id']?.map((x) => WarningEmployee.fromMap(x))),
      date: map['date'],
      description: map['description'],
      mark: map['mark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Warning.fromJson(String source) => Warning.fromMap(json.decode(source));

  @override
  String toString() => 'Warning(id: $id, employee_id: $employee_id, date: $date,description: $description, mark: $mark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Warning &&
      o.id == id &&
      o.employee_id == employee_id &&
      o.date == date &&
      o.description == description &&
      o.mark == mark;
  }

  @override
  int get hashCode => id.hashCode ^ employee_id.hashCode ^ date.hashCode ^ description.hashCode ^ mark.hashCode;
}

// class Warning {
//   int id;
//   List<WarningEmployee> employee_id;
//   String date;
//   String description;
//   double mark;
//   Warning({
//     this.id,
//     this.employee_id,
//     this.date,
//     this.description,
//     this.mark,
//   });

//   Warning copyWith({
//     int id,
//     List<WarningEmployee> employee_id,
//     String date,
//     String description,
//     double mark,
//   }) {
//     return Warning(
//       id: id ?? this.id,
//       employee_id: employee_id ?? this.employee_id,
//       date: date ?? this.date,
//       description: description ?? this.description,
//       mark: mark ?? this.mark,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'employee_id': employee_id?.map((x) => x?.toMap())?.toList(),
//       'date': date,
//       'description': description,
//       'mark': mark,
//     };
//   }

//   factory Warning.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Warning(
//       id: map['id'],
//       employee_id: List<WarningEmployee>.from(
//           map['employee_id']?.map((x) => WarningEmployee.fromMap(x))),
//       date: map['date'],
//       description: map['description'],
//       mark: map['mark'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Warning.fromJson(String source) =>
//       Warning.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Warning(id: $id, employee_id: $employee_id, date: $date, description: $description, mark: $mark)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Warning &&
//         o.id == id &&
//         listEquals(o.employee_id, employee_id) &&
//         o.date == date &&
//         o.description == description &&
//         o.mark == mark;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         employee_id.hashCode ^
//         date.hashCode ^
//         description.hashCode ^
//         mark.hashCode;
//   }
// }
