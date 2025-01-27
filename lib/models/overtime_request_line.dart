

import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/employee.dart';

import 'overtime_request.dart';

class OvertimeRequestLine {
  String start_date;
  String end_date;
  int employee_id;
  String emp_name;
  String email;
  String state;
  int dept_id;
  double duration;
  int branch_id;
  OvertimeRequestLine({
    this.start_date = '',
    this.end_date = '',
    this.employee_id = 0,
    this.emp_name = '',
    this.email = '',
    this.state = '',
    this.dept_id = 0,
    this.duration = 0.0,
    this.branch_id = 0
  });


  OvertimeRequestLine copyWith({
    String? start_date,
    String? end_date,
    int? employee_id,
    String? emp_name,
    String? email,
    String ?state,
    int? dept_id,
    double? duration,
    int? branch_id
  }) {
    return OvertimeRequestLine(
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      employee_id: employee_id ?? this.employee_id,
      emp_name: emp_name ?? this.emp_name,
      email: email ?? this.email,
      state: state ?? this.state,
      dept_id: dept_id ?? this.dept_id,
      duration: duration ?? this.duration,
      branch_id: branch_id ?? this.branch_id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id,
      'duration': duration,
      'start_date': start_date,
      'end_date': end_date,
      'email': email,
      'state': state,
      'branch_id': branch_id,
    };
  }

  factory OvertimeRequestLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OvertimeRequestLine(
      start_date: map['start_date'],
      end_date: map['end_date'],
      employee_id: map['employee_id'],
      emp_name: map['emp_name'],
      email: map['email'],
      state: map['state'],
      dept_id: map['dept_id'],
      duration: map['duration'],
      branch_id: map['branch_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeRequestLine.fromJson(String source) => OvertimeRequestLine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OvertimeRequestLine(start_date: $start_date, end_date: $end_date, employee_id: $employee_id, emp_name: $emp_name, email: $email, state: $state, dept_id: $dept_id, duration: $duration,branch_id: $branch_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OvertimeRequestLine &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.employee_id == employee_id &&
        o.emp_name == emp_name &&
        o.email == email &&
        o.state == state &&
        o.dept_id == dept_id &&
        o.duration == duration &&
        o.branch_id == branch_id;
  }

  @override
  int get hashCode {
    return start_date.hashCode ^
    end_date.hashCode ^
    employee_id.hashCode ^
    emp_name.hashCode ^
    email.hashCode ^
    state.hashCode ^
    dept_id.hashCode ^
    duration.hashCode ^
    branch_id.hashCode;
  }
}
