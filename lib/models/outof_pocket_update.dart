

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/company.dart';
import '../models/employee.dart';
import '../models/employee_id.dart';
import '../models/travel_expense/pocket_model.dart';
import '../models/travel_expense/create/travel_expense_model.dart';

class OutofPocketUpdateModel {
  int id;
  String date;
  int mobile_user_id;
  int employee_id;
  int company_id;
  List<PockectModel>? pocket_line;
  String number;
  OutofPocketUpdateModel({
    this.id = 0,
    this.date = '',
    this.mobile_user_id = 0,
    this.employee_id = 0,
    this.company_id = 0,
    this.pocket_line,
    this.number = ''
  });

  OutofPocketUpdateModel copyWith({
    int? id,
    String? date,
    int? mobile_user_id,
    int? employee_id,
    int? company_id,
    List<PockectModel>? pocket_line,
  }) {
    return OutofPocketUpdateModel(
      id: id ?? this.id,
      date: date ?? this.date,
      mobile_user_id:mobile_user_id??this.mobile_user_id,
      employee_id: employee_id ?? this.employee_id,
      company_id: company_id ?? this.company_id,
      number: number?? this.number,
      pocket_line: pocket_line ?? this.pocket_line,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parent_id': id,
      // 'date': date,
      // 'mobile_user_id' : mobile_user_id,
      // 'employee_id': employee_id,
      // 'company_id': company_id,
      'pocket_lines': pocket_line?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory OutofPocketUpdateModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OutofPocketUpdateModel(
      id: map['id'],
      date: map['date'],
      mobile_user_id: map['mobile_user_id'],
      employee_id: map['employee_id'],
      company_id: map['company_id'],
      pocket_line: List<PockectModel>.from(
          map['pocket_line']?.map((x) => PockectModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OutofPocketUpdateModel.fromJson(String source) =>
      OutofPocketUpdateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OutofPocketUpdateModel(id: $id, date: $date, employee_id: $employee_id, company_id: $company_id, pocket_line: $pocket_line)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OutofPocketUpdateModel &&
        o.id == id &&
        o.date == date &&
        o.employee_id == employee_id &&
        o.company_id == company_id &&
        listEquals(o.pocket_line, pocket_line);
  }

  @override
  int get hashCode {
    return id.hashCode ^
    date.hashCode ^
    employee_id.hashCode ^
    company_id.hashCode ^
    pocket_line.hashCode;
  }
}
