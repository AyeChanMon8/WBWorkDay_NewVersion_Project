import 'dart:convert';

/// id : 1
/// name : "RES001"
/// employee_id : {"id":null,"name":null}
/// department_id : {"id":null,"name":null}
/// employee_contract : "Ahr Yu"
/// resignation_type : null
/// reason : "test"
/// joined_date : null
/// expected_revealing_date : "2020-09-30"
/// approved_revealing_date : "2020-10-15"
/// notice_period : "0"

class Resignation {
  int id;
  String name;
  Employee_id? employeeId;
  Department_id? departmentId;
  String employeeContract;
  dynamic? resignationType;
  String reason;
  dynamic? joinedDate;
  String expectedRevealingDate;
  String approvedRevealingDate;
  String noticePeriod;
  String confirm_date;
  Employee_id? company_id;
  Employee_id? branch_id;
  Resignation(
      {this.id = 0,
      this.name = '',
      this.employeeId,
      this.departmentId,
      this.employeeContract = '',
      this.resignationType,
      this.reason = '',
      this.joinedDate,
      this.expectedRevealingDate = '',
      this.approvedRevealingDate = '',
      this.noticePeriod = '',
      this.confirm_date = '',
      this.company_id,
      this.branch_id});

  Resignation copyWith(
      {int? id,
      String? name,
      Employee_id? employeeId,
      Department_id? departmentId,
      String? employeeContract,
      dynamic? resignationType,
      String? reason,
      dynamic? joinedDate,
      String? expectedRevealingDate,
      String? approvedRevealingDate,
      String? noticePeriod,
      String? confirm_date,
      Employee_id? company_id,
      Employee_id? branch_id}) {
    return Resignation(
      id: id ?? this.id,
      name: name ?? this.name,
      employeeId: employeeId ?? this.employeeId,
      departmentId: departmentId ?? this.departmentId,
      employeeContract: employeeContract ?? this.employeeContract,
      resignationType: resignationType ?? this.resignationType,
      reason: reason ?? this.reason,
      joinedDate: joinedDate ?? this.joinedDate,
      expectedRevealingDate:
          expectedRevealingDate ?? this.expectedRevealingDate,
      approvedRevealingDate:
          approvedRevealingDate ?? this.approvedRevealingDate,
      noticePeriod: noticePeriod ?? this.noticePeriod,
      confirm_date: confirm_date ?? this.confirm_date,
      company_id: company_id ?? this.company_id,
      branch_id: branch_id ?? this.branch_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employee_id': employeeId?.toMap(),
      'department_id': departmentId?.toMap(),
      'employee_contract': employeeContract,
      'resignation_type': resignationType,
      'reason': reason,
      'joined_date': joinedDate,
      'expected_revealing_date': expectedRevealingDate,
      'approved_revealing_date': approvedRevealingDate,
      'notice_period': noticePeriod,
      'resign_confirm_date': confirm_date,
      'company_id': company_id?.toMap(),
      'branch_id': branch_id?.toMap(),
    };
  }

