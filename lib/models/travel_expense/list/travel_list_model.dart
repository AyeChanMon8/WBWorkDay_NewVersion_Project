import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../models/company.dart';
import '../../../models/employee.dart';
import '../../../models/employee_id.dart';
import '../../../models/travel_expense/create/travel_expense_model.dart';
import '../../../models/travel_expense/create/travel_line_model.dart';
import '../../../models/travel_expense/employee_model.dart';
import '../../../models/travel_expense/list/travel_line_list_model.dart';
import '../../../models/travel_expense/list/travel_model.dart';
import '../../../models/travel_expense/pocket_model.dart';
import '../../../models/travel_line.dart';

class TravelExpenseList {
  int id;
  String date;
  String state;
  EmployeeModel employee_id;
  Company company_id;
  TravelModel travel_id;
  double total_expense;
  double payment_amount;
  double advanced_money;
  List<TravelLineListModel> travel_line;
  String number;
  TravelExpenseList({
    this.id = 0,
    this.date = '',
    this.state = '',
    required this.employee_id,
    required this.company_id,
    required this.travel_id,
    this.total_expense = 0.0,
    this.payment_amount = 0.0,
    this.advanced_money = 0.0,
    required this.travel_line,
    this.number = '',
  });

  TravelExpenseList copyWith({
    int? id,
    String? date,
    String? state,
    required EmployeeModel employee_id,
    required Company company_id,
    required TravelModel travel_id,
    double? advanced_money,
    required List<TravelLineListModel> travel_line,
    String? number,
  }) {
    return TravelExpenseList(
      id: id ?? this.id,
      date: date ?? this.date,
      state: state ?? this.state,
      employee_id: employee_id ?? this.employee_id,
      company_id: company_id ?? this.company_id,
      travel_id: travel_id ?? this.travel_id,
      payment_amount: payment_amount ?? this.payment_amount,
      advanced_money: advanced_money ?? this.advanced_money,
      travel_line: travel_line ?? this.travel_line,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'state': state,
      'employee_id': employee_id?.toMap(),
      'company_id': company_id?.toMap(),
      'travel_id': travel_id?.toMap(),
      'total_expense': total_expense,
      'payment_amount': payment_amount,
      'advanced_money': advanced_money,
      'travel_line': travel_line?.map((x) => x?.toMap())?.toList(),
      'number': number,
    };
  }

  factory TravelExpenseList.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelExpenseList(
      id: map['id'],
      date: map['date'],
      state: map['state'],
      employee_id: EmployeeModel.fromMap(map['employee_id']),
      company_id: Company.fromMap(map['company_id']),
      travel_id: TravelModel.fromMap(map['travel_id']),
      total_expense: map['total_expense'],
      payment_amount: map['payment_amount'],
      advanced_money: map['advanced_money'],
      travel_line: List<TravelLineListModel>.from(
          map['travel_line']?.map((x) => TravelLineListModel.fromMap(x))),
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelExpenseList.fromJson(String source) =>
      TravelExpenseList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TravelExpenseList(id: $id, date: $date, state: $state, employee_id: $employee_id, company_id: $company_id, travel_id: $travel_id, advanced_money: $advanced_money, travel_line: $travel_line, number: $number)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelExpenseList &&
        o.id == id &&
        o.date == date &&
        o.state == state &&
        o.employee_id == employee_id &&
        o.company_id == company_id &&
        o.travel_id == travel_id &&
        o.advanced_money == advanced_money &&
        listEquals(o.travel_line, travel_line) &&
        o.number == number;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        state.hashCode ^
        employee_id.hashCode ^
        company_id.hashCode ^
        travel_id.hashCode ^
        advanced_money.hashCode ^
        travel_line.hashCode ^
        number.hashCode;
  }
}
