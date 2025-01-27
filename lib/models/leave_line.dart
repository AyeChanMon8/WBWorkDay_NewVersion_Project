import 'dart:convert';

class LeaveLine {
  String date;
  String dayofweek;
  String distinct_shift;
  bool full;
  bool first;
  bool second;
  String start_date;
  String end_date;
  int this_day_hour_id;
  int next_day_hour_id;
  int resource_calendar_id;
  bool allow_full_edit;
  bool allow_first_edit;
  bool allow_second_edit;
  String message;
  bool update_status;
  int employee_id;
  LeaveLine({
    this.date = '',
    this.dayofweek = '',
    this.distinct_shift = '',
    this.full = false,
    this.first = false,
    this.second = false,
    this.start_date = '',
    this.end_date = '',
    this.this_day_hour_id = 0,
    this.next_day_hour_id = 0,
    this.resource_calendar_id = 0,
    this.allow_full_edit = false,
    this.allow_first_edit = false,
    this.allow_second_edit = false,
    this.message = '',
    this.update_status = false,
    this.employee_id = 0,
  });

  LeaveLine copyWith(
      {String? date,
      String? dayofweek,
      String? distinct_shift,
      bool? full,
      bool? first,
      bool? second,
      String? start_date,
      String? end_date,
      int? this_day_hour_id,
      int? next_day_hour_id,
      int? resource_calendar_id,
      bool? allow_full_edit,
      bool? allow_first_edit,
      bool? allow_second_edit,
      String? message,
      bool? update_status,
      int? employee_id}) {
    return LeaveLine(
      date: date ?? this.date,
      dayofweek: dayofweek ?? this.dayofweek,
      distinct_shift: distinct_shift ?? this.distinct_shift,
      full: full ?? this.full,
      first: first ?? this.first,
      second: second ?? this.second,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      this_day_hour_id: this_day_hour_id ?? this.this_day_hour_id,
      next_day_hour_id: next_day_hour_id ?? this.next_day_hour_id,
      resource_calendar_id: resource_calendar_id ?? this.resource_calendar_id,
      allow_full_edit: allow_full_edit ?? this.allow_full_edit,
      allow_first_edit: allow_first_edit ?? this.allow_first_edit,
      allow_second_edit: allow_second_edit ?? this.allow_second_edit,
      message: message ?? this.message,
      update_status: update_status ?? this.update_status,
      employee_id: employee_id ?? this.employee_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'dayofweek': dayofweek,
      'distinct_shift': distinct_shift,
      'full': full,
      'first': first,
      'second': second,
      'start_date': start_date,
      'end_date': end_date,
      'this_day_hour_id': this_day_hour_id,
      'next_day_hour_id': next_day_hour_id,
      'resource_calendar_id': resource_calendar_id,
      'allow_full_edit': allow_full_edit,
      'allow_first_edit': allow_first_edit,
      'allow_second_edit': allow_second_edit,
      'message': message,
      'update_status': update_status,
      'employee_id': employee_id,
    };
  }

