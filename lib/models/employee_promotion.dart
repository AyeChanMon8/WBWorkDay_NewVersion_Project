

import 'dart:convert';

/// id : 1
/// name : "Changing Salary of Lin Zaw Oo"
/// type : "salary_change"
/// employee_id : {"id":5958,"name":"Lin Zaw Oo"}
/// company_id : {"id":11,"name":"WIN BROTHERS BACK OFFICE GROUP"}
/// branch_id : {"id":36,"name":"WB BO SITE"}
/// department_id : {"id":493,"name":"OFFICE FLEET TEAM"}
/// job_id : {"id":1332,"name":"Fleet Incharge"}
/// job_grade_id : {"id":5,"name":"G-02"}
/// salary_level_id : {"id":7,"name":"L-06"}
/// wage : 250000.0
/// date : "2020-10-01"
/// new_company_id : {"id":11,"name":"WIN BROTHERS BACK OFFICE GROUP"}
/// new_branch_id : {"id":36,"name":"WB BO SITE"}
/// new_department_id : {"id":493,"name":"OFFICE FLEET TEAM"}
/// new_job_id : {"id":1332,"name":"Fleet Incharge"}
/// new_job_grade_id : {"id":5,"name":"G-02"}
/// new_salary_level_id : {"id":12,"name":"L-11"}
/// new_wage : 300000.0
/// note : null

// class Employee_promotion {
//   int _id;
//   String _name;
//   String _type;
//   Employee_id _employeeId;
//   Company_id _companyId;
//   Branch_id _branchId;
//   Department_id _departmentId;
//   Job_id _jobId;
//   Job_grade_id _jobGradeId;
//   Salary_level_id _salaryLevelId;
//   double _wage;
//   String _date;
//   New_company_id _newCompanyId;
//   New_branch_id _newBranchId;
//   New_department_id _newDepartmentId;
//   New_job_id _newJobId;
//   New_job_grade_id _newJobGradeId;
//   New_salary_level_id _newSalaryLevelId;
//   double _newWage;
//   dynamic _note;
//   String _state;

//   int get id => _id;
//   String get name => _name;
//   String get type => _type;
//   Employee_id get employeeId => _employeeId;
//   Company_id get companyId => _companyId;
//   Branch_id get branchId => _branchId;
//   Department_id get departmentId => _departmentId;
//   Job_id get jobId => _jobId;
//   Job_grade_id get jobGradeId => _jobGradeId;
//   Salary_level_id get salaryLevelId => _salaryLevelId;
//   double get wage => _wage;
//   String get date => _date;
//   New_company_id get newCompanyId => _newCompanyId;
//   New_branch_id get newBranchId => _newBranchId;
//   New_department_id get newDepartmentId => _newDepartmentId;
//   New_job_id get newJobId => _newJobId;
//   New_job_grade_id get newJobGradeId => _newJobGradeId;
//   New_salary_level_id get newSalaryLevelId => _newSalaryLevelId;
//   double get newWage => _newWage;
//   dynamic get note => _note;
//   String get state => _state;

//   Employee_promotion({
//       int id = 0, 
//       String name = '', 
//       String type = '', 
//       required Employee_id employeeId, 
//       required Company_id companyId, 
//       required Branch_id branchId, 
//       required Department_id departmentId, 
//       required Job_id jobId, 
//       required Job_grade_id jobGradeId, 
//       required Salary_level_id salaryLevelId, 
//       double wage = 0.0, 
//       String date = '', 
//       required New_company_id newCompanyId, 
//       required New_branch_id newBranchId, 
//       required New_department_id newDepartmentId, 
//       required New_job_id newJobId, 
//       required New_job_grade_id newJobGradeId, 
//       required New_salary_level_id newSalaryLevelId, 
//       double newWage = 0.0, 
//       dynamic note}){
//     _id = id;
//     _name = name;
//     _type = type;
//     _employeeId = employeeId;
//     _companyId = companyId;
//     _branchId = branchId;
//     _departmentId = departmentId;
//     _jobId = jobId;
//     _jobGradeId = jobGradeId;
//     _salaryLevelId = salaryLevelId;
//     _wage = wage;
//     _date = date;
//     _newCompanyId = newCompanyId;
//     _newBranchId = newBranchId;
//     _newDepartmentId = newDepartmentId;
//     _newJobId = newJobId;
//     _newJobGradeId = newJobGradeId;
//     _newSalaryLevelId = newSalaryLevelId;
//     _newWage = newWage;
//     _note = note;
// }

