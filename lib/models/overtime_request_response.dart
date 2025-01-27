

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_holo_date_picker/date_time_formatter.dart';

import '../models/category_id.dart';
import '../models/department.dart';
import '../models/ot_category.dart';
import '../models/overtime_request_line.dart';
import '../models/request_line.dart';
import '../models/requested_employee.dart';

class OvertimeRequestResponse {
  int id;
  String name;
  String start_date;
  String end_date;
  double duration;
  String reason;
  String state;
  String create_date;
  RequestedEmployee? requested_employee_id;
  List<Department>? department_ids;
  List<RequestLine>? request_line;
  OTCategory? categ_id;
  OvertimeRequestResponse({
    this.id = 0,
    this.name = '',
    this.start_date = '',
    this.end_date = '',
    this.duration = 0.0,
    this.reason = '',
    this.state = '',
    this.create_date = '',
    this.requested_employee_id,
    this.department_ids,
    this.request_line,
    this.categ_id
  });



  OvertimeRequestResponse copyWith({
    int? id,
    String? name,
    String? start_date,
    String? end_date,
    double? duration,
    String? reason,
    String? state,
    String? create_date,
    RequestedEmployee? requested_employee_id,
    List<Department>? department_ids,
    List<RequestLine>? request_line,
    OTCategory? categ_id,
  }) {
    return OvertimeRequestResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      duration: duration ?? this.duration,
      reason: reason ?? this.reason,
      state: state ?? this.state,
      create_date: create_date ?? this.create_date,
      requested_employee_id: requested_employee_id ?? this.requested_employee_id,
      department_ids: department_ids ?? this.department_ids,
      request_line: request_line ?? this.request_line,
      categ_id: categ_id ?? this.categ_id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start_date': start_date,
      'end_date': end_date,
      'duration': duration,
      'reason': reason,
      'state': state,
      'create_date': create_date,
      'requested_employee_id': requested_employee_id?.toMap(),
      'department_ids': department_ids?.map((x) => x?.toMap())?.toList(),
      'request_line': request_line?.map((x) => x?.toMap())?.toList(),
      'categ_id': categ_id?.toMap(),
    };
  }

  factory OvertimeRequestResponse.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return OvertimeRequestResponse(
      id: map['id'],
      name: map['name'],
      start_date: DateTime.parse(map['start_date']).add(Duration(hours: 6,minutes: 30)).toString().substring(0,DateTime.parse(map['start_date']).add(Duration(hours: 6,minutes: 30)).toString().length-4),
      end_date: DateTime.parse(map['end_date']).add(Duration(hours: 6,minutes: 30)).toString().substring(0, DateTime.parse(map['end_date']).add(Duration(hours: 6,minutes: 30)).toString().length-4),
      duration: map['duration'],
      reason: map['reason'],
      state: map['state'],
      create_date: map['create_date'],
      requested_employee_id: RequestedEmployee.fromMap(map['requested_employee_id']),
      department_ids: List<Department>.from(map['department_ids']?.map((x) => Department.fromMap(x))),
      request_line: List<RequestLine>.from(map['request_line']?.map((x) => RequestLine.fromMap(x))),
      categ_id:OTCategory.fromMap(map['categ_id'])
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeRequestResponse.fromJson(String source) => OvertimeRequestResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OvertimeRequestResponse(id: $id, name: $name, start_date: $start_date, end_date: $end_date, duration: $duration, reason: $reason, state: $state, create_date: $create_date, requested_employee_id: $requested_employee_id, department_ids: $department_ids, request_line: $request_line, categ_id: $categ_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is OvertimeRequestResponse &&
      o.id == id &&
      o.name == name &&
      o.start_date == start_date &&
      o.end_date == end_date &&
      o.duration == duration &&
      o.reason == reason &&
      o.state == state &&
      o.create_date == create_date &&
      o.requested_employee_id == requested_employee_id &&
      listEquals(o.department_ids, department_ids) &&
      listEquals(o.request_line, request_line) &&
      o.categ_id == categ_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      duration.hashCode ^
      reason.hashCode ^
      state.hashCode ^
      create_date.hashCode ^
      requested_employee_id.hashCode ^
      department_ids.hashCode ^
      request_line.hashCode ^
      categ_id.hashCode;
  }
}
