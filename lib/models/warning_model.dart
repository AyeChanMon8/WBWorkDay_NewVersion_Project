import 'dart:convert';

import '../models/warning_attach_model.dart';

/// id : 39
/// employee_id : [{"id":6115,"name":"Ahr Yu","warning_carried_forward":0.0,"warning_this_year":-3.0,"warning_total":-3.0}]
/// warning_type_id : [{"id":14,"name":"W11_Small Case Workplace/SOP"}]
/// warning_title_id : [{"id":4,"name":"ဂျူတီအဝင်/အထွက် Fingerprint မရိုက်နှိပ်ခြင်း။"}]
/// manager_warning_ids : []
/// temp_lines : []
/// state : "submit"
/// date : "2021-01-07"
/// description : "TESTING 2"
/// mark : -1.0

class Warning_model {
  int id;
  List<Employee_id>? employeeId;
  List<Warning_type_id>? warningTypeId;
  List<Warning_title_id>? warningTitleId;
  //List<dynamic> _managerWarningIds;
  List<ManagerWarning>? managerWarningIds;
  List<WarningAttachModel>? warningAttachId;
  List<dynamic>? tempLines;
  String state;
  String date;
  String description;
  double mark;
  String code;
  Warning_model(
      {this.id = 0,
      this.employeeId,
      this.warningTypeId,
      this.warningTitleId,
      this.managerWarningIds,
      this.warningAttachId,
      this.tempLines,
      this.state = '',
      this.date = '',
      this.description = '',
      this.mark = 0.0,
      this.code = ''});

  Warning_model copyWith(
      {int? id,
      List<Employee_id>? employeeId,
      List<Warning_type_id>? warningTypeId,
      List<Warning_title_id>? warningTitleId,
      //List<dynamic> _managerWarningIds;
      List<ManagerWarning>? managerWarningIds,
      List<WarningAttachModel>? warningAttachId,
      List<dynamic>? tempLines,
      String? state,
      String? date,
      String? description,
      double? mark,
      String? code}) {
    return Warning_model(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      warningTypeId: warningTypeId ?? this.warningTypeId,
      warningTitleId: warningTitleId ?? this.warningTitleId,
      managerWarningIds: managerWarningIds ?? this.managerWarningIds,
      warningAttachId: warningAttachId ?? this.warningAttachId,
      tempLines: tempLines ?? this.tempLines,
      state: state ?? this.state,
      date: date ?? this.date,
      description: description ?? this.description,
      mark: mark ?? this.mark,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId?.map((x) => x?.toMap())?.toList(),
      'warning_type_id': warningTypeId?.map((x) => x?.toMap())?.toList(),
      'warning_title_id': warningTitleId?.map((x) => x?.toMap())?.toList(),
      'manager_warning_ids': managerWarningIds?.map((x) => x?.toMap())?.toList(),
      'warning_attach_id': warningAttachId?.map((x) => x?.toMap())?.toList(),
      'temp_lines': tempLines?.map((x) => x?.toMap())?.toList(),
      'state': state,
      'date': date,
      'description': description,
      'mark': mark,
      'code': code,
      // 'name': name,
    };
  }