  factory Resignation.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Resignation(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      employeeId: Employee_id.fromMap(map['employee_id']),
      departmentId: Department_id.fromMap(map['department_id']),
      employeeContract: map['employee_contract'] ?? "",
      resignationType: map['resignation_type'],
      reason: map['reason'] ?? "",
      joinedDate: map['joined_date'],
      expectedRevealingDate: map['expected_revealing_date'] ?? '',
      approvedRevealingDate: map['approved_revealing_date'] ?? "",
      noticePeriod: map['notice_period'] ?? "",
      confirm_date: map['resign_confirm_date'] ?? "",
      company_id: Employee_id.fromMap(map['company_id']),
      branch_id: Employee_id.fromMap(map['branch_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Resignation.fromJson(String source) =>
      Resignation.fromMap(json.decode(source));

  @override
  String toString() =>
      'Resignation(id: $id, name: $name,employeeId: $employeeId,departmentId: $departmentId, employeeContract: $employeeContract,resignationType: $resignationType,reason: $reason, joinedDate: $joinedDate,expectedRevealingDate: $expectedRevealingDate,approvedRevealingDate: $approvedRevealingDate, noticePeriod: $noticePeriod,confirm_date: $confirm_date,company_id: $company_id,branch_id: $branch_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Resignation &&
        o.id == id &&
        o.name == name &&
        o.employeeId == employeeId &&
        o.departmentId == departmentId &&
        o.employeeContract == employeeContract &&
        o.resignationType == resignationType &&
        o.reason == reason &&
        o.joinedDate == joinedDate &&
        o.expectedRevealingDate == expectedRevealingDate &&
        o.approvedRevealingDate == approvedRevealingDate &&
        o.noticePeriod == noticePeriod &&
        o.confirm_date == confirm_date &&
        o.company_id == company_id &&
        o.branch_id == branch_id;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      employeeId.hashCode ^
      departmentId.hashCode ^
      employeeContract.hashCode ^
      resignationType.hashCode ^
      reason.hashCode ^
      joinedDate.hashCode ^
      expectedRevealingDate.hashCode ^
      approvedRevealingDate.hashCode ^
      noticePeriod.hashCode ^
      confirm_date.hashCode ^
      company_id.hashCode ^
      branch_id.hashCode;
}

// class Resignation {
//   int _id;
//   String _name;
//   Employee_id _employeeId;
//   Department_id _departmentId;
//   String _employeeContract;
//   dynamic _resignationType;
//   String _reason;
//   dynamic _joinedDate;
//   String _expectedRevealingDate;
//   String _approvedRevealingDate;
//   String _noticePeriod;
//   String _confirm_date;
//   Employee_id _company_id;
//   Employee_id _branch_id;

//   int get id => _id;
//   String get name => _name;
//   String get confirm_date => _confirm_date;
//   Employee_id get employeeId => _employeeId;
//   Department_id get departmentId => _departmentId;
//   String get employeeContract => _employeeContract;
//   dynamic get resignationType => _resignationType;
//   String get reason => _reason;
//   dynamic get joinedDate => _joinedDate;
//   String get expectedRevealingDate => _expectedRevealingDate;
//   String get approvedRevealingDate => _approvedRevealingDate;
//   String get noticePeriod => _noticePeriod;
//   Employee_id get company_id => _company_id;
//   Employee_id get branch_id => _branch_id;

//   Resignation(
//       {int id,
//       String name,
//       Employee_id employeeId,
//       Department_id departmentId,
//       String employeeContract,
//       dynamic resignationType,
//       String reason,
//       dynamic joinedDate,
//       String expectedRevealingDate,
//       String approvedRevealingDate,
//       String noticePeriod,
//       String confirmDate}) {
//     _id = id;
//     _name = name;
//     _employeeId = employeeId;
//     _departmentId = departmentId;
//     _employeeContract = employeeContract;
//     _resignationType = resignationType;
//     _reason = reason;
//     _joinedDate = joinedDate;
//     _expectedRevealingDate = expectedRevealingDate;
//     _approvedRevealingDate = approvedRevealingDate;
//     _noticePeriod = noticePeriod;
//     _confirm_date = confirmDate;
//   }

//   Resignation.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _employeeId = json["employee_id"] != null
//         ? Employee_id.fromJson(json["employee_id"])
//         : null;
//     _departmentId = json["department_id"] != null
//         ? Department_id.fromJson(json["department_id"])
//         : null;
//     _employeeContract = json["employee_contract"];
//     _resignationType = json["resignation_type"];
//     _reason = json["reason"];
//     _joinedDate = json["joined_date"];
//     _expectedRevealingDate = json["expected_revealing_date"];
//     _approvedRevealingDate = json["approved_revealing_date"];
//     _noticePeriod = json["notice_period"];
//     _confirm_date = json["resign_confirm_date"];
//     _company_id = json["company_id"] != null
//         ? Employee_id.fromJson(json["company_id"])
//         : null;
//     _branch_id = json["branch_id"] != null
//         ? Employee_id.fromJson(json["branch_id"])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     if (_employeeId != null) {
//       map["employee_id"] = _employeeId?.toJson();
//     }
//     if (_departmentId != null) {
//       map["department_id"] = _departmentId?.toJson();
//     }
//     map["employee_contract"] = _employeeContract;
//     map["resignation_type"] = _resignationType;
//     map["reason"] = _reason;
//     map["joined_date"] = _joinedDate;
//     map["expected_revealing_date"] = _expectedRevealingDate;
//     map["approved_revealing_date"] = _approvedRevealingDate;
//     map["notice_period"] = _noticePeriod;
//     return map;
//   }
// }

/// id : null
/// name : null

class Department_id {
  final int id;
  final String name;
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
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Department_id.fromJson(String source) =>
      Department_id.fromMap(json.decode(source));

  @override
  String toString() => 'Department_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Department_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Department_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Department_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Department_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// id : null
/// name : null

class Employee_id {
  final int id;
  final String name;
  Employee_id({
    this.id = 0,
    this.name = '',
  });

  Employee_id copyWith({
    int? id,
    String? name,
  }) {
    return Employee_id(
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

  factory Employee_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_id.fromJson(String source) =>
      Employee_id.fromMap(json.decode(source));

  @override
  String toString() => 'Employee_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Employee_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Employee_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   Employee_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }
