import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/employee_id.dart';
import '../models/holiday_status_id.dart';
import '../models/leave_line.dart';

class LeaveListResponse {
  int id;
  EmployeeID? employee_id;
  HolidayStatusId? holiday_status_id;
  String start_date;
  String end_date;
  double duration;
  String description;
  String? attachment;
  String file_name;
  String state;
  List<LeaveLine>? leave_line;
  String create_date;
  double duration_unpaid_leave;
  LeaveListResponse(
      {this.id = 0,
      this.employee_id,
      this.holiday_status_id,
      this.start_date = '',
      this.end_date = '',
      this.duration = 0.0,
      this.description = '',
      this.attachment = '',
      this.file_name = '',
      this.state = '',
      this.leave_line,
      this.create_date = '',
      this.duration_unpaid_leave = 0.0});

  LeaveListResponse copyWith(
      {int? id,
      EmployeeID? employee_id,
      HolidayStatusId? holiday_status_id,
      String? start_date,
      String? end_date,
      double? duration,
      String? description,
      String? attachment,
      String? file_name,
      String? state,
      List<LeaveLine>? leave_line,
      String? create_date,
      double? duration_unpaid_leave}) {
    return LeaveListResponse(
      id: id ?? this.id,
      employee_id: employee_id ?? this.employee_id,
      holiday_status_id: holiday_status_id ?? this.holiday_status_id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      file_name: file_name ?? this.file_name,
      state: state ?? this.state,
      leave_line: leave_line ?? this.leave_line,
      create_date: create_date ?? this.create_date,
      duration_unpaid_leave:
          duration_unpaid_leave ?? this.duration_unpaid_leave,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employee_id?.toMap(),
      'holiday_status_id': holiday_status_id?.toMap(),
      'start_date': start_date,
      'end_date': end_date,
      'duration': duration,
      'description': description,
      'attachment': attachment,
      'file_name': file_name,
      'state': state,
      'leave_line': leave_line?.map((x) => x?.toMap())?.toList(),
      'create_date': create_date,
      'duration_unpaid_leave': duration_unpaid_leave,
    };
  }

