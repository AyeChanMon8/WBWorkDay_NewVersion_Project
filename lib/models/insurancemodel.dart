import 'dart:convert';

/// id : 1
/// employee_id : {"id":6115,"name":"Ahr Yu"}
/// premium_amount : 1000000.0
/// insurance_type_id : {"id":2}
/// coverage_amount : 1000000.0
/// policy_number : 10
/// fees_employee : 100000.0
/// benefit : "Health care"
/// fees_employer : 100000.0
/// effective_date : "2021-03-01"
/// installment : 10
/// expire_date : "2022-02-01"
/// deduction_per_month : 100000.0
/// insurance_lines : [{"date":"2021-03-01","state":"open","amount":100000.0},{"date":"2021-04-01","state":"open","amount":100000.0},{"date":"2021-05-01","state":"open","amount":100000.0},{"date":"2021-06-01","state":"open","amount":100000.0},{"date":"2021-07-01","state":"open","amount":100000.0},{"date":"2021-08-01","state":"open","amount":100000.0},{"date":"2021-09-01","state":"open","amount":100000.0},{"date":"2021-10-01","state":"open","amount":100000.0},{"date":"2021-11-01","state":"open","amount":100000.0},{"date":"2021-12-01","state":"open","amount":100000.0}]
/// total_amount : 1000000.0
/// total_paid_amount : 0.0
/// balance_amount : 1000000.0

class Insurancemodel {
  int id;
  Employee_id? employeeId;
  double premiumAmount;
  Insurance_type_id? insuranceTypeId;
  double coverageAmount;
  int policyNumber;
  double feesEmployee;
  String benefit;
  double feesEmployer;
  String effectiveDate;
  int installment;
  String expireDate;
  double deductionPerMonth;
  List<Insurance_lines>? insuranceLines;
  double totalAmount;
  double totalPaidAmount;
  double balanceAmount;
  String name;
  String poilcy_coverage;
  String state;
  Insurancemodel(
      {this.id = 0,
      this.employeeId,
      this.premiumAmount = 0.0,
      this.insuranceTypeId,
      this.coverageAmount = 0.0,
      this.policyNumber = 0,
      this.feesEmployee = 0.0,
      this.benefit = '',
      this.feesEmployer = 0.0,
      this.effectiveDate = '',
      this.installment = 0,
      this.expireDate = '',
      this.deductionPerMonth = 0.0,
      this.insuranceLines,
      this.totalAmount = 0.0,
      this.totalPaidAmount = 0.0,
      this.balanceAmount = 0.0,
      this.name = '',
      this.poilcy_coverage = '',
      this.state = ''});