//   Employee_promotion.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _type = json["type"];
//     _employeeId = json["employee_id"] != null ? Employee_id.fromJson(json["employee_id"]) : null;
//     _companyId = json["company_id"] != null ? Company_id.fromJson(json["company_id"]) : null;
//     _branchId = json["branch_id"] != null ? Branch_id.fromJson(json["branch_id"]) : null;
//     _departmentId = json["department_id"] != null ? Department_id.fromJson(json["department_id"]) : null;
//     _jobId = json["job_id"] != null ? Job_id.fromJson(json["job_id"]) : null;
//     _jobGradeId = json["job_grade_id"] != null ? Job_grade_id.fromJson(json["job_grade_id"]) : null;
//     _salaryLevelId = json["salary_level_id"] != null ? Salary_level_id.fromJson(json["salary_level_id"]) : null;
//     _wage = json["wage"];
//     _date = json["date"];
//     _newCompanyId = json["new_company_id"] != null ? New_company_id.fromJson(json["new_company_id"]) : null;
//     _newBranchId = json["new_branch_id"] != null ? New_branch_id.fromJson(json["new_branch_id"]) : null;
//     _newDepartmentId = json["new_department_id"] != null ? New_department_id.fromJson(json["new_department_id"]) : null;
//     _newJobId = json["new_job_id"] != null ? New_job_id.fromJson(json["new_job_id"]) : null;
//     _newJobGradeId = json["new_job_grade_id"] != null ? New_job_grade_id.fromJson(json["new_job_grade_id"]) : null;
//     _newSalaryLevelId = json["new_salary_level_id"] != null ? New_salary_level_id.fromJson(json["new_salary_level_id"]) : null;
//     _newWage = json["new_wage"];
//     _note = json["note"];
//     _state = json["state"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["type"] = _type;
//     if (_employeeId != null) {
//       map["employee_id"] = _employeeId.toJson();
//     }
//     if (_companyId != null) {
//       map["company_id"] = _companyId.toJson();
//     }
//     if (_branchId != null) {
//       map["branch_id"] = _branchId.toJson();
//     }
//     if (_departmentId != null) {
//       map["department_id"] = _departmentId.toJson();
//     }
//     if (_jobId != null) {
//       map["job_id"] = _jobId.toJson();
//     }
//     if (_jobGradeId != null) {
//       map["job_grade_id"] = _jobGradeId.toJson();
//     }
//     if (_salaryLevelId != null) {
//       map["salary_level_id"] = _salaryLevelId.toJson();
//     }
//     map["wage"] = _wage;
//     map["date"] = _date;
//     if (_newCompanyId != null) {
//       map["new_company_id"] = _newCompanyId.toJson();
//     }
//     if (_newBranchId != null) {
//       map["new_branch_id"] = _newBranchId.toJson();
//     }
//     if (_newDepartmentId != null) {
//       map["new_department_id"] = _newDepartmentId.toJson();
//     }
//     if (_newJobId != null) {
//       map["new_job_id"] = _newJobId.toJson();
//     }
//     if (_newJobGradeId != null) {
//       map["new_job_grade_id"] = _newJobGradeId.toJson();
//     }
//     if (_newSalaryLevelId != null) {
//       map["new_salary_level_id"] = _newSalaryLevelId.toJson();
//     }
//     map["new_wage"] = _newWage;
//     map["note"] = _note;
//     return map;
//   }

// }




