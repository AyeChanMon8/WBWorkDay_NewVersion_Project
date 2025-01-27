

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/company.dart';
import '../models/department.dart';
import '../models/employee_id.dart';
import '../models/partner.dart';

import 'job.dart';

class EmployeeSlip {
  final int id;
  String name;
  final Job job_id;
  final Department department_id;
  EmployeeSlip({
    this.id = 0,
    this.name = '',
    required this.job_id,
    required this.department_id,
  });

  EmployeeSlip copyWith({
    int? id,
    String? name,
    Job? job_id,
    Department? department_id,
  }) {
    return EmployeeSlip(
      id: id ?? this.id,
      name: name ?? this.name,
      job_id: job_id ?? this.job_id,
      department_id: department_id ?? this.department_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'job_id': job_id?.toMap(),
      'department_id': department_id?.toMap(),
    };
  }

  factory EmployeeSlip.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return EmployeeSlip(
      id: map['id'],
      name: map['name'],
      job_id: Job.fromMap(map['job_id']),
      department_id: Department.fromMap(map['department_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeSlip.fromJson(String source) =>
      EmployeeSlip.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmployeeSlip(id: $id, name: $name, job_id: $job_id, department_id: $department_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EmployeeSlip &&
        o.id == id &&
        o.name == name &&
        o.job_id == job_id &&
        o.department_id == department_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        job_id.hashCode ^
        department_id.hashCode;
  }
}