  Insurancemodel copyWith({
    int? id,
    Employee_id? employeeId,
    double? premiumAmount,
    Insurance_type_id? insuranceTypeId,
    double? coverageAmount,
    int? policyNumber,
    double? feesEmployee,
    String? benefit,
    double? feesEmployer,
    String? effectiveDate,
    int? installment,
    String? expireDate,
    double? deductionPerMonth,
    List<Insurance_lines>? insuranceLines,
    double? totalAmount,
    double? totalPaidAmount,
    double? balanceAmount,
    String? name,
    String? poilcy_coverage,
    String? state,
  }) {
    return Insurancemodel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      premiumAmount: premiumAmount ?? this.premiumAmount,
      insuranceTypeId: insuranceTypeId ?? this.insuranceTypeId,
      coverageAmount: coverageAmount ?? this.coverageAmount,
      policyNumber: policyNumber ?? this.policyNumber,
      feesEmployee: feesEmployee ?? this.feesEmployee,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      installment: installment ?? this.installment,
      expireDate: expireDate ?? this.expireDate,
      deductionPerMonth: deductionPerMonth ?? this.deductionPerMonth,
      insuranceLines: insuranceLines ?? this.insuranceLines,
      totalAmount: totalAmount ?? this.totalAmount,
      totalPaidAmount: totalPaidAmount ?? this.totalPaidAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      name: name ?? this.name,
      poilcy_coverage: poilcy_coverage ?? this.poilcy_coverage,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId?.toMap(),
      'premium_amount': premiumAmount,
      'insurance_type_id': insuranceTypeId?.toMap(),
      'coverage_amount': coverageAmount,
      'policy_number': policyNumber,
      'fees_employee': feesEmployee,
      'effective_date': effectiveDate,
      'installment': installment,
      'expire_date': expireDate,
      'deduction_per_month': deductionPerMonth,
      'insurance_lines': insuranceLines?.map((x) => x?.toMap())?.toList(),
      'total_amount': totalAmount,
      'total_paid_amount': totalPaidAmount,
      'balance_amount': balanceAmount,
      'name': name,
      'poilcy_coverage': poilcy_coverage,
      'state': state,
    };
  }

  factory Insurancemodel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Insurancemodel(
      id: map['id'],
      employeeId: Employee_id.fromMap(map['employee_id']),
      premiumAmount: map['premium_amount'],
      insuranceTypeId: Insurance_type_id.fromMap(map['insurance_type_id']),
      coverageAmount: map['coverage_amount'],
      policyNumber: map['policy_number'],
      feesEmployee: map['fees_employee'],
      effectiveDate: map['effective_date'],
      installment: map['installment'],
      expireDate: map['expireDate'] ?? '',
      deductionPerMonth: map['deduction_per_month'],
      insuranceLines: List<Insurance_lines>.from(
          map['insurance_lines']?.map((x) => Insurance_lines.fromMap(x))),
      totalAmount: map['total_amount'] ?? 0.0,
      totalPaidAmount: map['total_paid_amount'] ?? 0.0,
      balanceAmount: map['balance_amount'] ?? 0.0,
      name: map['name'] ?? '',
      poilcy_coverage: map['poilcy_coverage'] ?? '',
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Insurancemodel.fromJson(String source) =>
      Insurancemodel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Insurancemodel(id: $id, employeeId: $employeeId, premiumAmount: $premiumAmount,insuranceTypeId: $insuranceTypeId, coverageAmount: $coverageAmount, policyNumber: $policyNumber,feesEmployee: $feesEmployee, effectiveDate: $effectiveDate, installment: $installment,expireDate: $expireDate, deductionPerMonth: $deductionPerMonth, insuranceLines: $insuranceLines,totalAmount: $totalAmount, totalPaidAmount: $totalPaidAmount, balanceAmount: $balanceAmount,name: $name, poilcy_coverage: $poilcy_coverage, state: $state)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Insurancemodel &&
        o.id == id &&
        o.employeeId == employeeId &&
        o.premiumAmount == premiumAmount &&
        o.insuranceTypeId == insuranceTypeId &&
        o.coverageAmount == coverageAmount &&
        o.policyNumber == policyNumber &&
        o.feesEmployee == feesEmployee &&
        o.effectiveDate == effectiveDate &&
        o.installment == installment &&
        o.expireDate == expireDate &&
        o.deductionPerMonth == deductionPerMonth &&
        o.insuranceLines == insuranceLines &&
        o.totalAmount == totalAmount &&
        o.totalPaidAmount == totalPaidAmount &&
        o.balanceAmount == balanceAmount &&
        o.name == name &&
        o.poilcy_coverage == poilcy_coverage &&
        o.state == state;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      employeeId.hashCode ^
      premiumAmount.hashCode ^
      insuranceTypeId.hashCode ^
      coverageAmount.hashCode ^
      policyNumber.hashCode ^
      feesEmployee.hashCode ^
      effectiveDate.hashCode ^
      installment.hashCode ^
      expireDate.hashCode ^
      deductionPerMonth.hashCode ^
      insuranceLines.hashCode ^
      totalAmount.hashCode ^
      totalPaidAmount.hashCode ^
      balanceAmount.hashCode ^
      name.hashCode ^
      poilcy_coverage.hashCode ^
      state.hashCode;
}

// class Insurancemodel {
//   int _id;
//   Employee_id _employeeId;
//   double _premiumAmount;
//   Insurance_type_id _insuranceTypeId;
//   double _coverageAmount;
//   int _policyNumber;
//   double _feesEmployee;
//   String _benefit;
//   double _feesEmployer;
//   String _effectiveDate;
//   int _installment;
//   String _expireDate;
//   double _deductionPerMonth;
//   List<Insurance_lines> _insuranceLines;
//   double _totalAmount;
//   double _totalPaidAmount;
//   double _balanceAmount;
//   String _name;
//   String _poilcy_coverage;
//   String _state;