  factory LeaveLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LeaveLine(
      date: map['date'] ?? "",
      dayofweek: map['dayofweek'] ?? "",
      distinct_shift: map['distinct_shift'] ?? "",
      full: map['full'] ?? false,
      first: map['first'] ?? false,
      second: map['second'] ?? false,
      start_date: map['start_date'] ?? "",
      end_date: map['end_date'] ?? "",
      this_day_hour_id: map['this_day_hour_id'] ?? 0,
      next_day_hour_id: map['next_day_hour_id'] ?? 0,
      resource_calendar_id: map['resource_calendar_id'] ?? 0,
      allow_full_edit: map['allow_full_edit'] ?? false,
      allow_first_edit: map['allow_first_edit'] ?? false,
      allow_second_edit: map['allow_second_edit'] ?? false,
      message: map['message'] ?? "",
      update_status: map['update_status'] ?? false,
      employee_id: map['employee_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveLine.fromJson(String source) =>
      LeaveLine.fromMap(json.decode(source));

  @override
  String toString() =>
      'LeaveLine(date: $date, dayofweek: $dayofweek,distinct_shift: $distinct_shift, full: $full, first: $first,second: $second, start_date: $start_date,end_date: $end_date, this_day_hour_id: $this_day_hour_id, next_day_hour_id: $next_day_hour_id,resource_calendar_id: $resource_calendar_id, allow_full_edit: $allow_full_edit,allow_first_edit: $allow_first_edit, allow_second_edit: $allow_second_edit, message: $message,update_status: $update_status, employee_id: $employee_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LeaveLine &&
        o.date == date &&
        o.dayofweek == dayofweek &&
        o.distinct_shift == distinct_shift &&
        o.full == full &&
        o.first == first &&
        o.second == second &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.this_day_hour_id == this_day_hour_id &&
        o.next_day_hour_id == next_day_hour_id &&
        o.resource_calendar_id == resource_calendar_id &&
        o.allow_full_edit == allow_full_edit &&
        o.allow_first_edit == allow_first_edit &&
        o.allow_second_edit == allow_second_edit &&
        o.message == message &&
        o.update_status == update_status &&
        o.employee_id == employee_id;
  }

  @override
  int get hashCode =>
      date.hashCode ^
      dayofweek.hashCode ^
      distinct_shift.hashCode ^
      full.hashCode ^
      first.hashCode ^
      second.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      this_day_hour_id.hashCode ^
      next_day_hour_id.hashCode ^
      resource_calendar_id.hashCode ^
      allow_full_edit.hashCode ^
      allow_first_edit.hashCode ^
      allow_second_edit.hashCode ^
      message.hashCode ^
      update_status.hashCode ^
      employee_id.hashCode;
}


// import 'dart:convert';

// class LeaveLine {
//   String date;
//   String dayofweek;
//   String distinct_shift;
//   bool full;
//   bool first;
//   bool second;
//   String start_date;
//   String end_date;
//   int this_day_hour_id;
//   int next_day_hour_id;
//   int resource_calendar_id;
//   bool allow_full_edit;
//   bool allow_first_edit;
//   bool allow_second_edit;
//   String message;
//   bool update_status;
//   int employee_id;
//   LeaveLine({
//     this.date,
//     this.dayofweek,
//     this.distinct_shift,
//     this.full,
//     this.first,
//     this.second,
//     this.start_date,
//     this.end_date,
//     this.this_day_hour_id,
//     this.next_day_hour_id,
//     this.resource_calendar_id,
//     this.allow_full_edit,
//     this.allow_first_edit,
//     this.allow_second_edit,
//     this.message, String request_date,
//     this.update_status,
//     this.employee_id
//   });

//   LeaveLine copyWith({
//     String date,
//     String dayofweek,
//     String distinct_shift,
//     bool full,
//     bool first,
//     bool second,
//     String start_date,
//     String end_date,
//     int this_day_hour_id,
//     int next_day_hour_id,
//     int resource_calendar_id,
//     bool allow_full_edit,
//     bool allow_first_edit,
//     bool allow_second_edit,
//     String message,
//     bool update_status,
//     int employee_id
//   }) {
//     return LeaveLine(
//       date: date ?? this.date,
//       dayofweek: dayofweek ?? this.dayofweek,
//       distinct_shift: distinct_shift ?? this.distinct_shift,
//       full: full ?? this.full,
//       first: first ?? this.first,
//       second: second ?? this.second,
//       start_date: start_date ?? this.start_date,
//       end_date: end_date ?? this.end_date,
//       this_day_hour_id: this_day_hour_id ?? this.this_day_hour_id,
//       next_day_hour_id: next_day_hour_id ?? this.next_day_hour_id,
//       resource_calendar_id: resource_calendar_id ?? this.resource_calendar_id,
//       allow_full_edit: allow_full_edit ?? this.allow_full_edit,
//       allow_first_edit: allow_first_edit ?? this.allow_first_edit,
//       allow_second_edit: allow_second_edit ?? this.allow_second_edit,
//       message: message ?? this.message,
//       update_status: update_status ?? this.update_status,
//       employee_id: employee_id ?? this.employee_id
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'date': date,
//       'dayofweek': dayofweek,
//       'distinct_shift': distinct_shift,
//       'full': full,
//       'first': first,
//       'second': second,
//       'start_date': start_date,
//       'end_date': end_date,
//       'this_day_hour_id': this_day_hour_id,
//       'next_day_hour_id': next_day_hour_id,
//       'resource_calendar_id': resource_calendar_id,
//       'allow_full_edit': allow_full_edit,
//       'allow_first_edit': allow_first_edit,
//       'allow_second_edit': allow_second_edit,
//       'update_status':update_status,
//       'employee_id':employee_id
//     };
//   }

//   factory LeaveLine.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return LeaveLine(
//       date: map['date'],
//       dayofweek: map['dayofweek'],
//       distinct_shift: map['distinct_shift'],
//       full: map['full'] == null ? false : map['full'],
//       first: map['first']== null ? false : map['first'],
//       second: map['second']== null ? false : map['second'],
//       start_date: map['start_date'],
//       end_date: map['end_date'],
//       this_day_hour_id: map['this_day_hour_id'],
//       next_day_hour_id: map['next_day_hour_id'],
//       resource_calendar_id: map['resource_calendar_id'],
//       allow_full_edit: map['allow_full_edit'],
//       allow_first_edit: map['allow_first_edit'],
//       allow_second_edit: map['allow_second_edit'],
//       message: map['message'],
//       update_status: map['update_status'],
//       employee_id: map['employee_id']
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LeaveLine.fromJson(String source) =>
//       LeaveLine.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'LeaveLine(date: $date, dayofweek: $dayofweek, distinct_shift: $distinct_shift, full: $full, first: $first, second: $second, start_date: $start_date, end_date: $end_date, this_day_hour_id: $this_day_hour_id, next_day_hour_id: $next_day_hour_id, resource_calendar_id: $resource_calendar_id, allow_full_edit: $allow_full_edit, allow_first_edit: $allow_first_edit, allow_second_edit: $allow_second_edit, message: $message, update_status: $update_status, employee_id: $employee_id)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is LeaveLine &&
//         o.date == date &&
//         o.dayofweek == dayofweek &&
//         o.distinct_shift == distinct_shift &&
//         o.full == full &&
//         o.first == first &&
//         o.second == second &&
//         o.start_date == start_date &&
//         o.end_date == end_date &&
//         o.this_day_hour_id == this_day_hour_id &&
//         o.next_day_hour_id == next_day_hour_id &&
//         o.resource_calendar_id == resource_calendar_id &&
//         o.allow_full_edit == allow_full_edit &&
//         o.allow_first_edit == allow_first_edit &&
//         o.allow_second_edit == allow_second_edit &&
//         o.message == message &&
//         o.update_status == update_status &&
//         o.employee_id == employee_id;
//   }

//   @override
//   int get hashCode {
//     return date.hashCode ^
//         dayofweek.hashCode ^
//         distinct_shift.hashCode ^
//         full.hashCode ^
//         first.hashCode ^
//         second.hashCode ^
//         start_date.hashCode ^
//         end_date.hashCode ^
//         this_day_hour_id.hashCode ^
//         next_day_hour_id.hashCode ^
//         resource_calendar_id.hashCode ^
//         allow_full_edit.hashCode ^
//         allow_first_edit.hashCode ^
//         allow_second_edit.hashCode ^
//         message.hashCode ^
//         update_status.hashCode ^
//         employee_id.hashCode;
//   }
// }