  factory Warning_model.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Warning_model(
      id: map['id'],
      employeeId: List<Employee_id>.from(
          map['employee_id']?.map((x) => Employee_id.fromMap(x))),
      warningTypeId: List<Warning_type_id>.from(
          map['warning_type_id']?.map((x) => Warning_type_id.fromMap(x))),
      warningTitleId: List<Warning_title_id>.from(
          map['warning_title_id']?.map((x) => Warning_title_id.fromMap(x))),
      managerWarningIds: List<ManagerWarning>.from(
          map['manager_warning_ids']?.map((x) => ManagerWarning.fromMap(x))),
      warningAttachId: List<WarningAttachModel>.from(
          map['warning_attach_id']?.map((x) => WarningAttachModel.fromMap(x))),
      tempLines: List<dynamic>.from(map['temp_lines']),
      state: map['state'],
      date: map['date'],
      description: map['description'],
      mark: map['mark'],
      code: map['code']??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory Warning_model.fromJson(String source) =>
      Warning_model.fromMap(json.decode(source));

  @override
  String toString() =>
      'Warning_model(id: $id, employeeId: $employeeId, warningTypeId: $warningTypeId,warningTitleId: $warningTitleId, managerWarningIds: $managerWarningIds,warningAttachId: $warningAttachId, tempLines: $tempLines, state: $state,date: $date, description: $description,mark: $mark, code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Warning_model &&
        o.id == id &&
        o.employeeId == employeeId &&
        o.warningTypeId == warningTypeId &&
        o.warningTitleId == warningTitleId &&
        o.managerWarningIds == managerWarningIds &&
        o.warningAttachId == warningAttachId &&
        o.tempLines == tempLines &&
        o.state == state &&
        o.date == date &&
        o.description == description &&
        o.mark == mark &&
        o.code == code;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      employeeId.hashCode ^
      warningTypeId.hashCode ^
      warningTitleId.hashCode ^
      managerWarningIds.hashCode ^
      warningAttachId.hashCode ^
      tempLines.hashCode ^
      state.hashCode ^
      date.hashCode ^
      description.hashCode ^
      mark.hashCode ^
      code.hashCode;
}

// class Warning_model {
//   int _id;
//   List<Employee_id> _employeeId;
//   List<Warning_type_id> _warningTypeId;
//   List<Warning_title_id> _warningTitleId;
//   //List<dynamic> _managerWarningIds;
//   List<ManagerWarning> _managerWarningIds;
//   List<WarningAttachModel> _warningAttachId;
//   List<dynamic> _tempLines;
//   String _state;
//   String _date;
//   String _description;
//   double _mark;
//   String _code;

//   int get id => _id;
//   List<Employee_id> get employeeId => _employeeId;
//   List<Warning_type_id> get warningTypeId => _warningTypeId;
//   List<Warning_title_id> get warningTitleId => _warningTitleId;
//   List<ManagerWarning> get managerWarningIds => _managerWarningIds;
//   List<WarningAttachModel> get warningAttachId => _warningAttachId;
//   List<dynamic> get tempLines => _tempLines;
//   String get state => _state;
//   String get date => _date;
//   String get description => _description;
//   double get mark => _mark;
//   String get code => _code;

//   Warning_model(
//       {int id,
//       List<Employee_id> employeeId,
//       List<Warning_type_id> warningTypeId,
//       List<Warning_title_id> warningTitleId,
//       List<dynamic> managerWarningIds,
//       List<dynamic> tempLines,
//       String state,
//       String date,
//       String description,
//       double mark,
//       String code}) {
//     _id = id;
//     _employeeId = employeeId;
//     _warningTypeId = warningTypeId;
//     _warningTitleId = warningTitleId;
//     _managerWarningIds = managerWarningIds;
//     _warningAttachId = warningAttachId;
//     _tempLines = tempLines;
//     _state = state;
//     _date = date;
//     _description = description;
//     _mark = mark;
//     _code = code;
//   }

//   Warning_model.fromJson(dynamic json) {
//     _id = json["id"];
//     if (json["employee_id"] != null) {
//       _employeeId = [];
//       json["employee_id"].forEach((v) {
//         _employeeId.add(Employee_id.fromJson(v));
//       });
//     }
//     if (json["warning_type_id"] != null) {
//       _warningTypeId = [];
//       json["warning_type_id"].forEach((v) {
//         _warningTypeId.add(Warning_type_id.fromJson(v));
//       });
//     }
//     if (json["warning_title_id"] != null) {
//       _warningTitleId = [];
//       json["warning_title_id"].forEach((v) {
//         _warningTitleId.add(Warning_title_id.fromJson(v));
//       });
//     }
//     if (json["manager_warning_ids"] != null) {
//       _managerWarningIds = [];
//       json["manager_warning_ids"].forEach((v) {
//         _managerWarningIds.add(ManagerWarning.fromJson(v));
//       });
//     }
//     if (json["warning_attach_id"] != null) {
//       _warningAttachId = [];
//       json["warning_attach_id"].forEach((v) {
//         _warningAttachId.add(WarningAttachModel.fromMap(v));
//       });
//     }
//     // if (json["temp_lines"] != null) {
//     //   _tempLines = [];
//     //   json["temp_lines"].forEach((v) {
//     //     _tempLines.add(dynamic.fromJson(v));
//     //   });
//     // }
//     _state = json["state"];
//     _date = json["date"];
//     _description = json["description"];
//     _mark = json["mark"];
//     _code = json["name"] == null ? '' : json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     if (_employeeId != null) {
//       map["employee_id"] = _employeeId.map((v) => v.toJson()).toList();
//     }
//     if (_warningTypeId != null) {
//       map["warning_type_id"] = _warningTypeId.map((v) => v.toJson()).toList();
//     }
//     if (_warningTitleId != null) {
//       map["warning_title_id"] = _warningTitleId.map((v) => v.toJson()).toList();
//     }
//     if (_managerWarningIds != null) {
//       map["manager_warning_ids"] =
//           _managerWarningIds.map((v) => v.toJson()).toList();
//     }
//     if (_warningAttachId != null) {
//       map["warning_attach_id"] =
//           _warningAttachId.map((v) => v.toMap()).toList();
//     }
//     if (_tempLines != null) {
//       map["temp_lines"] = _tempLines.map((v) => v.toJson()).toList();
//     }
//     map["state"] = _state;
//     map["date"] = _date;
//     map["description"] = _description;
//     map["mark"] = _mark;
//     map["name"] = _code;
//     return map;
//   }
// }

/// id : 4
/// name : "ဂျူတီအဝင်/အထွက် Fingerprint မရိုက်နှိပ်ခြင်း။"

class Warning_title_id {
  final int id;
  final String name;
  Warning_title_id({
    this.id = 0,
    this.name = '',
  });

