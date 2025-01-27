import 'dart:convert';

import 'employee_id.dart';

class Attendance {
  bool approved;
  String check_in;
  String check_out;
  double early_out_minutes;
  EmployeeID employee_id;
  int id;
  double late_minutes;
  double ot_hour;
  double worked_hours;
  bool check;
  String state;
  bool is_absent;
  bool missed;
  bool no_worked_day;
  bool travel;
  bool plan_trip;
  bool day_trip;
  bool leave;
  Attendance(
      {this.approved = false,
      this.check_in = '',
      this.check_out = '',
      this.early_out_minutes = 0.0,
      required this.employee_id,
      this.id = 0,
      this.late_minutes = 0.0,
      this.ot_hour = 0.0,
      this.worked_hours = 0.0,
      this.check = false,
      this.state = '',
      this.is_absent = false,
      this.missed = false,
      this.no_worked_day = false,
      this.travel = false,
      this.plan_trip = false,
      this.day_trip = false,
      this.leave = false});

  Attendance copyWith({
    bool? approved,
    String? check_in,
    String? check_out,
    double? early_out_minutes,
    required EmployeeID employee_id,
    int? id,
    double? late_minutes,
    double? ot_hour,
    double? worked_hours,
    bool? check,
    String? state,
    bool? is_absent,
    bool? missed,
    bool? no_worked_day,
    bool? travel,
    bool? plan_trip,
    bool? day_trip,
  }) {
    return Attendance(
      approved: approved ?? this.approved,
      check_in: check_in ?? this.check_in,
      check_out: check_out ?? this.check_out,
      early_out_minutes: early_out_minutes ?? this.early_out_minutes,
      employee_id: employee_id ?? this.employee_id,
      id: id ?? this.id,
      late_minutes: late_minutes ?? this.late_minutes,
      ot_hour: ot_hour ?? this.ot_hour,
      worked_hours: worked_hours ?? this.worked_hours,
      check: check ?? this.check,
      state: state ?? this.state,
      is_absent: is_absent ?? this.is_absent,
      missed: missed ?? this.missed,
      no_worked_day: no_worked_day ?? this.no_worked_day,
      travel: travel ?? this.travel,
      plan_trip: plan_trip ?? this.plan_trip,
      day_trip: day_trip ?? this.day_trip,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'approved': approved,
      'check_in': check_in,
      'check_out': check_out,
      'early_out_minutes': early_out_minutes,
      'employee_id': employee_id?.toMap(),
      'id': id,
      'late_minutes': late_minutes,
      'ot_hour': ot_hour,
      'worked_hours': worked_hours,
      'check': check,
      'state': state,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Attendance(
      approved: map['approved'] ?? false,
      check_in: map['check_in'] ?? '',
      check_out: map['check_out'] ?? '',
      early_out_minutes: map['early_out_minutes'] ?? 0.0,
      employee_id: EmployeeID.fromMap(map['employee_id']),
      id: map['id'] ?? 0,
      late_minutes: map['late_minutes'] ?? 0.0,
      ot_hour: map['ot_hour'] ?? 0.0,
      worked_hours: map['worked_hours'] ?? 0.0,
      check: map['check'] ?? false,
      state: map['state'] ?? '',
      is_absent: map['is_absent'] ?? false,
      missed: map['missed'] ?? false,
      no_worked_day: map['no_worked_day'] ?? false,
      travel: map['travel'] ?? false,
      plan_trip: map['plan_trip'] ?? false,
      day_trip: map['day_trip'] ?? false,
      leave: map['leave'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attendance(approved: $approved, check_in: $check_in, check_out: $check_out, early_out_minutes: $early_out_minutes, employee_id: $employee_id, id: $id, late_minutes: $late_minutes, ot_hour: $ot_hour, worked_hours: $worked_hours, check: $check, state: $state)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Attendance &&
        o.approved == approved &&
        o.check_in == check_in &&
        o.check_out == check_out &&
        o.early_out_minutes == early_out_minutes &&
        o.employee_id == employee_id &&
        o.id == id &&
        o.late_minutes == late_minutes &&
        o.ot_hour == ot_hour &&
        o.worked_hours == worked_hours &&
        o.check == check &&
        o.state == state;
  }

  @override
  int get hashCode {
    return approved.hashCode ^
        check_in.hashCode ^
        check_out.hashCode ^
        early_out_minutes.hashCode ^
        employee_id.hashCode ^
        id.hashCode ^
        late_minutes.hashCode ^
        ot_hour.hashCode ^
        worked_hours.hashCode ^
        check.hashCode ^
        state.hashCode;
  }
}
