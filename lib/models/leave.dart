

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/leave_line.dart';

class Leave {
  int? employee_id;
  int? holiday_status_id;
  String? start_date;
  String? end_date;
  double? duration;
  String? description;
  String? attachment;
  List<LeaveLine>? leave_line;
  Leave({
    this.employee_id,
    this.holiday_status_id,
    this.start_date,
    this.end_date,
    this.duration,
    this.description,
    this.attachment,
    this.leave_line,
  });

  Leave copyWith({
    int? employee_id,
  int? holiday_status_id,
  String? start_date,
  String? end_date,
  double? duration,
  String? description,
  String? attachment,
  List<LeaveLine>? leave_line,
  }) {
    return Leave(
      employee_id: employee_id ?? this.employee_id,
      holiday_status_id: holiday_status_id ?? this.holiday_status_id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      leave_line: leave_line ?? this.leave_line,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id,
      'holiday_status_id': holiday_status_id,
      'start_date': start_date,
      'end_date': end_date,
      'duration': duration,
      'description': description,
      'attachment': attachment,
      'leave_line': leave_line?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Leave.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Leave(
      employee_id: map['employee_id'],
      holiday_status_id: map['holiday_status_id'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      duration: map['duration'],
      description: map['description'],
      attachment: map['attachment'],
      leave_line: List<LeaveLine>.from(
          map['leave_line']?.map((x) => LeaveLine.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Leave.fromJson(String source) =>
      Leave.fromMap(json.decode(source));

  @override
  String toString() => 'Leave(employee_id: $employee_id,holiday_status_id: $holiday_status_id,start_date: $start_date,end_date: $end_date,duration: $duration,description: $description,attachment: $attachment,leave_line: $leave_line)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Leave && o.employee_id == employee_id && o.holiday_status_id == holiday_status_id 
    && o.start_date == start_date && o.end_date == end_date && o.duration == duration
    && o.description == description && o.attachment == attachment && listEquals(o.leave_line, leave_line);
  }

  @override
  int get hashCode => employee_id.hashCode ^ holiday_status_id.hashCode ^ start_date.hashCode
  ^ end_date.hashCode ^ duration.hashCode ^ description.hashCode
  ^ attachment.hashCode ^ leave_line.hashCode;
}

// class Leave {
//   int employee_id;
//   int holiday_status_id;
//   String start_date;
//   String end_date;
//   double duration;
//   String description;
//   String attachment;
//   List<LeaveLine> leave_line;
//   Leave({
//     this.employee_id,
//     this.holiday_status_id,
//     this.start_date,
//     this.end_date,
//     this.duration,
//     this.description,
//     this.attachment,
//     this.leave_line,
//   });

//   Leave copyWith({
//     int employee_id,
//     int holiday_status_id,
//     String start_date,
//     String end_date,
//     double duration,
//     String description,
//     String attachment,
//     List<LeaveLine> leave_line,
//   }) {
//     return Leave(
//       employee_id: employee_id ?? this.employee_id,
//       holiday_status_id: holiday_status_id ?? this.holiday_status_id,
//       start_date: start_date ?? this.start_date,
//       end_date: end_date ?? this.end_date,
//       duration: duration ?? this.duration,
//       description: description ?? this.description,
//       attachment: attachment ?? this.attachment,
//       leave_line: leave_line ?? this.leave_line,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'employee_id': employee_id,
//       'holiday_status_id': holiday_status_id,
//       'start_date': start_date,
//       'end_date': end_date,
//       'duration': duration,
//       'description': description,
//       'attachment': attachment,
//       'leave_line': leave_line?.map((x) => x?.toMap())?.toList(),
//     };
//   }

//   factory Leave.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return Leave(
//       employee_id: map['employee_id'],
//       holiday_status_id: map['holiday_status_id'],
//       start_date: map['start_date'],
//       end_date: map['end_date'],
//       duration: map['duration'],
//       description: map['description'],
//       attachment: map['attachment'],
//       leave_line: List<LeaveLine>.from(map['leave_line']?.map((x) => LeaveLine.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Leave.fromJson(String source) => Leave.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Leave(employee_id: $employee_id, holiday_status_id: $holiday_status_id, start_date: $start_date, end_date: $end_date, duration: $duration, description: $description, attachment: $attachment, leave_line: $leave_line)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is Leave &&
//       o.employee_id == employee_id &&
//       o.holiday_status_id == holiday_status_id &&
//       o.start_date == start_date &&
//       o.end_date == end_date &&
//       o.duration == duration &&
//       o.description == description &&
//       o.attachment == attachment &&
//       listEquals(o.leave_line, leave_line);
//   }

//   @override
//   int get hashCode {
//     return employee_id.hashCode ^
//       holiday_status_id.hashCode ^
//       start_date.hashCode ^
//       end_date.hashCode ^
//       duration.hashCode ^
//       description.hashCode ^
//       attachment.hashCode ^
//       leave_line.hashCode;
//   }
// }