class Employee_promotion {
  int id;
  String name;
  String type;
  Employee_id employeeId;
  Company_id companyId;
  Branch_id branchId;
  Department_id departmentId;
  Job_id jobId;
  Job_grade_id jobGradeId;
  Salary_level_id salaryLevelId;
  double wage;
  String date;
  New_company_id newCompanyId;
  New_branch_id newBranchId;
  New_department_id newDepartmentId;
  New_job_id newJobId;
  New_job_grade_id newJobGradeId;
  New_salary_level_id newSalaryLevelId;
  double newWage;
  dynamic note;
  String state;
  Employee_promotion(
      {this.id = 0,
      this.name = '',
      this.type = '',
      required this.employeeId,
      required this.companyId,
      required this.branchId,
      required this.departmentId,
      required this.jobId,
      required this.jobGradeId,
      required this.salaryLevelId,
      this.wage = 0.0,
      this.date = '',
      required this.newCompanyId,
      required this.newBranchId,
      required this.newDepartmentId,
      required this.newJobId,
      required this.newJobGradeId,
      required this.newSalaryLevelId,
      this.newWage = 0.0,
      required this.note,
      this.state = ''});

  Employee_promotion copyWith({
  int? id,
  String? name,
  String? type,
  Employee_id? employeeId,
  Company_id? companyId,
  Branch_id? branchId,
  Department_id? departmentId,
  Job_id? jobId,
  Job_grade_id? jobGradeId,
  Salary_level_id? salaryLevelId,
  double? wage,
  String? date,
  New_company_id? newCompanyId,
  New_branch_id? newBranchId,
  New_department_id? newDepartmentId,
  New_job_id? newJobId,
  New_job_grade_id? newJobGradeId,
  New_salary_level_id? newSalaryLevelId,
  double? newWage,
  dynamic? note,
  String? state
  }) {
    return Employee_promotion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      employeeId: employeeId ?? this.employeeId,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      departmentId: departmentId ?? this.departmentId,
      jobId: jobId ?? this.jobId,
      jobGradeId: jobGradeId ?? this.jobGradeId,
      salaryLevelId: salaryLevelId ?? this.salaryLevelId,
      wage: wage ?? this.wage,
      date: date ?? this.date,
      newCompanyId: newCompanyId ?? this.newCompanyId,
      newBranchId: newBranchId ?? this.newBranchId,
      newDepartmentId: newDepartmentId ?? this.newDepartmentId,
      newJobId: newJobId ?? this.newJobId,
      newJobGradeId: newJobGradeId ?? this.newJobGradeId,
      newSalaryLevelId: newSalaryLevelId ?? this.newSalaryLevelId,
      newWage: newWage ?? this.newWage,
      note: note ?? this.note,
      state: state ?? this.state
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'employee_id': employeeId?.toMap(),
      'company_id': companyId?.toMap(),
      'branch_id': branchId?.toMap(),
      'department_id': departmentId?.toMap(),
      'job_id': jobId?.toMap(),
      'job_grade_id': jobGradeId?.toMap(),
      'salary_level_id': salaryLevelId?.toMap(),
      'wage': wage,
      'date': date,
      'new_company_id': newCompanyId?.toMap(),
      'new_branch_id': newBranchId?.toMap(),
      'new_department_id': newDepartmentId?.toMap(),
      'new_job_id': newJobId?.toMap(),
      'new_job_grade_id': newJobGradeId?.toMap(),
      'new_salary_level_id': newSalaryLevelId?.toMap(),
      'new_wage': newWage,
      'note': note,
      'state': state,
    };
  }

  factory Employee_promotion.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_promotion(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      employeeId: Employee_id.fromMap(map['employee_id']),
      companyId: Company_id.fromMap(map['company_id']),
      branchId: Branch_id.fromMap(map['branch_id']),
      departmentId: Department_id.fromMap(map['department_id']),
      jobId: Job_id.fromMap(map['job_id']),
      jobGradeId: Job_grade_id.fromMap(map['job_grade_id']),
      salaryLevelId: Salary_level_id.fromMap(map['salary_level_id']),
      wage: map['wage'],
      date: map['date'],
      newCompanyId: New_company_id.fromMap(map['new_company_id']),
      newBranchId: New_branch_id.fromMap(map['new_branch_id']),
      newDepartmentId: New_department_id.fromMap(map['new_department_id']),
      newJobId: New_job_id.fromMap(map['new_job_id']),
      newJobGradeId: New_job_grade_id.fromMap(map['new_job_grade_id']),
      newSalaryLevelId: New_salary_level_id.fromMap(map['new_salary_level_id']),
      newWage: map['new_wage'],
      note: map['note'],
      state: map['state']
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_promotion.fromJson(String source) =>
      Employee_promotion.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee_promotion(id: $id, name: $name, type: $type, employeeId: $employeeId, companyId: $companyId, branchId: $branchId, departmentId: $departmentId, jobId: $jobId, jobGradeId: $jobGradeId, salaryLevelId: $salaryLevelId, wage: $wage, date: $date, newCompanyId: $newCompanyId, newBranchId: $newBranchId, newDepartmentId: $newDepartmentId, newJobId: $newJobId, newJobGradeId: $newJobGradeId, newSalaryLevelId: $newSalaryLevelId, newWage: $newWage, note: $note, state: $state)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_promotion &&
        o.id == id &&
        o.name == name &&
        o.type == type &&
        o.employeeId == employeeId &&
        o.companyId == companyId &&
        o.branchId == branchId &&
        o.departmentId == departmentId &&
        o.jobId == jobId &&
        o.jobGradeId == jobGradeId &&
        o.salaryLevelId == salaryLevelId && 
        o.wage == wage &&
        o.date == date &&
        o.newCompanyId == newCompanyId &&
        o.newBranchId == newBranchId &&
        o.newDepartmentId == newDepartmentId &&
        o.newJobId == newJobId &&
        o.newJobGradeId == newJobGradeId &&
        o.newSalaryLevelId == newSalaryLevelId &&
        o.newWage == newWage &&
        o.note == note &&
        o.state == state;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        employeeId.hashCode ^
        companyId.hashCode ^
        branchId.hashCode ^
        departmentId.hashCode ^
        jobId.hashCode ^
        jobGradeId.hashCode ^
        salaryLevelId.hashCode ^
        wage.hashCode ^
        date.hashCode ^
        newCompanyId.hashCode ^
        newBranchId.hashCode ^
        newDepartmentId.hashCode ^
        newJobGradeId.hashCode ^
        newJobId.hashCode ^
        newWage.hashCode ^
        note.hashCode ^
        state.hashCode;
  }
}

