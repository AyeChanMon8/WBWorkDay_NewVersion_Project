

import 'dart:convert';

import '../models/employee_id.dart';

import 'overtime_request.dart';

class OTDepartment {
  final int id;
  final String name;
  // final int branch_id;
  // final String branch_name;
  Branch_id? branch_id;
  String complete_name;
  List<EmployeeID>? employee_ids;
  OTDepartment({
    this.id = 0,
    this.name = '',this.complete_name = '',
    // this.branch_id,this.branch_name
    this.branch_id
  });


  OTDepartment copyWith({
    int? id,
    String? name,
    Branch_id? branch_id,
    String? branch_name
  }) {
    return OTDepartment(
      id: id ?? this.id,
      name: name ?? this.name,
      // branch_id: branch_id ?? this.branch_id,
      // branch_name: branch_name ?? this.branch_name
      branch_id: branch_id ?? this.branch_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id
    };
  }

  factory OTDepartment.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OTDepartment(
      id: map['id'],
      name: map['name'],
      complete_name: map['complete_name']?? "",
      branch_id: Branch_id.fromMap(map['branch_id']),
      // branch_id: map['branch_id'],
      // branch_name: map['branch_name']
    );
  }

  String toJson() => json.encode(toMap());

  factory OTDepartment.fromJson(String source) => OTDepartment.fromMap(json.decode(source));

  @override
  String toString() => 'Department(id: $id, name: $name, branch_id: $branch_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OTDepartment &&
      o.id == id &&
      o.name == name &&
      o.branch_id == branch_id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ branch_id.hashCode;
}
