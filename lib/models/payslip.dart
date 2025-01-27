

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/employee.dart';
import '../models/employee_payslip.dart';
import '../models/line_ids.dart';

class PaySlips {
  int id;
  String month;
  String year;
  String dateFrom;
  String dateTo;
  Employee_id? employeeId;
  List<Category_list>? categoryList;
  double total;
  String pin;
  String slip_number;
  dynamic bank_account_number;
  dynamic company_logo;
  PaySlips({this.id = 0, this.month = '',
  this.year = '', this.dateFrom = '', this.dateTo = '',
  this.employeeId,this.categoryList, this.total = 0.0,
  this.pin = '', this.slip_number = '',
  this.bank_account_number,
  this.company_logo});

  PaySlips copyWith({int? id, String? name}) {
    return PaySlips(
      id: id ?? this.id,
      month: month ?? this.month,
      year: year ?? this.year,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      employeeId: employeeId ?? this.employeeId,
      categoryList: categoryList ?? this.categoryList,
      total: total ?? this.total,
      pin: pin ?? this.pin,
      slip_number: slip_number ?? this.slip_number,
      bank_account_number: bank_account_number ?? this.bank_account_number,
      company_logo: company_logo ?? this.company_logo
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 
    'month': month,
    'year': year, 
    'date_from': dateFrom,
    'date_to': dateTo,
    'employee_id': employeeId?.toMap(),
    'category_list': categoryList?.map((x) => x?.toMap())?.toList(),
    'total': total,
    'pin': pin,
    'slip_number': slip_number,
    'bank_account_number': bank_account_number,
    'company_logo' : company_logo
    };
  }

  factory PaySlips.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PaySlips(
      id: map['id'],
      month: map['month'],
      year: map['year'],
      dateFrom: map['date_from'],
      dateTo: map['date_to'],
      employeeId: Employee_id.fromMap(map['employee_id']),
      categoryList: List<Category_list>.from(
          map['category_list']?.map((x) => Category_list.fromMap(x))),
      total: map['total'],
      pin: map['pin'],
      slip_number: map['slip_number'],
      bank_account_number: map['bank_account_number'],
      company_logo: map['company_logo']
    );
  }

  String toJson() => json.encode(toMap());

  factory PaySlips.fromJson(String source) =>
      PaySlips.fromMap(json.decode(source));

  @override
  String toString() => 'PaySlips(id: $id, month: $month,year: $year, dateFrom: $dateFrom,dateTo: $dateTo, employeeId: $employeeId,categoryList: $categoryList, total: $total,pin: $pin, slip_number: $slip_number, bank_account_number: $bank_account_number,company_logo: $company_logo)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaySlips && o.id == id && o.month == month && o.year == year && o.dateFrom == dateFrom
    && o.dateTo == dateTo && o.employeeId == employeeId && o.categoryList == categoryList && o.total == total && o.pin == pin && o.slip_number == slip_number
    && o.bank_account_number == bank_account_number && o.company_logo == company_logo;
  }

  @override
  int get hashCode => id.hashCode ^ month.hashCode ^ year.hashCode ^ dateFrom.hashCode ^ dateTo.hashCode ^ employeeId.hashCode
  ^ categoryList.hashCode ^ total.hashCode ^ pin.hashCode ^ slip_number.hashCode ^ bank_account_number.hashCode ^ company_logo.hashCode;
}

// class PaySlips {
//   int _id;
//   String _month;
//   String _year;
//   String _dateFrom;
//   String _dateTo;
//   Employee_id _employeeId;
//   List<Category_list> _categoryList;
//   double _total;
//   String _pin;
//   String _slip_number;
//   dynamic _bank_account_number;

//   int get id => _id;
//   String get month => _month;
//   String get year => _year;
//   String get dateFrom => _dateFrom;
//   String get dateTo => _dateTo;
//   Employee_id get employeeId => _employeeId;
//   List<Category_list> get categoryList => _categoryList;
//   double get total=> _total;
//   String get pin => _pin;
//   String get slip_number => _slip_number;
//   dynamic get bank_account_number => _bank_account_number;

//   PaySlips({
//     int id,
//     String month,
//     String year,
//     String dateFrom,
//     String dateTo,
//     Employee_id employeeId,
//     List<Category_list> categoryList,
//     String pin,
//     String slip_number,
//     String bank_account_number}){
//     _id = id;
//     _month = month;
//     _year = year;
//     _dateFrom = dateFrom;
//     _dateTo = dateTo;
//     _employeeId = employeeId;
//     _categoryList = categoryList;
//     _pin = pin;
//     _slip_number = slip_number;
//     _bank_account_number = bank_account_number;
//   }

//   PaySlips.fromJson(dynamic json) {
//     _id = json['id'];
//     _month = json['month'];
//     _year = json['year'];
//     _dateFrom = json['date_from'];
//     _dateTo = json['date_to'];
//     _employeeId = json['employee_id'] != null ? Employee_id.fromJson(json['employee_id']) : null;
//     if (json['category_list'] != null) {
//       _categoryList = [];
//       json['category_list'].forEach((v) {
//         _categoryList.add(Category_list.fromJson(v));
//       });
//     }
//     _total = json['total'];
//     _pin = json['pin'];
//     _slip_number = json['slip_number'];
//     _bank_account_number = json['bank_account_number'];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['id'] = _id;
//     map['month'] = _month;
//     map['year'] = _year;
//     map['date_from'] = _dateFrom;
//     map['date_to'] = _dateTo;
//     if (_employeeId != null) {
//       map['employee_id'] = _employeeId.toJson();
//     }
//     if (_categoryList != null) {
//       map['category_list'] = _categoryList.map((v) => v.toJson()).toList();
//     }
//     map['pin'] = _pin;
//     map['slip_number'] = _slip_number;
//     map['bank_account_number'] = _bank_account_number;
//     return map;
//   }

