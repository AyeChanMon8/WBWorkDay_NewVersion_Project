import 'dart:convert';

import 'package:flutter/material.dart';

class TravelLine {
  String date;
  String destination;
  String purpose;
  String dayofweek;
  String start_date;
  String end_date;
  bool full;
  bool first;
  bool second;
  int this_day_hour_id;
  int next_day_hour_id;
  int resource_calendar_id;
  bool allow_full_edit;
  bool allow_first_edit;
  bool allow_second_edit;
  int employee_id;
  bool update_status;
  TravelLine({
    this.date = '',
    this.destination = '',
    this.purpose = '',
    this.dayofweek = '',
    this.start_date = '',
    this.end_date = '',
    this.full = false,
    this.first = false,
    this.second = false,
    this.this_day_hour_id = 0,
    this.next_day_hour_id = 0,
    this.resource_calendar_id = 0,
    this.allow_full_edit = false,
    this.allow_first_edit = false,
    this.allow_second_edit = false,
    this.employee_id = 0,
    this.update_status = false,
  });

  TravelLine copyWith({
    String? date,
    String? destination,
    String? purpose,
    String? dayofweek,
    String? start_date,
    String? end_date,
    bool? full,
    bool? first,
    bool? second,
    int? this_day_hour_id,
    int? next_day_hour_id,
    int? resource_calendar_id,
    bool? allow_full_edit,
    bool? allow_first_edit,
    bool? allow_second_edit,
    int? employee_id,
    bool? update_status,
  }) {
    return TravelLine(
        date: date ?? this.date,
        destination: destination ?? this.destination,
        purpose: purpose ?? this.purpose,
        dayofweek: dayofweek ?? this.dayofweek,
        start_date: start_date ?? this.start_date,
        end_date: end_date ?? this.end_date,
        full: full ?? this.full,
        first: first ?? this.first,
        second: second ?? this.second,
        this_day_hour_id: this_day_hour_id ?? this.this_day_hour_id,
        next_day_hour_id: next_day_hour_id ?? this.next_day_hour_id,
        resource_calendar_id: resource_calendar_id ?? this.resource_calendar_id,
        allow_full_edit: allow_full_edit ?? this.allow_full_edit,
        allow_first_edit: allow_first_edit ?? this.allow_first_edit,
        allow_second_edit: allow_second_edit ?? this.allow_second_edit,
        employee_id: employee_id ?? this.employee_id,
        update_status: update_status ?? this.update_status);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'destination': destination,
      'purpose': purpose,
      'dayofweek': dayofweek,
      'start_date': start_date,
      'end_date': end_date,
      'full': full,
      'first': first,
      'second': second,
      'this_day_hour_id': this_day_hour_id,
      'next_day_hour_id': next_day_hour_id,
      'resource_calendar_id': resource_calendar_id,
      'allow_full_edit': allow_full_edit,
      'allow_first_edit': allow_first_edit,
      'allow_second_edit': allow_second_edit,
      'employee_id': employee_id,
      'update_status': update_status
    };
  }

  factory TravelLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelLine(
      date: map['date'] ?? "",
      destination: map['destination'] ?? "",
      purpose: map['purpose'] ?? "",
      dayofweek: map['dayofweek'] ?? "",
      start_date: map['start_date'] ?? "",
      end_date: map['end_date'] ?? "",
      full: map['full'] ?? false,
      first: map['first'] ?? false,
      second: map['second'] ?? false,
      this_day_hour_id: map['this_day_hour_id'] ?? 0,
      next_day_hour_id: map['next_day_hour_id'] ?? 0,
      resource_calendar_id: map['resource_calendar_id'] ?? 0,
      allow_full_edit: map['allow_full_edit'] ?? false,
      allow_first_edit: map['allow_first_edit'] ?? false,
      allow_second_edit: map['allow_second_edit'] ?? false,
      employee_id: map['employee_id'] ?? 0,
      update_status: map['update_status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelLine.fromJson(String source) =>
      TravelLine.fromMap(json.decode(source));

  @override
  String toString() =>
      'TravelLine(date: $date, destination: $destination,purpose: $purpose, dayofweek: $dayofweek,start_date: $start_date, end_date: $end_date,full: $full, first: $first,second: $second, this_day_hour_id: $this_day_hour_id,next_day_hour_id: $next_day_hour_id, resource_calendar_id: $resource_calendar_id,allow_full_edit: $allow_full_edit, allow_first_edit: $allow_first_edit,allow_second_edit: $allow_second_edit, employee_id: $employee_id, update_status: $update_status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelLine &&
        o.date == date &&
        o.destination == destination &&
        o.purpose == purpose &&
        o.dayofweek == dayofweek &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.full == full &&
        o.first == first &&
        o.second == second &&
        o.this_day_hour_id == this_day_hour_id &&
        o.next_day_hour_id == next_day_hour_id &&
        o.resource_calendar_id == resource_calendar_id &&
        o.allow_full_edit == allow_full_edit &&
        o.allow_first_edit == allow_first_edit &&
        o.allow_second_edit == allow_second_edit &&
        o.employee_id == employee_id &&
        o.update_status == update_status;
  }

  @override
  int get hashCode =>
      date.hashCode ^
      destination.hashCode ^
      purpose.hashCode ^
      dayofweek.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      full.hashCode ^
      first.hashCode ^
      second.hashCode ^
      this_day_hour_id.hashCode ^
      next_day_hour_id.hashCode ^
      resource_calendar_id.hashCode ^
      allow_full_edit.hashCode ^
      allow_first_edit.hashCode ^
      allow_second_edit.hashCode ^
      employee_id.hashCode ^
      update_status.hashCode;
}

