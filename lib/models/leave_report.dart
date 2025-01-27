

import 'dart:convert';

class LeaveReport {

  int? id;
  String? create_date;
  String? create_uid;
  String? write_date;
  String? write_uid;
  int? x_employee_id;
  String? x_name;
  String? x_leave_type;
  double? x_entitle;
  double? x_taken;
  double? x_balance;
  LeaveReport({
    this.id,
    this.create_date,
    this.create_uid,
    this.write_date,
    this.write_uid,
    this.x_employee_id,
    this.x_name,
    this.x_leave_type,
    this.x_entitle,
    this.x_taken,
    this.x_balance,
  });

  LeaveReport copyWith({
    int? id,
  String? create_date,
  String? create_uid,
  String? write_date,
  String? write_uid,
  int? x_employee_id,
  String? x_name,
  String? x_leave_type,
  double? x_entitle,
  double? x_taken,
  double? x_balance,
  }) {
    return LeaveReport(
      id: id ?? this.id,
      create_date: create_date ?? this.create_date,
      create_uid: create_uid ?? this.create_uid,
      write_date: write_date ?? this.write_date,
      write_uid: write_uid ?? this.write_uid,
      x_employee_id: x_employee_id ?? this.x_employee_id,
      x_name: x_name ?? this.x_name,
      x_leave_type: x_leave_type ?? this.x_leave_type,
      x_entitle: x_entitle ?? this.x_entitle,
      x_taken: x_taken ?? this.x_taken,
      x_balance: x_balance ?? this.x_balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'create_date': create_date,
      'create_uid': create_uid,
      'write_date': write_date,
      'write_uid': write_uid,
      'x_employee_id': x_employee_id,
      'x_name': x_name,
      'x_leave_type': x_leave_type,
      'x_entitle': x_entitle,
      'x_taken': x_taken,
      'x_balance': x_balance
    };
  }

  factory LeaveReport.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LeaveReport(
      id: map['id'],
      create_date: map['create_date'],
      create_uid: map['create_uid'],
      write_date: map['write_date'],
      write_uid: map['write_uid'],
      x_employee_id: map['x_employee_id'],
      x_name: map['x_name'],
      x_leave_type: map['x_leave_type'],
      x_entitle: map['x_entitle'],
      x_taken: map['x_taken'],
      x_balance: map['x_balance']
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveReport.fromJson(String source) =>
      LeaveReport.fromMap(json.decode(source));

  @override
  String toString() => 'LeaveReport(id: $id, create_date: $create_date,create_uid: $create_uid, write_date: $write_date,write_uid: $write_uid, x_employee_id: $x_employee_id,x_name: $x_name, x_leave_type: $x_leave_type,x_entitle: $x_entitle, x_taken: $x_taken,x_balance: $x_balance)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LeaveReport && o.id == id && o.create_date == create_date && o.create_uid == create_uid
    && o.write_date == write_date && o.write_uid == write_uid && o.x_employee_id == x_employee_id
    && o.x_name == x_name && o.x_leave_type == x_leave_type && o.x_entitle == x_entitle
    && o.x_taken == x_taken && o.x_balance == x_balance;
  }

  @override
  int get hashCode => id.hashCode ^ create_date.hashCode ^ create_uid.hashCode ^ write_date.hashCode
  ^ write_uid.hashCode ^ x_employee_id.hashCode ^ x_name.hashCode ^ x_leave_type.hashCode
  ^ x_entitle.hashCode ^ x_taken.hashCode ^ x_balance.hashCode;
}

// class LeaveReport {
//   int id;
//   String create_date = "";
//   String create_uid = "";
//   String write_date = "";
//   String write_uid = "";
//   int x_employee_id = 0;
//   String x_name = "";
//   String x_leave_type = "";
//   double x_entitle = 0.0;
//   double x_taken = 0.0;
//   double x_balance = 0.0;
//   LeaveReport({
//     this.id,
//     this.create_date,
//     this.create_uid,
//     this.write_date,
//     this.write_uid,
//     this.x_employee_id,
//     this.x_name,
//     this.x_leave_type,
//     this.x_entitle,
//     this.x_taken,
//     this.x_balance,
//   });

//   LeaveReport copyWith({
//     int id,
//     String create_date,
//     String create_uid,
//     String write_date,
//     String write_uid,
//     int x_employee_id,
//     String x_name,
//     String x_leave_type,
//     double x_entitle,
//     double x_taken,
//     double x_balance,
//   }) {
//     return LeaveReport(
//       id: id ?? this.id,
//       create_date: create_date ?? this.create_date,
//       create_uid: create_uid ?? this.create_uid,
//       write_date: write_date ?? this.write_date,
//       write_uid: write_uid ?? this.write_uid,
//       x_employee_id: x_employee_id ?? this.x_employee_id,
//       x_name: x_name ?? this.x_name,
//       x_leave_type: x_leave_type ?? this.x_leave_type,
//       x_entitle: x_entitle ?? this.x_entitle,
//       x_taken: x_taken ?? this.x_taken,
//       x_balance: x_balance ?? this.x_balance,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'create_date': create_date,
//       'create_uid': create_uid,
//       'write_date': write_date,
//       'write_uid': write_uid,
//       'x_employee_id': x_employee_id,
//       'x_name': x_name,
//       'x_leave_type': x_leave_type,
//       'x_entitle': x_entitle,
//       'x_taken': x_taken,
//       'x_balance': x_balance,
//     };
//   }

//   factory LeaveReport.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return LeaveReport(
//       id: map['id'],
//       create_date: map['create_date'] ??'',
//       create_uid: map['create_uid'] ??'',
//       write_date: map['write_date'] ??'',
//       write_uid: map['write_uid'] ??'',
//       x_employee_id: map['x_employee_id'] ??0,
//       x_name: map['x_name'] ??'',
//       x_leave_type: map['x_leave_type'] ??'',
//       x_entitle: map['x_entitle'] ??'',
//       x_taken: map['x_taken'] ??'',
//       x_balance: map['x_balance'] ??'',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LeaveReport.fromJson(String source) => LeaveReport.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'LeaveReport(id: $id, create_date: $create_date, create_uid: $create_uid, write_date: $write_date, write_uid: $write_uid, x_employee_id: $x_employee_id, x_name: $x_name, x_leave_type: $x_leave_type, x_entitle: $x_entitle, x_taken: $x_taken, x_balance: $x_balance)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is LeaveReport &&
//       o.id == id &&
//       o.create_date == create_date &&
//       o.create_uid == create_uid &&
//       o.write_date == write_date &&
//       o.write_uid == write_uid &&
//       o.x_employee_id == x_employee_id &&
//       o.x_name == x_name &&
//       o.x_leave_type == x_leave_type &&
//       o.x_entitle == x_entitle &&
//       o.x_taken == x_taken &&
//       o.x_balance == x_balance;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       create_date.hashCode ^
//       create_uid.hashCode ^
//       write_date.hashCode ^
//       write_uid.hashCode ^
//       x_employee_id.hashCode ^
//       x_name.hashCode ^
//       x_leave_type.hashCode ^
//       x_entitle.hashCode ^
//       x_taken.hashCode ^
//       x_balance.hashCode;
//   }
// }
  