//   int get id => _id;
//   Employee_id get employeeId => _employeeId;
//   double get premiumAmount => _premiumAmount;
//   Insurance_type_id get insuranceTypeId => _insuranceTypeId;
//   double get coverageAmount => _coverageAmount;
//   int get policyNumber => _policyNumber;
//   double get feesEmployee => _feesEmployee;
//   String get benefit => _benefit;
//   double get feesEmployer => _feesEmployer;
//   String get effectiveDate => _effectiveDate;
//   int get installment => _installment;
//   String get expireDate => _expireDate;
//   double get deductionPerMonth => _deductionPerMonth;
//   List<Insurance_lines> get insuranceLines => _insuranceLines;
//   double get totalAmount => _totalAmount;
//   double get totalPaidAmount => _totalPaidAmount;
//   double get balanceAmount => _balanceAmount;
//   String get name => _name;
//   String get poilcy_coverage => _poilcy_coverage;
//   String get state => _state;
//   Insurancemodel(
//       {int id,
//       Employee_id employeeId,
//       double premiumAmount,
//       Insurance_type_id insuranceTypeId,
//       double coverageAmount,
//       int policyNumber,
//       double feesEmployee,
//       String benefit,
//       double feesEmployer,
//       String effectiveDate,
//       int installment,
//       String expireDate,
//       double deductionPerMonth,
//       List<Insurance_lines> insuranceLines,
//       double totalAmount,
//       double totalPaidAmount,
//       double balanceAmount,
//       String state}) {
//     _id = id;
//     _employeeId = employeeId;
//     _premiumAmount = premiumAmount;
//     _insuranceTypeId = insuranceTypeId;
//     _coverageAmount = coverageAmount;
//     _policyNumber = policyNumber;
//     _feesEmployee = feesEmployee;
//     _benefit = benefit;
//     _feesEmployer = feesEmployer;
//     _effectiveDate = effectiveDate;
//     _installment = installment;
//     _expireDate = expireDate;
//     _deductionPerMonth = deductionPerMonth;
//     _insuranceLines = insuranceLines;
//     _totalAmount = totalAmount;
//     _totalPaidAmount = totalPaidAmount;
//     _balanceAmount = balanceAmount;
//     _state = state;
//   }

//   Insurancemodel.fromJson(dynamic json) {
//     _name = json["name"];
//     _id = json["id"];
//     _employeeId = json["employee_id"] != null
//         ? Employee_id.fromJson(json["employee_id"])
//         : null;
//     _premiumAmount = json["premium_amount"];
//     _insuranceTypeId = json["insurance_type_id"] != null
//         ? Insurance_type_id.fromJson(json["insurance_type_id"])
//         : null;
//     _coverageAmount = json["coverage_amount"];
//     _policyNumber = json["policy_number"];
//     _feesEmployee = json["fees_employee"];
//     _benefit = json["benefit"];
//     _feesEmployer = json["fees_employer"];
//     _effectiveDate = json["effective_date"];
//     _installment = json["installment"];
//     _expireDate = json["expire_date"];
//     _deductionPerMonth = json["deduction_per_month"];
//     if (json["insurance_lines"] != null) {
//       _insuranceLines = [];
//       json["insurance_lines"].forEach((v) {
//         _insuranceLines.add(Insurance_lines.fromJson(v));
//       });
//     }
//     _totalAmount = json["total_amount"];
//     _totalPaidAmount = json["total_paid_amount"];
//     _balanceAmount = json["balance_amount"];
//     _poilcy_coverage = json["policy_coverage"];
//     _state = json["state"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     if (_employeeId != null) {
//       map["employee_id"] = _employeeId.toJson();
//     }
//     map["premium_amount"] = _premiumAmount;
//     if (_insuranceTypeId != null) {
//       map["insurance_type_id"] = _insuranceTypeId.toJson();
//     }
//     map["coverage_amount"] = _coverageAmount;
//     map["policy_number"] = _policyNumber;
//     map["fees_employee"] = _feesEmployee;
//     map["benefit"] = _benefit;
//     map["fees_employer"] = _feesEmployer;
//     map["effective_date"] = _effectiveDate;
//     map["installment"] = _installment;
//     map["expire_date"] = _expireDate;
//     map["deduction_per_month"] = _deductionPerMonth;
//     if (_insuranceLines != null) {
//       map["insurance_lines"] = _insuranceLines.map((v) => v.toJson()).toList();
//     }
//     map["total_amount"] = _totalAmount;
//     map["total_paid_amount"] = _totalPaidAmount;
//     map["balance_amount"] = _balanceAmount;
//     map["policy_coverage"] = _poilcy_coverage;
//     map["state"] = _state;
//     return map;
//   }
// }

// /// date : "2021-03-01"
// /// state : "open"
// /// amount : 100000.0

class Insurance_lines {
  String date;
  String state;
  double amount;
  Insurance_lines({this.date = '', this.state = '', this.amount = 0.0});

