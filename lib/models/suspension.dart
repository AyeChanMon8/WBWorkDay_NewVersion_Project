import 'dart:convert';

class Suspension {
  int id;
  String name;
  Employee_id? employeeId;
  Department_id? departmentId;
  String suspension_reason;
  dynamic? joinedDate;
  String approvedRevealingDate;
  String suspension_submit_date;
  Employee_id? company_id;
  Employee_id? branch_id;
  Job_id? job_id;
  Job_grade_id? job_grade_id;
  Suspension(
      {this.id = 0,
      this.name = '',
      this.employeeId,
      this.departmentId,
      this.suspension_reason = '',
      this.joinedDate,
      this.approvedRevealingDate = '',
      this.suspension_submit_date = '',
      this.company_id,
      this.branch_id,
      this.job_id,
      this.job_grade_id});

  Suspension copyWith(
      {int? id,
      String? name,
      Employee_id? employeeId,
      Department_id? departmentId,
      String? suspension_reason,
      dynamic? joinedDate,
      String? approvedRevealingDate,
      String? suspension_submit_date,
      Employee_id? company_id,
      Employee_id? branch_id,
      Job_id? job_id,
      Job_grade_id? job_grade_id}) {
    return Suspension(
      id: id ?? this.id,
      name: name ?? this.name,
      employeeId: employeeId ?? this.employeeId,
      departmentId: departmentId ?? this.departmentId,
      suspension_reason: suspension_reason ?? this.suspension_reason,
      joinedDate: joinedDate ?? this.joinedDate,
      approvedRevealingDate:
          approvedRevealingDate ?? this.approvedRevealingDate,
      suspension_submit_date:
          suspension_submit_date ?? this.suspension_submit_date,
      company_id: company_id ?? this.company_id,
      branch_id: branch_id ?? this.branch_id,
      job_id: job_id ?? this.job_id,
      job_grade_id: job_grade_id ?? this.job_grade_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employee_id': employeeId?.toMap(),
      'department_id': departmentId?.toMap(),
      'suspension_reason': suspension_reason,
      'joined_date': joinedDate,
      'approved_revealing_date': approvedRevealingDate,
      'company_id': company_id?.toMap(),
      'branch_id': branch_id?.toMap(),
      'job_id': job_id?.toMap(),
      'job_grade_id': job_grade_id?.toMap(),
      // 'name': name,
    };
  }

  factory Suspension.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Suspension(
      id: map['id'],
      name: map['name'],
      employeeId: Employee_id.fromMap(map['employee_id']),
      departmentId: Department_id.fromMap(map['department_id']),
      suspension_reason: map['suspension_reason'],
      joinedDate: map['joined_date'],
      approvedRevealingDate: map['approved_revealing_date'],
      company_id: Employee_id.fromMap(map['company_id']),
      branch_id: Employee_id.fromMap(map['branch_id']),
      job_id: Job_id.fromMap(map['job_id']),
      job_grade_id: Job_grade_id.fromMap(map['job_grade_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Suspension.fromJson(String source) =>
      Suspension.fromMap(json.decode(source));

  @override
  String toString() => 'Suspension(id: $id, name: $name,employeeId: $employeeId, departmentId: $departmentId,suspension_reason: $suspension_reason, joinedDate: $joinedDate,approvedRevealingDate: $approvedRevealingDate, company_id: $company_id, branch_id: $branch_id,job_id: $job_id, job_grade_id: $job_grade_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Suspension && o.id == id && o.name == name
    && o.employeeId == employeeId && o.departmentId == departmentId && o.suspension_reason == suspension_reason && o.joinedDate == joinedDate
    && o.approvedRevealingDate == approvedRevealingDate && o.company_id == company_id && o.branch_id == branch_id && o.job_id == job_id
    && o.job_grade_id == job_grade_id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ employeeId.hashCode ^ departmentId.hashCode
  ^ suspension_reason.hashCode ^ joinedDate.hashCode ^ approvedRevealingDate.hashCode ^ company_id.hashCode ^ branch_id.hashCode ^ job_id.hashCode
  ^ job_grade_id.hashCode;
}

// class Suspension {
//   int _id;
//   String _name;
//   Employee_id _employeeId;
//   Department_id _departmentId;
//   String _suspension_reason;
//   dynamic _joinedDate;
//   String _approvedRevealingDate;
//   String _suspension_submit_date;
//   Employee_id _company_id;
//   Employee_id _branch_id;
//   Job_id _job_id;
//   Job_grade_id _job_grade_id;

//   int get id => _id;
//   String get name => _name;
//   String get suspension_submit_date => _suspension_submit_date;
//   Employee_id get employeeId => _employeeId;
//   Department_id get departmentId => _departmentId;
//   String get suspension_reason => _suspension_reason;
//   dynamic get joinedDate => _joinedDate;
//   String get approvedRevealingDate => _approvedRevealingDate;
//   Employee_id get company_id => _company_id;
//   Employee_id get branch_id => _branch_id;
//   Job_id get job_id => _job_id;
//   Job_grade_id get job_grade_id => _job_grade_id;

//   Suspension({
//     int id,
//     String name,
//     Employee_id employeeId,
//     Department_id departmentId,
//     String employeeContract,
//     String suspension_reason,
//     dynamic joinedDate,
//     String approvedRevealingDate,
//     String suspension_submit_date,
//     Job_id job_id,
//     Job_grade_id job_grade_id,
//   }) {
//     _id = id;
//     _name = name;
//     _employeeId = employeeId;
//     _departmentId = departmentId;
//     _suspension_reason = suspension_reason;
//     _joinedDate = joinedDate;
//     _approvedRevealingDate = approvedRevealingDate;
//     _suspension_submit_date = suspension_submit_date;
//     _job_id = job_id;
//     _job_grade_id = job_grade_id;
//   }

//   Suspension.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _employeeId = json["employee_id"] != null
//         ? Employee_id.fromJson(json["employee_id"])
//         : null;
//     _departmentId = json["department_id"] != null
//         ? Department_id.fromJson(json["department_id"])
//         : null;
//     _suspension_reason = json["suspension_reason"];
//     _joinedDate = json["joined_date"];
//     _approvedRevealingDate = json["approved_revealing_date"];
//     _suspension_submit_date = json["suspension_submit_date"];
//     _company_id = json["company_id"] != null
//         ? Employee_id.fromJson(json["company_id"])
//         : null;
//     _branch_id = json["branch_id"] != null
//         ? Employee_id.fromJson(json["branch_id"])
//         : null;
//     _job_id = json["job_id"] != null ? Job_id.fromJson(json["job_id"]) : null;
//     _job_grade_id = json["job_grade_id"] != null
//         ? Job_grade_id.fromJson(json["job_grade_id"])
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
//     map["suspension_reason"] = _suspension_reason;
//     map["joined_date"] = _joinedDate;
//     map["approved_revealing_date"] = _approvedRevealingDate;
//     map["suspension_submit_date"] = _suspension_submit_date;
//     if (_job_id != null) {
//       map["job_id"] = _job_id?.toJson();
//     }
//     if (_job_grade_id != null) {
//       map["job_grade_id"] = _job_grade_id?.toJson();
//     }
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

// class Job_grade_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Job_grade_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Job_grade_id.fromJson(dynamic json) {
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

// class Job_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Job_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Job_id.fromJson(dynamic json) {
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