// class TravelLine {
//   String date;
//   String destination;
//   String purpose;
//   String dayofweek;
//   String start_date;
//   String end_date;
//   bool full;
//   bool first;
//   bool second;
//   int this_day_hour_id;
//   int next_day_hour_id;
//   int resource_calendar_id;
//   bool allow_full_edit;
//   bool allow_first_edit;
//   bool allow_second_edit;
//   int employee_id;
//   bool update_status;
//   TravelLine(
//       {this.date,
//       this.destination,
//       this.purpose,
//       this.dayofweek,
//       this.start_date,
//       this.end_date,
//       this.full,
//       this.first,
//       this.second,
//       this.this_day_hour_id,
//       this.next_day_hour_id,
//       this.resource_calendar_id,
//       this.allow_full_edit,
//       this.allow_first_edit,
//       this.allow_second_edit,
//       this.employee_id,
//       this.update_status});

//   TravelLine copyWith(
//       {String date,
//       String destination,
//       String purpose,
//       String dayofweek,
//       String start_date,
//       String end_date,
//       bool full,
//       bool first,
//       bool second,
//       int this_day_hour_id,
//       int next_day_hour_id,
//       int resource_calendar_id,
//       bool allow_full_edit,
//       bool allow_first_edit,
//       bool allow_second_edit,
//       int employee_id,
//       bool update_status}) {
//     return TravelLine(
//         date: date ?? this.date,
//         destination: destination ?? this.destination,
//         purpose: purpose ?? this.purpose,
//         dayofweek: dayofweek ?? this.dayofweek,
//         start_date: start_date ?? this.start_date,
//         end_date: end_date ?? this.end_date,
//         full: full ?? this.full,
//         first: first ?? this.first,
//         second: second ?? this.second,
//         this_day_hour_id: this_day_hour_id ?? this.this_day_hour_id,
//         next_day_hour_id: next_day_hour_id ?? this.next_day_hour_id,
//         resource_calendar_id: resource_calendar_id ?? this.resource_calendar_id,
//         allow_full_edit: allow_full_edit ?? this.allow_full_edit,
//         allow_first_edit: allow_first_edit ?? this.allow_first_edit,
//         allow_second_edit: allow_second_edit ?? this.allow_second_edit,
//         employee_id: employee_id ?? this.employee_id,
//         update_status: update_status ?? this.update_status);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'date': date,
//       'destination': destination,
//       'purpose': purpose,
//       'dayofweek': dayofweek,
//       'start_date': start_date,
//       'end_date': end_date,
//       'full': full,
//       'first': first,
//       'second': second,
//       'this_day_hour_id': this_day_hour_id,
//       'next_day_hour_id': next_day_hour_id,
//       'resource_calendar_id': resource_calendar_id,
//       'allow_full_edit': allow_full_edit,
//       'allow_first_edit': allow_first_edit,
//       'allow_second_edit': allow_second_edit,
//       'employee_id': employee_id,
//       'update_status': update_status
//     };
//   }

