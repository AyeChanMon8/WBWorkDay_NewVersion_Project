import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/employee_id.dart';
import '../models/travel_expense.dart';
import '../models/travel_expense/list/travel_expense_approve_model.dart';
import '../models/travel_expense_response.dart';
import '../models/travel_line.dart';

class TravelRequestListResponse {
  dynamic id;
  EmployeeID? employee_id;
  String start_date;
  String end_date;
  String city_from;
  String city_to;
  double duration;
  List<TravelLine>? travel_line;
  List<TravelExpenseResponse>? request_allowance_lines;
  String state;
  double payment_amount;
  String create_date;
  String name;
  TravelExpenseApproveModel? travel_type_id;
  TravelRequestListResponse(
      {this.id = null,
      this.employee_id,
      this.start_date = '',
      this.end_date = '',
      this.city_from = '',
      this.city_to = '',
      this.duration = 0.0,
      this.travel_line,
      this.request_allowance_lines,
      this.state = '',
      this.payment_amount = 0.0,
      this.create_date = '',
      this.name = '',
      this.travel_type_id});

  TravelRequestListResponse copyWith({
    dynamic? id,
    EmployeeID? employee_id,
    String? start_date,
    String? end_date,
    String? city_from,
    String? city_to,
    double? duration,
    List<TravelLine>? travel_line,
    List<TravelExpenseResponse>? request_allowance_lines,
    String? state,
    double? payment_amount,
    String? create_date,
    String? name,
    TravelExpenseApproveModel? travel_type_id,
  }) {
    return TravelRequestListResponse(
        id: id ?? this.id,
        employee_id: employee_id ?? this.employee_id,
        start_date: start_date ?? this.start_date,
        end_date: end_date ?? this.end_date,
        city_from: city_from ?? this.city_from,
        city_to: city_to ?? this.city_to,
        duration: duration ?? this.duration,
        travel_line: travel_line ?? this.travel_line,
        request_allowance_lines: request_allowance_lines ?? this.request_allowance_lines,
        state: state ?? this.state,
        payment_amount: payment_amount ?? this.payment_amount,
        create_date: create_date ?? this.create_date,
        name: name ?? this.name,
        travel_type_id: travel_type_id ?? this.travel_type_id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employee_id?.toMap(),
      'start_date': start_date,
      'end_date': end_date,
      'city_from': city_from,
      'city_to': city_to,
      'duration': duration,
      'travel_line': travel_line?.map((x) => x?.toMap())?.toList(),
      'request_allowance_lines': request_allowance_lines?.map((x) => x?.toMap())?.toList(),
      'state': state,
      'payment_amount': payment_amount,
      'create_date': create_date,
      'name': name,
      'travel_type_id': travel_type_id?.toMap(),
    };
  }