  Warning_title_id copyWith({
    int? id,
    String? name,
  }) {
    return Warning_title_id(
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

  factory Warning_title_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Warning_title_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Warning_title_id.fromJson(String source) =>
      Warning_title_id.fromMap(json.decode(source));

  @override
  String toString() => 'Warning_title_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Warning_title_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
// class Warning_title_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Warning_title_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Warning_title_id.fromJson(dynamic json) {
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

class ManagerWarning {
  Warning_title_id? employee;
  double mark;
  ManagerWarning({
    this.employee,
    this.mark = 0.0,
  });

  ManagerWarning copyWith({
    Warning_title_id? employee,
  double? mark,
  }) {
    return ManagerWarning(
      employee: employee ?? this.employee,
      mark: mark ?? this.mark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee?.toMap(),
      'mark': mark,
    };
  }

  factory ManagerWarning.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ManagerWarning(
      employee: Warning_title_id.fromMap(map['employee_id']),
      mark: map['mark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerWarning.fromJson(String source) =>
      ManagerWarning.fromMap(json.decode(source));

  @override
  String toString() => 'ManagerWarning(employee: $employee, mark: $mark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ManagerWarning && o.employee == employee && o.mark == mark;
  }

  @override
  int get hashCode => employee.hashCode ^ mark.hashCode;
}
// class ManagerWarning {
//   Warning_title_id _employee;
//   double _mark;

//   Warning_title_id get employee => _employee;
//   double get mark => _mark;

//   ManagerWarning({Warning_title_id employee, double mark}) {
//     _employee = employee;
//     _mark = mark;
//   }

//   ManagerWarning.fromJson(dynamic json) {
//     _employee = Warning_title_id.fromJson(json["employee_id"]);
//     _mark = json["mark"] == null ? 0.0 : json["mark"];
//   }
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["employee_id"] = _employee;
//     map["mark"] = _mark;

//     return map;
//   }
// }

/// id : 14
/// name : "W11_Small Case Workplace/SOP"

class Warning_type_id {
  final int id;
  final String name;
  Warning_type_id({
    this.id = 0,
    this.name = '',
  });

  Warning_type_id copyWith({
    int? id,
    String? name,
  }) {
    return Warning_type_id(
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

  factory Warning_type_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Warning_type_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Warning_type_id.fromJson(String source) =>
      Warning_type_id.fromMap(json.decode(source));

  @override
  String toString() => 'Warning_type_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Warning_type_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}


// class Warning_type_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Warning_type_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Warning_type_id.fromJson(dynamic json) {
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

/// id : 6115
/// name : "Ahr Yu"
/// warning_carried_forward : 0.0
/// warning_this_year : -3.0
/// warning_total : -3.0

class Employee_id {
  int id;
  String name;
  double warningCarriedForward;
  double warningThisYear;
  double warningTotal;
  Employee_id({
    this.id = 0,
    this.name = '',
    this.warningCarriedForward = 0.0,
    this.warningThisYear = 0.0,
    this.warningTotal = 0.0,
  });

  Employee_id copyWith({
    int? id,
  String? name,
  double? warningCarriedForward,
  double? warningThisYear,
  double? warningTotal,
  }) {
    return Employee_id(
      id: id ?? this.id,
      name: name ?? this.name,
      warningCarriedForward: warningCarriedForward ?? this.warningCarriedForward,
      warningThisYear: warningThisYear ?? this.warningThisYear,
      warningTotal: warningTotal ?? this.warningTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'warning_carried_forward': warningCarriedForward,
      'warning_this_year': warningThisYear,
      'warning_total': warningTotal,
    };
  }

  factory Employee_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_id(
      id: map['id'],
      name: map['name'],
      warningCarriedForward: map['warning_carried_forward'],
      warningThisYear: map['warning_this_year'],
      warningTotal: map['warning_total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_id.fromJson(String source) =>
      Employee_id.fromMap(json.decode(source));

  @override
  String toString() => 'Employee_id(id: $id, name: $name,warningCarriedForward: $warningCarriedForward, warningThisYear: $warningThisYear, warningTotal: $warningTotal)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_id && o.id == id && o.name == name && o.warningCarriedForward == warningCarriedForward && o.warningThisYear == warningThisYear && o.warningTotal == warningTotal;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ warningCarriedForward.hashCode ^ warningThisYear.hashCode ^ warningTotal.hashCode;
}

// class Employee_id {
//   int _id;
//   String _name;
//   double _warningCarriedForward;
//   double _warningThisYear;
//   double _warningTotal;

//   int get id => _id;
//   String get name => _name;
//   double get warningCarriedForward => _warningCarriedForward;
//   double get warningThisYear => _warningThisYear;
//   double get warningTotal => _warningTotal;

//   Employee_id(
//       {int id,
//       String name,
//       double warningCarriedForward,
//       double warningThisYear,
//       double warningTotal}) {
//     _id = id;
//     _name = name;
//     _warningCarriedForward = warningCarriedForward;
//     _warningThisYear = warningThisYear;
//     _warningTotal = warningTotal;
//   }

//   Employee_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _warningCarriedForward = json["warning_carried_forward"];
//     _warningThisYear = json["warning_this_year"];
//     _warningTotal = json["warning_total"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["warning_carried_forward"] = _warningCarriedForward;
//     map["warning_this_year"] = _warningThisYear;
//     map["warning_total"] = _warningTotal;
//     return map;
//   }
// }