//   factory TravelLine.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return TravelLine(
//         date: map['date'] ?? '',
//         destination: map['destination'] ?? '',
//         purpose: map['purpose'] ?? '',
//         dayofweek: map['dayofweek'] ?? '',
//         start_date: map['start_date'] ?? '',
//         end_date: map['end_date'] ?? '',
//         full: map['full'] ?? false,
//         first: map['first'] ?? false,
//         second: map['second'] ?? false,
//         this_day_hour_id: map['this_day_hour_id'] ?? 0,
//         next_day_hour_id: map['next_day_hour_id'] ?? 0,
//         resource_calendar_id: map['resource_calendar_id'] ?? 0,
//         allow_full_edit: map['allow_full_edit'] ?? false,
//         allow_first_edit: map['allow_first_edit'] ?? false,
//         allow_second_edit: map['allow_second_edit'] ?? false,
//         employee_id: map['employee_id'] ?? 0,
//         update_status: map['update_status'] ?? false);
//   }

//   String toJson() => json.encode(toMap());

//   factory TravelLine.fromJson(String source) =>
//       TravelLine.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TravelLine(date: $date, destination: $destination, purpose: $purpose, dayofweek: $dayofweek, start_date: $start_date, end_date: $end_date, full: $full, first: $first, second: $second, this_day_hour_id: $this_day_hour_id, next_day_hour_id: $next_day_hour_id, resource_calendar_id: $resource_calendar_id, allow_full_edit: $allow_full_edit, allow_first_edit: $allow_first_edit, allow_second_edit: $allow_second_edit,employee_id: $employee_id,update_status: $update_status)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is TravelLine &&
//         o.date == date &&
//         o.destination == destination &&
//         o.purpose == purpose &&
//         o.dayofweek == dayofweek &&
//         o.start_date == start_date &&
//         o.end_date == end_date &&
//         o.full == full &&
//         o.first == first &&
//         o.second == second &&
//         o.this_day_hour_id == this_day_hour_id &&
//         o.next_day_hour_id == next_day_hour_id &&
//         o.resource_calendar_id == resource_calendar_id &&
//         o.allow_full_edit == allow_full_edit &&
//         o.allow_first_edit == allow_first_edit &&
//         o.allow_second_edit == allow_second_edit &&
//         o.employee_id == employee_id &&
//         o.update_status == update_status;
//   }

//   @override
//   int get hashCode {
//     return date.hashCode ^
//         destination.hashCode ^
//         purpose.hashCode ^
//         dayofweek.hashCode ^
//         start_date.hashCode ^
//         end_date.hashCode ^
//         full.hashCode ^
//         first.hashCode ^
//         second.hashCode ^
//         this_day_hour_id.hashCode ^
//         next_day_hour_id.hashCode ^
//         resource_calendar_id.hashCode ^
//         allow_full_edit.hashCode ^
//         allow_first_edit.hashCode ^
//         allow_second_edit.hashCode ^
//         employee_id.hashCode ^
//         update_status.hashCode;
//   }
// }
