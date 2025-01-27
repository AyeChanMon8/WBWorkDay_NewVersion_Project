import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/travel_expense.dart';
import '../models/travel_line.dart';

class TravelRequest {
  int employee_id;
  String start_date;
  String end_date;
  String city_from;
  String city_to;
  double duration;
  List<TravelLine>? travel_line;
  List<TravelExpense>? request_allowance_lines;
  TravelRequest(
      {this.employee_id = 0,
      this.start_date = '',
      this.end_date = '',
      this.city_from = '',
      this.city_to = '',
      this.duration = 0.0,
      this.travel_line,
      this.request_allowance_lines});

  TravelRequest copyWith({
    int? employee_id,
    String? start_date,
    String? end_date,
    String? city_from,
    String? city_to,
    double? duration,
    List<TravelLine>? travel_line,
    List<TravelExpense>? request_allowance_lines,
  }) {
    return TravelRequest(
      employee_id: employee_id ?? this.employee_id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      city_from: city_from ?? this.city_from,
      city_to: city_to ?? this.city_to,
      duration: duration ?? this.duration,
      travel_line: travel_line ?? this.travel_line,
      request_allowance_lines:
          request_allowance_lines ?? this.request_allowance_lines,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id,
      'start_date': start_date,
      'end_date': end_date,
      'city_from': city_from,
      'city_to': city_to,
      'duration': duration,
      'travel_line': travel_line?.map((x) => x?.toMap())?.toList(),
      'request_allowance_lines': request_allowance_lines?.map((x) => x?.toMap())?.toList(),
      // 'name': name,
    };
  }

  factory TravelRequest.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelRequest(
      employee_id: map['employee_id'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      city_from: map['city_from'],
      city_to: map['city_to'],
      duration: map['duration'],
      travel_line: List<TravelLine>.from(
          map['travel_line']?.map((x) => TravelLine.fromMap(x))),
      request_allowance_lines: List<TravelExpense>.from(
          map['request_allowance_lines']?.map((x) => TravelExpense.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelRequest.fromJson(String source) =>
      TravelRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'TravelRequest(employee_id: $employee_id, start_date: $start_date,end_date: $end_date, city_from: $city_from,city_to: $city_to,duration: $duration, travel_line: $travel_line,request_allowance_lines: $request_allowance_lines)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelRequest &&
        o.employee_id == employee_id &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.city_from == city_from &&
        o.city_to == city_to &&
        o.duration == duration &&
        o.travel_line == travel_line &&
        o.request_allowance_lines == request_allowance_lines;
  }

  @override
  int get hashCode =>
      employee_id.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      city_from.hashCode ^
      city_to.hashCode ^
      duration.hashCode ^
      travel_line.hashCode ^
      request_allowance_lines.hashCode;
}

// class TravelRequest {
//   int employee_id;
//   String start_date;
//   String end_date;
//   String city_from;
//   String city_to;
//   double duration;
//   List<TravelLine> travel_line;
//   List<TravelExpense> request_allowance_lines;
//   TravelRequest({
//     this.employee_id,
//     this.start_date,
//     this.end_date,
//     this.city_from,
//     this.city_to,
//     this.duration,
//     this.travel_line,
//     this.request_allowance_lines,
//   });

//   TravelRequest copyWith({
//     int employee_id,
//     String start_date,
//     String end_date,
//     String city_from,
//     String city_to,
//     double duration,
//     List<TravelLine> travel_line,
//     List<TravelExpense> request_allowance_lines,
//   }) {
//     return TravelRequest(
//       employee_id: employee_id ?? this.employee_id,
//       start_date: start_date ?? this.start_date,
//       end_date: end_date ?? this.end_date,
//       city_from: city_from ?? this.city_from,
//       city_to: city_to ?? this.city_to,
//       duration: duration ?? this.duration,
//       travel_line: travel_line ?? this.travel_line,
//       request_allowance_lines:
//           request_allowance_lines ?? this.request_allowance_lines,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'employee_id': employee_id,
//       'start_date': start_date,
//       'end_date': end_date,
//       'city_from': city_from,
//       'city_to': city_to,
//       'duration': duration,
//       'travel_line': travel_line?.map((x) => x?.toMap())?.toList(),
//       'request_allowance_lines':
//           request_allowance_lines?.map((x) => x?.toMap())?.toList(),
//     };
//   }

//   factory TravelRequest.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return TravelRequest(
//       employee_id: map['employee_id'],
//       start_date: map['start_date'],
//       end_date: map['end_date'],
//       city_from: map['city_from'],
//       city_to: map['city_to'],
//       duration: map['duration'],
//       travel_line: List<TravelLine>.from(
//           map['travel_line']?.map((x) => TravelLine.fromMap(x))),
//       request_allowance_lines: List<TravelExpense>.from(
//           map['request_allowance_lines']?.map((x) => TravelExpense.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TravelRequest.fromJson(String source) =>
//       TravelRequest.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TravelRequest(employee_id: $employee_id, start_date: $start_date, end_date: $end_date, city_from: $city_from, city_to: $city_to, duration: $duration, travel_line: $travel_line, request_allowance_lines: $request_allowance_lines)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is TravelRequest &&
//         o.employee_id == employee_id &&
//         o.start_date == start_date &&
//         o.end_date == end_date &&
//         o.city_from == city_from &&
//         o.city_to == city_to &&
//         o.duration == duration &&
//         listEquals(o.travel_line, travel_line) &&
//         listEquals(o.request_allowance_lines, request_allowance_lines);
//   }

//   @override
//   int get hashCode {
//     return employee_id.hashCode ^
//         start_date.hashCode ^
//         end_date.hashCode ^
//         city_from.hashCode ^
//         city_to.hashCode ^
//         duration.hashCode ^
//         travel_line.hashCode ^
//         request_allowance_lines.hashCode;
//   }
// }