/// id : 12
/// name : "L-11"

class New_salary_level_id {
  final int id;
  final String name;
  New_salary_level_id({
    this.id = 0,
    this.name = '',
  });

  New_salary_level_id copyWith({
    int? id,
    String? name,
  }) {
    return New_salary_level_id(
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

  factory New_salary_level_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return New_salary_level_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory New_salary_level_id.fromJson(String source) =>
      New_salary_level_id.fromMap(json.decode(source));

  @override
  String toString() => 'New_salary_level_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is New_salary_level_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 5
/// name : "G-02"

class New_job_grade_id {
  final int id;
  final String name;
  New_job_grade_id({
    this.id = 0,
    this.name = '',
  });

  New_job_grade_id copyWith({
    int? id,
    String? name,
  }) {
    return New_job_grade_id(
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

  factory New_job_grade_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return New_job_grade_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory New_job_grade_id.fromJson(String source) =>
      New_job_grade_id.fromMap(json.decode(source));

  @override
  String toString() => 'New_job_grade_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is New_job_grade_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
/// id : 1332
/// name : "Fleet Incharge"

class New_job_id {
  final int id;
  final String name;
  New_job_id({
    this.id = 0,
    this.name = '',
  });

  New_job_id copyWith({
    int? id,
    String? name,
  }) {
    return New_job_id(
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

  factory New_job_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return New_job_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory New_job_id.fromJson(String source) =>
      New_job_id.fromMap(json.decode(source));

  @override
  String toString() => 'New_job_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is New_job_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 493
/// name : "OFFICE FLEET TEAM"


class New_department_id {
  final int id;
  final String name;
  New_department_id({
    this.id = 0,
    this.name = '',
  });

  New_department_id copyWith({
    int? id,
    String? name,
  }) {
    return New_department_id(
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

  factory New_department_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return New_department_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory New_department_id.fromJson(String source) =>
      New_department_id.fromMap(json.decode(source));

  @override
  String toString() => 'New_job_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is New_department_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class New_branch_id {
  final int id;
  final String name;
  New_branch_id({
    this.id = 0,
    this.name = '',
  });

  New_branch_id copyWith({
    int? id,
    String? name,
  }) {
    return New_branch_id(
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

  factory New_branch_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return New_branch_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory New_branch_id.fromJson(String source) =>
      New_branch_id.fromMap(json.decode(source));

  @override
  String toString() => 'New_branch_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is New_branch_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}


/// id : 36
/// name : "WB BO SITE"



/// id : 11
/// name : "WIN BROTHERS BACK OFFICE GROUP"

class New_company_id {
  final int id;
  final String name;
  New_company_id({
    this.id = 0,
    this.name = '',
  });

  New_company_id copyWith({
    int? id,
    String? name,
  }) {
    return New_company_id(
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

  factory New_company_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return New_company_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory New_company_id.fromJson(String source) =>
      New_company_id.fromMap(json.decode(source));

  @override
  String toString() => 'New_company_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is New_company_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 7
/// name : "L-06"

class Salary_level_id {
  final int id;
  final String name;
  Salary_level_id({
    this.id = 0,
    this.name = '',
  });

  Salary_level_id copyWith({
    int? id,
    String? name,
  }) {
    return Salary_level_id(
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

  factory Salary_level_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Salary_level_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Salary_level_id.fromJson(String source) =>
      Salary_level_id.fromMap(json.decode(source));

  @override
  String toString() => 'Salary_level_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Salary_level_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 5
/// name : "G-02"

class Job_grade_id {
  final int id;
  final String name;
  Job_grade_id({
    this.id = 0,
    this.name = '',
  });

  Job_grade_id copyWith({
    int? id,
    String? name,
  }) {
    return Job_grade_id(
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

  factory Job_grade_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Job_grade_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Job_grade_id.fromJson(String source) =>
      Job_grade_id.fromMap(json.decode(source));

  @override
  String toString() => 'Job_grade_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Job_grade_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}



/// id : 1332
/// name : "Fleet Incharge"

class Job_id {
  final int id;
  final String name;
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
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Job_id.fromJson(String source) =>
      Job_id.fromMap(json.decode(source));

  @override
  String toString() => 'Job_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Job_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}



/// id : 493
/// name : "OFFICE FLEET TEAM"

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

/// id : 36
/// name : "WB BO SITE"

class Branch_id {
  final int id;
  final String name;
  Branch_id({
    this.id = 0,
    this.name = '',
  });

  Branch_id copyWith({
    int? id,
    String? name,
  }) {
    return Branch_id(
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

  factory Branch_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Branch_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch_id.fromJson(String source) =>
      Branch_id.fromMap(json.decode(source));

  @override
  String toString() => 'Branch_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Branch_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 11
/// name : "WIN BROTHERS BACK OFFICE GROUP"

class Company_id {
  final int id;
  final String name;
  Company_id({
    this.id = 0,
    this.name = '',
  });

  Company_id copyWith({
    int? id,
    String? name,
  }) {
    return Company_id(
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

  factory Company_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Company_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Company_id.fromJson(String source) =>
      Company_id.fromMap(json.decode(source));

  @override
  String toString() => 'Company_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Company_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 5958
/// name : "Lin Zaw Oo"

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