

import 'dart:convert';

import '../models/employee_id.dart';
import '../models/overtime_category.dart';

import 'ot_category.dart';

class OvertimeResponse {
  int id;
  String name;
  EmployeeID? employee_id;
  EmployeeID? requested_employee_id;
  String start_date;
  String end_date;
  double duration;
  String remark;
  String state;
  OTCategory? categ_id;
  OvertimeResponse({
    this.id = 0,
    this.name = '',
    this.employee_id,
    this.requested_employee_id,
    this.start_date = '',
    this.end_date = '',
    this.duration = 0.0,
    this.remark = '',
    this.state = '',
    this.categ_id,
  });

  OvertimeResponse copyWith({
    int? id,
    String? name,
    EmployeeID? employee_id,
    EmployeeID? requested_employee_id,
    String? start_date,
    String? end_date,
    double? duration,
    String? remark,
    String? state,
    OTCategory? categ_id, 
  }) {
    return OvertimeResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      employee_id: employee_id ?? this.employee_id,
      requested_employee_id: requested_employee_id ?? this.requested_employee_id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      duration: duration ?? this.duration,
      remark: remark ?? this.remark,
      state: state ?? this.state,
      categ_id: categ_id ?? this.categ_id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employee_id': employee_id?.toMap(),
      'requested_employee_id': requested_employee_id?.toMap(),
      'start_date': start_date,
      'end_date': end_date,
      'duration': duration,
      'remark': remark,
      'state': state,
      'categ_id': categ_id?.toMap()
    };
  }

  factory OvertimeResponse.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return OvertimeResponse(
      id: map['id'],
      name: map['name'],
      employee_id: EmployeeID.fromMap(map['employee_id']),
      requested_employee_id: EmployeeID.fromMap(map['requested_employee_id']),
      start_date: map['start_date'],
      end_date: map['end_date'],
      duration: map['duration'],
      remark: map['remark'] ?? "",
      state: map['state'],
      categ_id:OTCategory.fromMap(map['categ_id'])
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeResponse.fromJson(String source) => OvertimeResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OvertimeResponse(id: $id, name: $name, employee_id: $employee_id, requested_employee_id: $requested_employee_id, start_date: $start_date, end_date: $end_date, duration: $duration, remark: $remark, state: $state, categ_id: $categ_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is OvertimeResponse &&
      o.id == id &&
      o.name == name &&
      o.employee_id == employee_id &&
      o.requested_employee_id == requested_employee_id &&
      o.start_date == start_date &&
      o.end_date == end_date &&
      o.duration == duration &&
      o.remark == remark &&
      o.state == state &&
      o.categ_id == categ_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      employee_id.hashCode ^
      requested_employee_id.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      duration.hashCode ^
      remark.hashCode ^
      state.hashCode ^
      categ_id.hashCode;
  }
}
