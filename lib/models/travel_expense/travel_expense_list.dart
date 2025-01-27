import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/company.dart';
import '../../models/employee_id.dart';
import '../../models/travel_expense/create/travel_expense_model.dart';

class TravelExpenseListModel {
  int id;
  String date;
  String state;
  EmployeeID employee_id;
  Company companyId;
  List<TravelExpenseModel> travel_line;
  TravelExpenseListModel({
    this.id = 0,
    this.date = '',
    this.state = '',
    required this.employee_id,
    required this.companyId,
    required this.travel_line,
  });

  TravelExpenseListModel copyWith({
    int? id,
    String? date,
    String? state,
    required EmployeeID employee_id,
    required Company companyId,
    required List<TravelExpenseModel> travel_line,
  }) {
    return TravelExpenseListModel(
      id: id ?? this.id,
      date: date ?? this.date,
      state: state ?? this.state,
      employee_id: employee_id ?? this.employee_id,
      companyId: companyId ?? this.companyId,
      travel_line: travel_line ?? this.travel_line,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'state': state,
      'employee_id': employee_id?.toMap(),
      'companyId': companyId?.toMap(),
      'travel_line': travel_line?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory TravelExpenseListModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelExpenseListModel(
      id: map['id'],
      date: map['date'],
      state: map['state'],
      employee_id: EmployeeID.fromMap(map['employee_id']),
      companyId: Company.fromMap(map['companyId']),
      travel_line: List<TravelExpenseModel>.from(
          map['travel_line']?.map((x) => TravelExpenseModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelExpenseListModel.fromJson(String source) =>
      TravelExpenseListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TravelExpenseListModel(id: $id, date: $date, state: $state, employee_id: $employee_id, companyId: $companyId, travel_line: $travel_line)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelExpenseListModel &&
        o.id == id &&
        o.date == date &&
        o.state == state &&
        o.employee_id == employee_id &&
        o.companyId == companyId &&
        listEquals(o.travel_line, travel_line);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        state.hashCode ^
        employee_id.hashCode ^
        companyId.hashCode ^
        travel_line.hashCode;
  }
}