  factory TravelRequestListResponse.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelRequestListResponse(
      id: map['id'],
      employee_id: EmployeeID.fromMap(map['employee_id']),
      start_date: map['start_date'] ?? "",
      end_date: map['end_date'] ?? "",
      city_from: map['city_from'] ?? "",
      city_to: map['city_to'] ?? "",
      duration: map['duration'] ?? 0.0,
      travel_line: List<TravelLine>.from(
          map['travel_line']?.map((x) => TravelLine.fromMap(x))),
      request_allowance_lines: List<TravelExpenseResponse>.from(
          map['request_allowance_lines']?.map((x) => TravelExpenseResponse.fromMap(x))),
      state: map['state'] ?? "",
      payment_amount: map['payment_amount'] ?? 0.0,
      create_date: map['create_date'] ?? "",
      name: map['name'] ?? "",
      travel_type_id: TravelExpenseApproveModel.fromMap(map['travel_type_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelRequestListResponse.fromJson(String source) =>
      TravelRequestListResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'TravelRequestListResponse(id: $id, employee_id: $employee_id,start_date: $start_date, end_date: $end_date,city_from: $city_from, city_to: $city_to,duration: $duration, travel_line: $travel_line,request_allowance_lines: $request_allowance_lines, state: $state,payment_amount: $payment_amount, create_date: $create_date, name: $name, travel_type_id: $travel_type_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelRequestListResponse &&
        o.id == id &&
        o.employee_id == employee_id &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.city_from == city_from &&
        o.city_to == city_to &&
        o.duration == duration &&
        o.travel_line == travel_line &&
        o.request_allowance_lines == request_allowance_lines &&
        o.state == state &&
        o.payment_amount == payment_amount &&
        o.create_date == create_date &&
        o.name == name &&
        o.travel_type_id == travel_type_id;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      employee_id.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      city_from.hashCode ^
      city_to.hashCode ^
      duration.hashCode ^
      travel_line.hashCode ^
      request_allowance_lines.hashCode ^
      state.hashCode ^
      payment_amount.hashCode ^
      create_date.hashCode ^
      name.hashCode ^
      travel_type_id.hashCode;
}

// class TravelRequestListResponse {
//   int id;
//   EmployeeID employee_id;
//   String start_date;
//   String end_date;
//   String city_from;
//   String city_to;
//   double duration;
//   List<TravelLine> travel_line;
//   List<TravelExpenseResponse> request_allowance_lines;
//   String state;
//   double payment_amount;
//   String create_date;
//   String name;
//   TravelExpenseApproveModel travel_type_id;

//   TravelRequestListResponse({
//     this.id,
//     this.employee_id,
//     this.start_date,
//     this.end_date,
//     this.city_from,
//     this.city_to,
//     this.duration,
//     this.travel_line,
//     this.request_allowance_lines,
//     this.state,
//     this.payment_amount,
//     this.create_date,
//     this.name,
//     this.travel_type_id,
//   });

//   TravelRequestListResponse copyWith({
//     int id,
//     EmployeeID employee_id,
//     String start_date,
//     String end_date,
//     String city_from,
//     String city_to,
//     double duration,
//     List<TravelLine> travel_line,
//     List<TravelExpenseResponse> request_allowance_lines,
//     String state,
//     double payment_amount,
//     String create_date,
//     String name,
//     TravelExpenseApproveModel travel_type_id,
//   }) {
//     return TravelRequestListResponse(
//       id: id ?? this.id,
//       employee_id: employee_id ?? this.employee_id,
//       start_date: start_date ?? this.start_date,
//       end_date: end_date ?? this.end_date,
//       city_from: city_from ?? this.city_from,
//       city_to: city_to ?? this.city_to,
//       duration: duration ?? this.duration,
//       travel_line: travel_line ?? this.travel_line,
//       request_allowance_lines:
//           request_allowance_lines ?? this.request_allowance_lines,
//       state: state ?? this.state,
//       payment_amount: payment_amount ?? this.payment_amount,
//       create_date: create_date ?? this.create_date,
//       name: name ?? this.name,
//       travel_type_id: travel_type_id ?? this.travel_type_id,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'employee_id': employee_id?.toMap(),
//       'start_date': start_date,
//       'end_date': end_date,
//       'city_from': city_from,
//       'city_to': city_to,
//       'duration': duration,
//       'travel_line': travel_line?.map((x) => x?.toMap())?.toList(),
//       'request_allowance_lines':
//           request_allowance_lines?.map((x) => x?.toMap())?.toList(),
//       'state': state,
//       'payment_amount': payment_amount,
//       'create_date': create_date,
//       'name': name,
//       'travel_type_id': travel_type_id?.toMap(),
//     };
//   }

//   factory TravelRequestListResponse.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return TravelRequestListResponse(
//       id: map['id'] ?? 0,
//       employee_id: EmployeeID.fromMap(map['employee_id']),
//       start_date: map['start_date'] ?? '',
//       end_date: map['end_date'] ?? '',
//       city_from: map['city_from'] ?? '',
//       city_to: map['city_to'] ?? '',
//       duration: map['duration'] ?? 0.0,
//       travel_line: List<TravelLine>.from(
//           map['travel_line']?.map((x) => TravelLine.fromMap(x))),
//       request_allowance_lines: List<TravelExpenseResponse>.from(
//           map['request_allowance_lines']
//               ?.map((x) => TravelExpenseResponse.fromMap(x))),
//       state: map['state'] ?? 0.0,
//       payment_amount: map['payment_amount'] ?? 0.0,
//       create_date: map['create_date'] ?? '',
//       name: map['name'] ?? '',
//       travel_type_id: TravelExpenseApproveModel.fromMap(map['travel_type_id']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TravelRequestListResponse.fromJson(String source) =>
//       TravelRequestListResponse.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TravelRequestListResponse(id: $id, employee_id: $employee_id, start_date: $start_date, end_date: $end_date, city_from: $city_from, city_to: $city_to, duration: $duration, travel_line: $travel_line, request_allowance_lines: $request_allowance_lines, state: $state, create_date: $create_date, name: $name, travel_type_id: $travel_type_id)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is TravelRequestListResponse &&
//         o.id == id &&
//         o.employee_id == employee_id &&
//         o.start_date == start_date &&
//         o.end_date == end_date &&
//         o.city_from == city_from &&
//         o.city_to == city_to &&
//         o.duration == duration &&
//         listEquals(o.travel_line, travel_line) &&
//         listEquals(o.request_allowance_lines, request_allowance_lines) &&
//         o.state == state &&
//         o.create_date == create_date &&
//         o.name == name &&
//         o.travel_type_id == travel_type_id;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         employee_id.hashCode ^
//         start_date.hashCode ^
//         end_date.hashCode ^
//         city_from.hashCode ^
//         city_to.hashCode ^
//         duration.hashCode ^
//         travel_line.hashCode ^
//         request_allowance_lines.hashCode ^
//         state.hashCode ^
//         create_date.hashCode ^
//         name.hashCode ^
//         travel_type_id.hashCode;
//   }
// }