  Insurance_lines copyWith({int? id, String? policy_type}) {
    return Insurance_lines(
      date: date ?? this.date,
      state: state ?? this.state,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {'date': date, 'state': state, 'amount': amount};
  }

  factory Insurance_lines.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Insurance_lines(
      date: map['date'],
      state: map['state'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Insurance_lines.fromJson(String source) =>
      Insurance_lines.fromMap(json.decode(source));

  @override
  String toString() => 'Insurance_lines(date: $date, state: $state, amount: $amount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Insurance_lines && o.date == date && o.state == state && o.amount == amount;
  }

  @override
  int get hashCode => date.hashCode ^ state.hashCode ^ amount.hashCode;
}

// class Insurance_lines {
//   String _date;
//   String _state;
//   double _amount;

//   String get date => _date;
//   String get state => _state;
//   double get amount => _amount;

//   Insurance_lines({String date, String state, double amount}) {
//     _date = date;
//     _state = state;
//     _amount = amount;
//   }

//   Insurance_lines.fromJson(dynamic json) {
//     _date = json["date"];
//     _state = json["state"];
//     _amount = json["amount"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["date"] = _date;
//     map["state"] = _state;
//     map["amount"] = _amount;
//     return map;
//   }
// }

/// id : 2

class Insurance_type_id {
  int id;
  String policy_type;
  Insurance_type_id({this.id = 0, this.policy_type = ''});

  Insurance_type_id copyWith({int? id, String? policy_type}) {
    return Insurance_type_id(
      id: id ?? this.id,
      policy_type: policy_type ?? this.policy_type,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'policy_type': policy_type};
  }

  factory Insurance_type_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Insurance_type_id(
      id: map['id'] ?? 0,
      policy_type: map['policy_type'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Insurance_type_id.fromJson(String source) =>
      Insurance_type_id.fromMap(json.decode(source));

  @override
  String toString() => 'Insurance_type_id(id: $id, policy_type: $policy_type)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Insurance_type_id && o.id == id && o.policy_type == policy_type;
  }

  @override
  int get hashCode => id.hashCode ^ policy_type.hashCode;
}

// class Insurance_type_id {
//   int _id;
//   String _policy_type;

//   int get id => _id;
//   String get policy_type => _policy_type;

//   Insurance_type_id({int id, String policy_type}) {
//     _id = id;
//     _policy_type = policy_type;
//   }

//   Insurance_type_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _policy_type = json["policy_type"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["policy_type"] = _policy_type;
//     return map;
//   }
// }

/// id : 6115
/// name : "Ahr Yu"

class Employee_id {
  int id;
  String name;
  CompanyID? companyId;
  BranchID? branchId;
  JobID? jobId;
  Employee_id(
      {this.id = 0, this.name = '', this.companyId, this.branchId, this.jobId});

  Employee_id copyWith({
    int? id,
    String? name,
    CompanyID? companyId,
    BranchID? branchId,
    JobID? jobId,
  }) {
    return Employee_id(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      jobId: jobId ?? this.jobId,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 
    'name': name,
    'company_id': companyId?.toMap(),
    'branch_id': branchId?.toMap(),
    'job_id': jobId?.toMap()};
  }

  factory Employee_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_id(
      id: map['id'],
      name: map['name'],
      companyId: CompanyID.fromMap(map['company_id']),
      branchId: BranchID.fromMap(map['branch_id']),
      jobId: JobID.fromMap(map['job_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_id.fromJson(String source) =>
      Employee_id.fromMap(json.decode(source));

  @override
  String toString() => 'Employee_id(id: $id, name: $name,companyId: $companyId, branchId: $branchId,jobId: $jobId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_id && o.id == id && o.name == name && o.companyId == companyId && o.branchId == branchId && o.jobId == jobId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ companyId.hashCode ^ branchId.hashCode ^ jobId.hashCode;
}

// 
class CompanyID {
  int id = 0;
  String name = "";
  CompanyID({
    this.id = 0,
    this.name = '',
  });

  CompanyID copyWith({
    int? id,
    String? name,
  }) {
    return CompanyID(
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
  factory CompanyID.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return CompanyID(
      id: map['id']??0,
      name: map['name']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyID.fromJson(String source) => CompanyID.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyID(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CompanyID &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode;
  }
}


// class CompanyID {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   CompanyID({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   CompanyID.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }

//   @override
//   String toString() {
//     return _name;
//   }
// }

class BranchID {
  int id = 0;
  String name = "";
  BranchID({
    this.id = 0,
    this.name = '',
  });

  BranchID copyWith({
    int? id,
    String? name,
  }) {
    return BranchID(
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
  factory BranchID.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return BranchID(
      id: map['id']??0,
      name: map['name']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchID.fromJson(String source) => BranchID.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BranchID(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is BranchID &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode;
  }
}

// class BranchID {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   BranchID({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   BranchID.fromJson(dynamic json) {
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

class JobID {
  int id = 0;
  String name = "";
  JobID({
    this.id = 0,
    this.name = '',
  });

  JobID copyWith({
    int? id,
    String? name,
  }) {
    return JobID(
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
  factory JobID.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return JobID(
      id: map['id']??0,
      name: map['name']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory JobID.fromJson(String source) => JobID.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JobID(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is JobID &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode;
  }
}

// class JobID {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   JobID({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   JobID.fromJson(dynamic json) {
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
