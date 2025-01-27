

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/category_id.dart';
import '../models/department.dart';
import '../models/employee_promotion.dart';
import '../models/overtime_request_line.dart';

import 'ot_department.dart';

class OvertimeRequest {
  String name;
  String start_date;
  String end_date;
  double duration;
  String reason;
  int requested_employee_id;
  List<OTDepartment>? department_ids;
  List<OvertimeRequestLine>? request_line;
  List<Branch_id>? branch_ids;
  int categ_id;
  OvertimeRequest({
    this.name = '',
    this.start_date = '',
    this.end_date = '',
    this.duration = 0.0,
    this.reason = '',
    this.requested_employee_id = 0,
    this.department_ids,
    this.request_line,
    this.categ_id = 0,
    this.branch_ids
  });

  OvertimeRequest copyWith({
    String? name,
    String? start_date,
    String? end_date,
    double? duration,
    String? reason,
    int? requested_employee_id,
    List<OTDepartment>? department_ids,
    List<OvertimeRequestLine>? request_line,
    int? categ_id,
    List<Branch_id>? branch_ids
  }) {
    return OvertimeRequest(
      name: name ?? this.name,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      duration: duration ?? this.duration,
      reason: reason ?? this.reason,
      requested_employee_id:
          requested_employee_id ?? this.requested_employee_id,
      department_ids: department_ids ?? this.department_ids,
      request_line: request_line ?? this.request_line,
      categ_id: categ_id ?? this.categ_id,
      branch_ids: branch_ids ?? this.branch_ids
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'start_date': start_date,
      'end_date': end_date,
      'duration': duration,
      'reason': reason,
      'requested_employee_id': requested_employee_id,
      'department_ids': department_ids?.map((x) => x?.toMap())?.toList(),
      'request_line': request_line?.map((x) => x?.toMap())?.toList(),
      'categ_id': categ_id,
      'branch_ids': branch_ids?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory OvertimeRequest.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OvertimeRequest(
      name: map['name'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      duration: map['duration'],
      reason: map['reason'],
      requested_employee_id: map['requested_employee_id'],
      department_ids: List<OTDepartment>.from(
          map['department_ids']?.map((x) => OTDepartment.fromMap(x))),
      request_line: List<OvertimeRequestLine>.from(
          map['request_line']?.map((x) => OvertimeRequestLine.fromMap(x))),
      categ_id: map['categ_id'],
      branch_ids: List<Branch_id>.from(
          map['branch_ids']?.map((x) => Branch_id.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeRequest.fromJson(String source) =>
      OvertimeRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OvertimeRequest(name: $name, start_date: $start_date, end_date: $end_date, duration: $duration, reason: $reason, requested_employee_id: $requested_employee_id, department_ids: $department_ids, request_line: $request_line, categ_id: $categ_id, branch_ids: $branch_ids)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OvertimeRequest &&
        o.name == name &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.duration == duration &&
        o.reason == reason &&
        o.requested_employee_id == requested_employee_id &&
        listEquals(o.department_ids, department_ids) &&
        listEquals(o.request_line, request_line) &&
        o.categ_id == categ_id &&
        listEquals(o.branch_ids, branch_ids);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        start_date.hashCode ^
        end_date.hashCode ^
        duration.hashCode ^
        reason.hashCode ^
        requested_employee_id.hashCode ^
        department_ids.hashCode ^
        request_line.hashCode ^
        categ_id.hashCode ^
        branch_ids.hashCode;
  }
}

class Branch_id {
  int id;
  String name;
  Branch_id({
    this.id = 0,
    this.name = '',
  });


  Branch_id copyWith({
    int? id,
    String? name,
  }) {
    return Branch_id(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id
    };
  }

  factory Branch_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Branch_id(
      id: map['id'],
      name: map['name']
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch_id.fromJson(String source) => Branch_id.fromMap(json.decode(source));

  @override
  String toString() => 'Branch_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Branch_id &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}