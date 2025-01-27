import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/company.dart';
import '../../models/employee.dart';
import '../../models/travel_expense/employee_model.dart';
import '../../models/travel_expense/pocket_line.dart';
import '../../models/travel_expense/pocket_model.dart';

class OutofPocketResponse {
  int id;
  String date;
  String state;
  EmployeeModel employee_id;
  Company company_id;
  List<PocketLine> pocket_line;
  String number;
  OutofPocketResponse({
    this.id = 0,
    this.date = '',
    this.state = '',
    required this.employee_id,
    required this.company_id,
    required this.pocket_line,
    this.number = '',
  });

  OutofPocketResponse copyWith({
    int? id,
    String? date,
    String? state,
    required EmployeeModel employee_id,
    required Company company_id,
    required List<PocketLine> pocket_line,
    String? number,
  }) {
    return OutofPocketResponse(
      id: id ?? this.id,
      date: date ?? this.date,
      state: state ?? this.state,
      employee_id: employee_id ?? this.employee_id,
      company_id: company_id ?? this.company_id,
      pocket_line: pocket_line ?? this.pocket_line,
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
      'pocket_line': pocket_line?.map((x) => x?.toMap())?.toList(),
      'number': number,
    };
  }

  factory OutofPocketResponse.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OutofPocketResponse(
      id: map['id'],
      date: map['date'],
      state: map['state'],
      employee_id: EmployeeModel.fromMap(map['employee_id']),
      company_id: Company.fromMap(map['company_id']),
      pocket_line: List<PocketLine>.from(
          map['pocket_line']?.map((x) => PocketLine.fromMap(x))),
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OutofPocketResponse.fromJson(String source) =>
      OutofPocketResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OutofPocketResponse(id: $id, date: $date, state: $state, employee_id: $employee_id, company_id: $company_id, pocket_line: $pocket_line, number: $number)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OutofPocketResponse &&
        o.id == id &&
        o.date == date &&
        o.state == state &&
        o.employee_id == employee_id &&
        o.company_id == company_id &&
        listEquals(o.pocket_line, pocket_line) &&
        o.number == number;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        state.hashCode ^
        employee_id.hashCode ^
        company_id.hashCode ^
        pocket_line.hashCode ^
        number.hashCode;
  }
}
