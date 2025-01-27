import 'dart:convert';

import '../models/warning_attach_model.dart';

/// id : 13
/// employee_id : [{"id":6115,"name":"Ahr Yu","reward_carried_forward":0,"reward_this_year":0,"reward_total":0}]
/// reward_type_id : [{"id":5,"name":"R01"}]
/// reward_title_id : [{"id":1,"name":"Full Attendance"}]
/// state : "draft"
/// date : "2021-02-05"
/// description : "Nice."
/// mark : 0

class Reward {
  int id;
  List<Employee_id>? employeeId;
  List<Reward_type_id>? rewardTypeId;
  List<Reward_title_id>? rewardTitleId;
  List<RewardAction>? rewardActionId;
  List<WarningAttachModel>? warningAttachId;
  String state;
  String date;
  String description;
  double mark;
  String code;
  Reward(
      {this.id = 0,
      this.employeeId,
      this.rewardTypeId,
      this.rewardTitleId,
      this.rewardActionId,
      this.warningAttachId,
      this.state = '',
      this.date = '',
      this.description = '',
      this.mark = 0.0,
      this.code = ''});

  Reward copyWith({
    int? id,
    List<Employee_id>? employeeId,
    List<Reward_type_id>? rewardTypeId,
    List<Reward_title_id>? rewardTitleId,
    List<RewardAction>? rewardActionId,
    List<WarningAttachModel>? warningAttachId,
    String? state,
    String? date,
    String? description,
    double? mark,
    String? code,
  }) {
    return Reward(
        id: id ?? this.id,
        employeeId: employeeId ?? this.employeeId,
        rewardTypeId: rewardTypeId ?? this.rewardTypeId,
        rewardTitleId: rewardTitleId ?? this.rewardTitleId,
        rewardActionId: rewardActionId ?? this.rewardActionId,
        warningAttachId: warningAttachId ?? this.warningAttachId,
        state: state ?? this.state,
        date: date ?? this.date,
        description: description ?? this.description,
        mark: mark ?? this.mark,
        code: code ?? this.code);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId?.map((x) => x?.toMap())?.toList(),
      'reward_type_id': rewardTypeId?.map((x) => x?.toMap())?.toList(),
      'reward_title_id': rewardTitleId?.map((x) => x?.toMap())?.toList(),
      'manager_reward_ids': rewardActionId?.map((x) => x?.toMap())?.toList(),
      'warning_attach_id': warningAttachId?.map((x) => x?.toMap())?.toList(),
      'state': state,
      'date': date,
      'description': description,
      'mark': mark,
      'code': code
    };
  }

  factory Reward.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Reward(
      id: map['id'],
      employeeId: List<Employee_id>.from(
          map['employee_id']?.map((x) => Employee_id.fromMap(x))),
      rewardTypeId: List<Reward_type_id>.from(
          map['reward_type_id']?.map((x) => Reward_type_id.fromMap(x))),
      rewardTitleId: List<Reward_title_id>.from(
          map['reward_title_id']?.map((x) => Reward_title_id.fromMap(x))),
      rewardActionId: List<RewardAction>.from(
          map['manager_reward_ids']?.map((x) => RewardAction.fromMap(x))),
      warningAttachId: List<WarningAttachModel>.from(
          map['warning_attach_id']?.map((x) => WarningAttachModel.fromMap(x))),
      state: map['state'],
      date: map['date'],
      description: map['description'],
      mark: map['mark'],
      code: map['code'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Reward.fromJson(String source) => Reward.fromMap(json.decode(source));

  @override
  String toString() =>
      'Reward(id: $id, employeeId: $employeeId,rewardTypeId: $rewardTypeId, rewardTitleId: $rewardTitleId,rewardActionId: $rewardActionId,warningAttachId: $warningAttachId, state: $state,date: $date, description: $description,mark: $mark,code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Reward &&
        o.id == id &&
        o.employeeId == employeeId &&
        o.rewardTypeId == rewardTypeId &&
        o.rewardTitleId == rewardTitleId &&
        o.rewardActionId == rewardActionId &&
        o.warningAttachId == warningAttachId &&
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
      rewardTypeId.hashCode ^
      rewardTitleId.hashCode ^
      rewardActionId.hashCode ^
      warningAttachId.hashCode ^
      state.hashCode ^
      date.hashCode ^
      description.hashCode ^
      mark.hashCode ^
      code.hashCode;
}

// class Reward {
//   int _id;
//   List<Employee_id> _employeeId;
//   List<Reward_type_id> _rewardTypeId;
//   List<Reward_title_id> _rewardTitleId;
//   List<RewardAction> _rewardActionId;
//   List<WarningAttachModel> _warningAttachId;
//   String _state;
//   String _date;
//   String _description;
//   double _mark;
//   String _code;

//   int get id => _id;
//   List<Employee_id> get employeeId => _employeeId;
//   List<Reward_type_id> get rewardTypeId => _rewardTypeId;
//   List<Reward_title_id> get rewardTitleId => _rewardTitleId;
//   List<RewardAction> get rewardActionId => _rewardActionId;
//   List<WarningAttachModel> get warningAttachId => _warningAttachId;
//   String get state => _state;
//   String get date => _date;
//   String get description => _description;
//   double get mark => _mark;
//   String get code => _code;

//   Reward(
//       {int id,
//       List<Employee_id> employeeId,
//       List<Reward_type_id> rewardTypeId,
//       List<Reward_title_id> rewardTitleId,
//       List<RewardAction> rewardActionId,
//       List<WarningAttachModel> warningAttachId,
//       String state,
//       String date,
//       String description,
//       double mark,
//       String code}) {
//     _id = id;
//     _employeeId = employeeId;
//     _rewardTypeId = rewardTypeId;
//     _rewardTitleId = rewardTitleId;
//     _rewardActionId = rewardActionId;
//     _warningAttachId = warningAttachId;
//     _state = state;
//     _date = date;
//     _description = description;
//     _mark = mark;
//     _code = code;
//   }

//   Reward.fromJson(dynamic json) {
//     _id = json["id"];
//     if (json["employee_id"] != null) {
//       _employeeId = [];
//       json["employee_id"].forEach((v) {
//         _employeeId.add(Employee_id.fromJson(v));
//       });
//     }
//     if (json["reward_type_id"] != null) {
//       _rewardTypeId = [];
//       json["reward_type_id"].forEach((v) {
//         _rewardTypeId.add(Reward_type_id.fromJson(v));
//       });
//     }
//     if (json["reward_title_id"] != null) {
//       _rewardTitleId = [];
//       json["reward_title_id"].forEach((v) {
//         _rewardTitleId.add(Reward_title_id.fromJson(v));
//       });
//     }
//     if (json["manager_reward_ids"] != null) {
//       _rewardActionId = [];
//       json["manager_reward_ids"].forEach((v) {
//         _rewardActionId.add(RewardAction.fromJson(v));
//       });
//     }
//     if (json["warning_attach_id"] != null) {
//       _warningAttachId = [];
//       json["warning_attach_id"].forEach((v) {
//         _warningAttachId.add(WarningAttachModel.fromMap(v));
//       });
//     }
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
//     if (_rewardTypeId != null) {
//       map["reward_type_id"] = _rewardTypeId.map((v) => v.toJson()).toList();
//     }
//     if (_rewardTitleId != null) {
//       map["reward_title_id"] = _rewardTitleId.map((v) => v.toJson()).toList();
//     }
//     if (_rewardActionId != null) {
//       map["reward_title_id"] = _rewardActionId.map((v) => v.toJson()).toList();
//     }
//     if (_warningAttachId != null) {
//       map["reward_title_id"] = _warningAttachId.map((v) => v.toJson()).toList();
//     }
//     map["state"] = _state;
//     map["date"] = _date;
//     map["description"] = _description;
//     map["mark"] = _mark;
//     map["name"] = _code;
//     return map;
//   }
// }

class RewardAction {
  Reward_title_id? employee;
  double mark;
  RewardAction({
    this.employee,
    this.mark = 0.0,
  });

  RewardAction copyWith({
    Reward_title_id? employee,
    double? mark,
  }) {
    return RewardAction(
      employee: employee ?? this.employee,
      mark: mark ?? this.mark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee?.toMap(),
      'mark': mark,
      // 'name': name,
    };
  }

  factory RewardAction.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return RewardAction(
      employee: Reward_title_id.fromMap(map['employee_id']),
      mark: map['mark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RewardAction.fromJson(String source) =>
      RewardAction.fromMap(json.decode(source));

  @override
  String toString() => 'RewardAction(employee: $employee, mark: $mark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RewardAction && o.employee == employee && o.mark == mark;
  }

  @override
  int get hashCode => employee.hashCode ^ mark.hashCode;
}

// class RewardAction {
//   Reward_title_id _employee;
//   double _mark;

//   Reward_title_id get employee => _employee;
//   double get mark => _mark;

//   RewardAction({Reward_title_id employee, double mark}) {
//     _employee = employee;
//     _mark = mark;
//   }

//   RewardAction.fromJson(dynamic json) {
//     _employee = Reward_title_id.fromJson(json["employee_id"]);
//     _mark = json["mark"] == null ? 0.0 : json["mark"];
//   }
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["employee_id"] = _employee;
//     map["mark"] = _mark;

//     return map;
//   }
// }

/// id : 1
/// name : "Full Attendance"

class Reward_title_id {
  int id;
  String name;
  Reward_title_id({
    this.id = 0,
    this.name = '',
  });

  Reward_title_id copyWith({int? id, String? name}) {
    return Reward_title_id(
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

  factory Reward_title_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Reward_title_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Reward_title_id.fromJson(String source) =>
      Reward_title_id.fromMap(json.decode(source));

  @override
  String toString() => 'Reward_title_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Reward_title_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Reward_title_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Reward_title_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Reward_title_id.fromJson(dynamic json) {
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

/// id : 5
/// name : "R01"

class Reward_type_id {
  int id;
  String name;
  Reward_type_id({
    this.id = 0,
    this.name = '',
  });

  Reward_type_id copyWith({int? id, String? name}) {
    return Reward_type_id(
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

  factory Reward_type_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Reward_type_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Reward_type_id.fromJson(String source) =>
      Reward_type_id.fromMap(json.decode(source));

  @override
  String toString() => 'Reward_type_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Reward_type_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Reward_type_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Reward_type_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Reward_type_id.fromJson(dynamic json) {
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
/// reward_carried_forward : 0
/// reward_this_year : 0
/// reward_total : 0

class Employee_id {
  int id;
  String name;
  double rewardCarriedForward;
  double rewardThisYear;
  double rewardTotal;
  Employee_id(
      {this.id = 0,
      this.name = '',
      this.rewardCarriedForward = 0.0,
      this.rewardThisYear = 0.0,
      this.rewardTotal = 0.0});

  Employee_id copyWith(
      {int? id,
      String? name,
      double? rewardCarriedForward,
      double? rewardThisYear,
      double? rewardTotal}) {
    return Employee_id(
      id: id ?? this.id,
      name: name ?? this.name,
      rewardCarriedForward: rewardCarriedForward ?? this.rewardCarriedForward,
      rewardThisYear: rewardThisYear ?? this.rewardThisYear,
      rewardTotal: rewardTotal ?? this.rewardTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'reward_carried_forward': rewardCarriedForward,
      'reward_this_year': rewardThisYear,
      'reward_total': rewardTotal,
    };
  }

  factory Employee_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_id(
      id: map['id'],
      name: map['name'],
      rewardCarriedForward: map['reward_carried_forward'],
      rewardThisYear: map['reward_this_year'],
      rewardTotal: map['reward_total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_id.fromJson(String source) =>
      Employee_id.fromMap(json.decode(source));

  @override
  String toString() =>
      'Employee_id(id: $id, name: $name,rewardCarriedForward: $rewardCarriedForward, rewardThisYear: $rewardThisYear,rewardTotal: $rewardTotal)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_id &&
        o.id == id &&
        o.name == name &&
        o.rewardCarriedForward == rewardCarriedForward &&
        o.rewardThisYear == rewardThisYear &&
        o.rewardTotal == rewardTotal;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      rewardCarriedForward.hashCode ^
      rewardThisYear.hashCode ^
      rewardTotal.hashCode;
}

// class Employee_id {
//   int _id;
//   String _name;
//   double _rewardCarriedForward;
//   double _rewardThisYear;
//   double _rewardTotal;

//   int get id => _id;
//   String get name => _name;
//   double get rewardCarriedForward => _rewardCarriedForward;
//   double get rewardThisYear => _rewardThisYear;
//   double get rewardTotal => _rewardTotal;

//   Employee_id(
//       {int id,
//       String name,
//       double rewardCarriedForward,
//       double rewardThisYear,
//       double rewardTotal}) {
//     _id = id;
//     _name = name;
//     _rewardCarriedForward = rewardCarriedForward;
//     _rewardThisYear = rewardThisYear;
//     _rewardTotal = rewardTotal;
//   }

//   Employee_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _rewardCarriedForward = json["reward_carried_forward"];
//     _rewardThisYear = json["reward_this_year"];
//     _rewardTotal = json["reward_total"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["reward_carried_forward"] = _rewardCarriedForward;
//     map["reward_this_year"] = _rewardThisYear;
//     map["reward_total"] = _rewardTotal;
//     return map;
//   }
// }
