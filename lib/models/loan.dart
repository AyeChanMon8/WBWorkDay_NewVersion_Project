

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/company.dart';
import '../models/department.dart';
import '../models/employee_id.dart';
import '../models/job.dart';
import '../models/loan_line.dart';

class Loan {
  int? id;
  String? name;
  EmployeeID? employee_id;
  Department? department_id;
  Job? job_position;
  String? date;
  String? payment_date;
  double? loan_amount;
  int? installment;
  String? type;
  Company? company_id;
  List<LoanLine>? loan_lines;
  String? state;
  String? attachment;
  String? attachment_filename;
  Company? branch_id;

  Loan({
    this.id,
    this.name,
    this.employee_id,
    this.department_id,
    this.job_position,
    this.date,
    this.payment_date,
    this.loan_amount,
    this.installment,
    this.type,
    this.company_id,
    this.loan_lines,
    this.state,
    this.attachment,
    this.attachment_filename,this.branch_id
  });
  

  Loan copyWith({
    int? id,
    String? name,
    EmployeeID? employee_id,
    Department? department_id,
    Job? job_position,
    String? date,
    String? payment_date,
    double? loan_amount,
    int? installment,
    String? type,
    Company? company_id,
    List<LoanLine>? loan_lines,
    String? state,
    String? attch,
    String? attch_name,

  }) {
    return Loan(
      id: id ?? this.id,
      name: name ?? this.name,
      employee_id: employee_id ?? this.employee_id,
      department_id: department_id ?? this.department_id,
      job_position: job_position ?? this.job_position,
      date: date ?? this.date,
      payment_date: payment_date ?? this.payment_date,
      loan_amount: loan_amount ?? this.loan_amount,
      installment: installment ?? this.installment,
      type: type ?? this.type,
      company_id: company_id ?? this.company_id,
      loan_lines: loan_lines ?? this.loan_lines,
      state: state ?? this.state,
      attachment: attch?? this.attachment,
        attachment_filename: attch_name?? this.attachment_filename
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employee_id': employee_id?.toMap(),
      'department_id': department_id?.toMap(),
      'job_position': job_position?.toMap(),
      'date': date,
      'payment_date': payment_date,
      'loan_amount': loan_amount,
      'installment': installment,
      'type': type,
      'company_id': company_id?.toMap(),
      'loan_lines': loan_lines?.map((x) => x?.toMap())?.toList(),
      'state': state,
    };
  }

  factory Loan.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return Loan(
      id: map['id'],
      name: map['name'],
      employee_id: EmployeeID.fromMap(map['employee_id']),
      department_id: Department.fromMap(map['department_id']),
      job_position: Job.fromMap(map['job_position']),
      date: map['date'],
      payment_date: map['payment_date'],
      loan_amount: map['loan_amount'],
      installment: map['installment'],
      type: map['type'],
      company_id: Company.fromMap(map['company_id']),
      branch_id: Company.fromMap(map['branch_id']),
      loan_lines: List<LoanLine>.from(map['loan_lines']?.map((x) => LoanLine.fromMap(x))),
      state: map['state'],
      attachment:map['attached_file'],
      attachment_filename:map['attached_filename'],

    );
  }

  String toJson() => json.encode(toMap());

  factory Loan.fromJson(String source) => Loan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Loan(id: $id, name: $name, employee_id: $employee_id, department_id: $department_id, job_position: $job_position, date: $date, payment_date: $payment_date, loan_amount: $loan_amount, installment: $installment, type: $type, company_id: $company_id, loan_lines: $loan_lines, state: $state)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Loan &&
      o.id == id &&
      o.name == name &&
      o.employee_id == employee_id &&
      o.department_id == department_id &&
      o.job_position == job_position &&
      o.date == date &&
      o.payment_date == payment_date &&
      o.loan_amount == loan_amount &&
      o.installment == installment &&
      o.type == type &&
      o.company_id == company_id &&
      listEquals(o.loan_lines, loan_lines) &&
      o.state == state;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      employee_id.hashCode ^
      department_id.hashCode ^
      job_position.hashCode ^
      date.hashCode ^
      payment_date.hashCode ^
      loan_amount.hashCode ^
      installment.hashCode ^
      type.hashCode ^
      company_id.hashCode ^
      loan_lines.hashCode ^
      state.hashCode;
  }
}