// }

/// name : "Basic Salary"
/// code : "BASIC"
/// total : 4600000.0

class Category_list {
  String name;
  String code;
  double total;
  List<LineIDs>? lineList;
  Category_list({this.name = '', this.code = '', this.total = 0.0,
  this.lineList});

  Category_list copyWith({String? name, String? code, double? total, List<LineIDs>? lineList}) {
    return Category_list(
      name: name ?? this.name,
      code: code ?? this.code,
      total: total ?? this.total,
      lineList: lineList ?? this.lineList,

    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'code': code, 'total': total,
    'line_ids': lineList?.map((x) => x?.toMap())?.toList(),};
  }

  factory Category_list.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Category_list(
      name: map['name'],
      code: map['code']?? "",
      total: map['total']?? 0.0,
      lineList: List<LineIDs>.from(
          map['line_ids']?.map((x) => LineIDs.fromMap(x)))
    );
  }

  String toJson() => json.encode(toMap());

  factory Category_list.fromJson(String source) =>
      Category_list.fromMap(json.decode(source));

  @override
  String toString() => 'Category_list(name: $name, code: $code, total: $total, lineList: $lineList)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Category_list && o.name == name && o.code == code && o.total == total  && o.lineList == lineList;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ total.hashCode ^ lineList.hashCode;
}

// class Category_list {
//   String _name;
//   String _code;
//   double _total;
//   List<LineIDs> _lineList;

//   String get name => _name;
//   String get code => _code;
//   double get total => _total;
//   List<LineIDs> get lineList => _lineList;
//   Category_list({
//     String name,
//     String code,
//     double total}){
//     _name = name;
//     _code = code;
//     _total = total;
//   }

//   Category_list.fromJson(dynamic json) {
//     _name = json['name'];
//     _code = json['code'];
//     _total = json['total'];
//     if (json['line_ids'] != null) {
//       _lineList = [];
//       json['line_ids'].forEach((v) {
//         _lineList.add(LineIDs.fromMap(v));
//       });
//     }

//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['name'] = _name;
//     map['code'] = _code;
//     map['total'] = _total;
//     return map;
//   }

// }

/// id : 5098
/// name : "Kham Nandar Phe"
/// job_id : {"id":1342,"name":"Head of HR"}
/// department_id : {"id":410,"name":"HR DEPARTMENT"}

class Employee_id {
  int id;
  String name;
  Job_id? jobId;
  Department_id? departmentId;
  Employee_id({
    this.id = 0,
    this.name = '',
    this.jobId,
    this.departmentId
  });

  Employee_id copyWith({
    int? id,
  String? name,
  Job_id? jobId,
  Department_id? departmentId,
  }) {
    return Employee_id(
      id: id ?? this.id,
      name: name ?? this.name,
      jobId: jobId ?? this.jobId,
      departmentId: departmentId ?? this.departmentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'job_id': jobId?.toMap(),
      'department_id': departmentId?.toMap(),
    };
  }
  factory Employee_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return Employee_id(
      id: map['id']??0,
      name: map['name']??'',
      jobId: Job_id.fromMap(map['job_id']),
      departmentId: Department_id.fromMap(map['department_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_id.fromJson(String source) => Employee_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee_id(id: $id, name: $name,jobId: $jobId, departmentId: $departmentId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Employee_id &&
      o.id == id &&
      o.name == name &&
      o.jobId == jobId &&
      o.departmentId == departmentId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      jobId.hashCode ^
      departmentId.hashCode;
  }
}

// class Employee_id {
//   int _id;
//   String _name;
//   Job_id _jobId;
//   Department_id _departmentId;

//   int get id => _id;
//   String get name => _name;
//   Job_id get jobId => _jobId;
//   Department_id get departmentId => _departmentId;

//   Employee_id({
//     int id,
//     String name,
//     Job_id jobId,
//     Department_id departmentId}){
//     _id = id;
//     _name = name;
//     _jobId = jobId;
//     _departmentId = departmentId;
//   }

//   Employee_id.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _jobId = json['job_id'] != null ? Job_id.fromJson(json['job_id']) : null;
//     _departmentId = json['department_id'] != null ? Department_id.fromJson(json['department_id']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     if (_jobId != null) {
//       map['job_id'] = _jobId.toJson();
//     }
//     if (_departmentId != null) {
//       map['department_id'] = _departmentId.toJson();
//     }
//     return map;
//   }

// }

/// id : 410
/// name : "HR DEPARTMENT"

class Department_id {
  int id = 0;
  String name = "";
  Department_id({
    this.id = 0,
    this.name = '',
  });

  Department_id copyWith({
    int? id,
    String? name,
  }) {
    return Department_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
  factory Department_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return Department_id(
      id: map['id']??0,
      name: map['name']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory Department_id.fromJson(String source) => Department_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Department_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Department_id &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode;
  }
}

// class Department_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Department_id({
//     int id,
//     String name}){
//     _id = id;
//     _name = name;
//   }

//   Department_id.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     return map;
//   }

// }

/// id : 1342
/// name : "Head of HR"

class Job_id {
  int id = 0;
  String name = "";
  Job_id({
    this.id = 0,
    this.name = '',
  });

  Job_id copyWith({
    int? id,
    String? name,
  }) {
    return Job_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
  factory Job_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return Job_id(
      id: map['id']??0,
      name: map['name']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory Job_id.fromJson(String source) => Job_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Job_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Job_id &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode;
  }
}

// class Job_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Job_id({
//     int id,
//     String name}){
//     _id = id;
//     _name = name;
//   }

//   Job_id.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     return map;
//   }

// }