  factory LeaveListResponse.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LeaveListResponse(
      id: map['id'] ?? 0,
      employee_id: EmployeeID.fromMap(map['employee_id']),
      holiday_status_id:HolidayStatusId.fromMap(map['holiday_status_id']),
      start_date: map['start_date'] ?? "",
      end_date: map['end_date'] ?? "",
      duration: map['duration'] ?? "",
      description: map['description'] ?? "",
      attachment: map['attachment'] ?? "",
      file_name: map['file_name'] ?? "",
      state: map['state'] ?? "",
      leave_line: List<LeaveLine>.from(
          map['leave_line']?.map((x) => LeaveLine.fromMap(x))),
      duration_unpaid_leave: map['duration_unpaid_leave'],
      create_date: map['create_date'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveListResponse.fromJson(String source) =>
      LeaveListResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'LeaveListResponse(id: $id, employee_id: $employee_id,holiday_status_id: $holiday_status_id, start_date: $start_date,end_date: $end_date, duration: $duration,description: $description, attachment: $attachment,file_name: $file_name, state: $state,leave_line: $leave_line,create_date: $create_date, duration_unpaid_leave: $duration_unpaid_leave)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LeaveListResponse &&
        o.id == id &&
        o.employee_id == employee_id &&
        o.holiday_status_id == holiday_status_id &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.duration == duration &&
        o.description == description &&
        o.attachment == attachment &&
        o.file_name == file_name &&
        o.state == state &&
        o.leave_line == leave_line &&
        o.create_date == create_date &&
        o.duration_unpaid_leave == duration_unpaid_leave;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      employee_id.hashCode ^
      holiday_status_id.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      duration.hashCode ^
      description.hashCode ^
      attachment.hashCode ^
      attachment.hashCode ^
      file_name.hashCode ^
      state.hashCode ^
      leave_line.hashCode ^
      create_date.hashCode ^
      duration_unpaid_leave.hashCode;
}

// class LeaveListResponse {
//   int id;
//   EmployeeID employee_id;
//   HolidayStatusId holiday_status_id;
//   String start_date;
//   String end_date;
//   double duration;
//   String description;
//   String attachment;
//   String file_name;
//   String state;
//   List<LeaveLine> leave_line;
//   String create_date;
//   double duration_unpaid_leave;
//   LeaveListResponse({
//     this.id,
//     this.employee_id,
//     this.holiday_status_id,
//     this.start_date,
//     this.end_date,
//     this.duration,
//     this.description,
//     this.attachment,
//     this.file_name,
//     this.state,
//     this.leave_line,
//     this.create_date,
//     this.duration_unpaid_leave,
//   });
  

//   LeaveListResponse copyWith({
//     int id,
//     EmployeeID employee_id,
//     HolidayStatusId holiday_status_id,
//     String start_date,
//     String end_date,
//     double duration,
//     String description,
//     String attachment,
//     String file_name,
//     String state,
//     List<LeaveLine> leave_line,
//     String create_date,
//   }) {
//     return LeaveListResponse(
//       id: id ?? this.id,
//       employee_id: employee_id ?? this.employee_id,
//       holiday_status_id: holiday_status_id ?? this.holiday_status_id,
//       start_date: start_date ?? this.start_date,
//       end_date: end_date ?? this.end_date,
//       duration: duration ?? this.duration,
//       description: description ?? this.description,
//       attachment: attachment ?? this.attachment,
//       file_name: file_name ?? this.file_name,
//       state: state ?? this.state,
//       leave_line: leave_line ?? this.leave_line,
//       create_date: create_date ?? this.create_date,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'employee_id': employee_id?.toMap(),
//       'holiday_status_id': holiday_status_id?.toMap(),
//       'start_date': start_date,
//       'end_date': end_date,
//       'duration': duration,
//       'description': description,
//       'attachment': attachment,
//       'file_name': file_name,
//       'state': state,
//       'leave_line': leave_line?.map((x) => x?.toMap())?.toList(),
//       'create_date': create_date,
//     };
//   }

//   factory LeaveListResponse.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
  
//      return LeaveListResponse(
//       id: map['id']??0,
//       employee_id: EmployeeID.fromMap(map['employee_id'])??'',
//       holiday_status_id: HolidayStatusId.fromMap(map['holiday_status_id'])??'',
//       start_date: map['start_date']??'',
//       end_date: map['end_date']??'',
//       duration: map['duration']??'',
//       description: map['description']??'',
//       attachment: map['attachment']??'',
//       file_name: map['file_name']??'',
//       state: map['state']??'',
//       leave_line: List<LeaveLine>.from(map['leave_line']?.map((x) => LeaveLine.fromMap(x))??''),
//        create_date: map['create_date'],
//        duration_unpaid_leave: map['duration_unpaid_leave']??0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LeaveListResponse.fromJson(String source) => LeaveListResponse.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'LeaveListResponse(id: $id, employee_id: $employee_id, holiday_status_id: $holiday_status_id, start_date: $start_date, end_date: $end_date, duration: $duration, description: $description, attachment: $attachment, file_name: $file_name, state: $state, leave_line: $leave_line, create_date: $create_date)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is LeaveListResponse &&
//       o.id == id &&
//       o.employee_id == employee_id &&
//       o.holiday_status_id == holiday_status_id &&
//       o.start_date == start_date &&
//       o.end_date == end_date &&
//       o.duration == duration &&
//       o.description == description &&
//       o.attachment == attachment &&
//       o.file_name == file_name &&
//       o.state == state &&
//       listEquals(o.leave_line, leave_line) &&
//       o.create_date == create_date;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       employee_id.hashCode ^
//       holiday_status_id.hashCode ^
//       start_date.hashCode ^
//       end_date.hashCode ^
//       duration.hashCode ^
//       description.hashCode ^
//       attachment.hashCode ^
//       file_name.hashCode ^
//       state.hashCode ^
//       leave_line.hashCode ^
//       create_date.hashCode;
//   }
// }
