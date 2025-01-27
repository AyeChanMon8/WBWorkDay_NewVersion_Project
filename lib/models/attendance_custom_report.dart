import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/attendance.dart';

class AttendanceCustomReport {
  final String date;
  List<Attendance> attendance_list;
  AttendanceCustomReport({
    this.date = '',
    required this.attendance_list,
  });

  AttendanceCustomReport copyWith({
    String? date,
    required List<Attendance> attendance_list,
  }) {
    return AttendanceCustomReport(
      date: date ?? this.date,
      attendance_list: attendance_list ?? this.attendance_list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'attendance_list': attendance_list?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory AttendanceCustomReport.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return AttendanceCustomReport(
      date: map['date'] ?? '',
      attendance_list: List<Attendance>.from(
          map['attendance_list']?.map((x) => Attendance.fromMap(x)) ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceCustomReport.fromJson(String source) =>
      AttendanceCustomReport.fromMap(json.decode(source));

  @override
  String toString() =>
      'AttendanceCustomReport(date: $date, attendance_list: $attendance_list)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AttendanceCustomReport &&
        o.date == date &&
        listEquals(o.attendance_list, attendance_list);
  }

  @override
  int get hashCode => date.hashCode ^ attendance_list.hashCode;
}
