import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/company.dart';
import '../models/employee.dart';
import '../models/travel_expense/employee_model.dart';
import '../models/travel_expense/pocket_line.dart';
import '../models/travel_expense/pocket_model.dart';
import '../models/trip_expense_line.dart';

class TripExpense {
  int id;
  String number;
  String date;
  String state;
  String source_doc;
  double advanced_money;
  EmployeeModel? employee_id;
  Company? company_id;
  double total_expense;
  double diff_amount;
  Company? vendor_bill_id;
  Company? daytrip_id;
  Company? plantrip_product_id;
  Company? plantrip_waybill_id;
  List<TripExpenseLine>? trip_expense_lines;
  TripExpense(
      {this.id = 0,
      this.number = '',
      this.date = '',
      this.state = '',
      this.source_doc = '',
      this.advanced_money = 0.0,
      this.employee_id,
      this.company_id,
      this.total_expense = 0.0,
      this.diff_amount = 0.0,
      this.vendor_bill_id,
      this.daytrip_id,
      this.plantrip_product_id,
      this.plantrip_waybill_id,
      this.trip_expense_lines});

  TripExpense copyWith({
    int? id,
    String? number,
    String? date,
    String? state,
    String? source_doc,
    double? advanced_money,
    EmployeeModel? employee_id,
    Company? company_id,
    double? total_expense,
    double? diff_amount,
    Company? vendor_bill_id,
    Company? daytrip_id,
    Company? plantrip_product_id,
    Company? plantrip_waybill_id,
    List<TripExpenseLine>? trip_expense_lines,
  }) {
    return TripExpense(
        id: id ?? this.id,
        number: number ?? this.number,
        date: date ?? this.date,
        state: state ?? this.state,
        source_doc: source_doc ?? this.source_doc,
        advanced_money: advanced_money ?? this.advanced_money,
        employee_id: employee_id ?? this.employee_id,
        company_id: company_id ?? this.company_id,
        total_expense: total_expense ?? this.total_expense,
        diff_amount: diff_amount ?? this.diff_amount,
        vendor_bill_id: vendor_bill_id ?? this.vendor_bill_id,
        daytrip_id: daytrip_id ?? this.daytrip_id,
        plantrip_product_id: plantrip_product_id ?? this.plantrip_product_id,
        plantrip_waybill_id: plantrip_waybill_id ?? this.plantrip_waybill_id,
        trip_expense_lines: trip_expense_lines ?? this.trip_expense_lines);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'date': date,
      'state': state,
      'source_doc': source_doc,
      'advanced_money': advanced_money,
      'employee_id': employee_id?.toMap(),
      'company_id': company_id?.toMap(),
      'total_expense': total_expense,
      'diff_amount': diff_amount,
      'vendor_bill_id': vendor_bill_id?.toMap(),
      'daytrip_id': daytrip_id?.toMap(),
      'plantrip_product_id': plantrip_product_id?.toMap(),
      'plantrip_waybill_id': plantrip_waybill_id?.toMap(),
      'trip_expense_lines': trip_expense_lines?.map((x) => x?.toMap())?.toList(),
      // 'name': name,
    };
  }

  factory TripExpense.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TripExpense(
      id: map['id'],
      number: map['number'],
      date: map['date'],
      state: map['state'],
      source_doc: map['source_doc'],
      advanced_money: map['advanced_money'],
      employee_id: EmployeeModel.fromMap(map['employee_id']),
      company_id: Company.fromMap(map['company_id']),
      total_expense: map['total_expense'],
      diff_amount: map['diff_amount'],
      vendor_bill_id: Company.fromMap(map['vendor_bill_id']),
      daytrip_id: Company.fromMap(map['daytrip_id']),
      plantrip_product_id: Company.fromMap(map['plantrip_product_id']),
      plantrip_waybill_id: Company.fromMap(map['plantrip_waybill_id']),
      trip_expense_lines: List<TripExpenseLine>.from(
          map['trip_expense_lines']?.map((x) => TripExpenseLine.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TripExpense.fromJson(String source) =>
      TripExpense.fromMap(json.decode(source));

  @override
  String toString() =>
      'TripExpense(id: $id, number: $number, date: $date, state: $state,source_doc: $source_doc, advanced_money: $advanced_money, employee_id: $employee_id, company_id: $company_id,total_expense: $total_expense, diff_amount: $diff_amount, vendor_bill_id: $vendor_bill_id, daytrip_id: $daytrip_id, plantrip_product_id: $plantrip_product_id, plantrip_waybill_id: $plantrip_waybill_id, trip_expense_lines: $trip_expense_lines)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TripExpense &&
        o.id == id &&
        o.number == number &&
        o.date == date &&
        o.state == state &&
        o.source_doc == source_doc &&
        o.advanced_money == advanced_money &&
        o.employee_id == employee_id &&
        o.company_id == company_id &&
        o.total_expense == total_expense &&
        o.diff_amount == diff_amount &&
        o.vendor_bill_id == vendor_bill_id &&
        o.daytrip_id == daytrip_id &&
        o.plantrip_product_id == plantrip_product_id &&
        o.plantrip_waybill_id == plantrip_waybill_id &&
        o.trip_expense_lines == trip_expense_lines;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      number.hashCode ^
      date.hashCode ^
      state.hashCode ^
      source_doc.hashCode ^
      advanced_money.hashCode ^
      employee_id.hashCode ^
      company_id.hashCode ^
      total_expense.hashCode ^
      diff_amount.hashCode ^
      vendor_bill_id.hashCode ^
      daytrip_id.hashCode ^
      plantrip_product_id.hashCode ^
      plantrip_waybill_id.hashCode ^
      trip_expense_lines.hashCode;
}

// class TripExpense {
//   int id;
//   String number;
//   String date;
//   String state;
//   String source_doc;
//   double advanced_money;
//   EmployeeModel employee_id;
//   Company company_id;
//   double total_expense;
//   double diff_amount;
//   Company vendor_bill_id;
//   Company daytrip_id;
//   Company plantrip_product_id;
//   Company plantrip_waybill_id;
//   List<TripExpenseLine> trip_expense_lines;

//   TripExpense({
//     this.id,
//     this.date,
//     this.state,
//     this.employee_id,
//     this.company_id,
//     this.trip_expense_lines,
//     this.number,
//     this.source_doc,
//   });

//   TripExpense copyWith({
//     int id,
//     String date,
//     String state,
//     EmployeeModel employee_id,
//     Company company_id,
//     List<PocketLine> pocket_line,
//     String number,
//   }) {
//     return TripExpense(
//         id: id ?? this.id,
//         date: date ?? this.date,
//         state: state ?? this.state,
//         employee_id: employee_id ?? this.employee_id,
//         company_id: company_id ?? this.company_id,
//         trip_expense_lines: trip_expense_lines ?? this.trip_expense_lines,
//         number: number ?? this.number,
//         source_doc: source_doc ?? this.source_doc);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'date': date,
//       'state': state,
//       'employee_id': employee_id?.toMap(),
//       'company_id': company_id?.toMap(),
//       'trip_expense_lines':
//           trip_expense_lines?.map((x) => x?.toMap())?.toList(),
//       'number': number,
//     };
//   }

//   factory TripExpense.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return TripExpense(
//       id: map['id'],
//       date: map['date'],
//       state: map['state'],
//       employee_id: EmployeeModel.fromMap(map['employee_id']),
//       company_id: Company.fromMap(map['company_id']),
//       trip_expense_lines: List<TripExpenseLine>.from(
//           map['trip_expense_lines']?.map((x) => TripExpenseLine.fromMap(x))),
//       number: map['number'],
//       source_doc: map['source_doc'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TripExpense.fromJson(String source) =>
//       TripExpense.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TripExpense(id: $id, date: $date, state: $state, employee_id: $employee_id, company_id: $company_id, pocket_line: $trip_expense_lines, number: $number)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is TripExpense &&
//         o.id == id &&
//         o.date == date &&
//         o.state == state &&
//         o.employee_id == employee_id &&
//         o.company_id == company_id &&
//         listEquals(o.trip_expense_lines, trip_expense_lines) &&
//         o.number == number;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         date.hashCode ^
//         state.hashCode ^
//         employee_id.hashCode ^
//         company_id.hashCode ^
//         trip_expense_lines.hashCode ^
//         number.hashCode;
//   }
// }
