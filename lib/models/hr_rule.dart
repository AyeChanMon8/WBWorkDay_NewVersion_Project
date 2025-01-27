


import 'dart:convert';

import 'line_ids.dart';

/// name : 1
/// line_ids : [{"name":"Basic Salary","code":"BASIC","total":4600000.0}]

// class Hr_rule {
//   int _id;
//   String _name;
//   List<LineIDs> _lineIds;
//   int get id => _id;
//   String get name => _name;
//   List<LineIDs> get lineIds => _lineIds;

//   Hr_rule({
//     String name,
//       List<LineIDs> lineIds}){
//     _name = name;
//     _lineIds = lineIds;
// }

//   Hr_rule.fromJson(dynamic json) {
//     _name = json['name'];
//     if (json['line_ids'] != null) {
//       _lineIds = [];
//       json['line_ids'].forEach((v) {
//         _lineIds.add(LineIDs.fromJson(v));
//       });
//     }
//     _id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['name'] = _name;
//     if (_lineIds != null) {
//       map['line_ids'] = _lineIds.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

class Hr_rule {

  int id;
  String name;
  List<LineIDs>? lineIds;
  Hr_rule({
    this.id = 0,
    this.name = '',
    this.lineIds
  });

  Hr_rule copyWith({
    int? id,
    String? name,
    List<LineIDs>? lineIds
  }) {
    return Hr_rule(
      id: id ?? this.id,
      name: name ?? this.name,
      lineIds: lineIds ?? this.lineIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'line_ids':
          lineIds?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Hr_rule.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Hr_rule(
      id: map['id'],
      name: map['name'],
      lineIds:
          List<LineIDs>.from(map['line_ids']?.map((x) => LineIDs.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Hr_rule.fromJson(String source) =>
      Hr_rule.fromMap(json.decode(source));

  @override
  String toString() => 'Hr_rule(id: $id, name: $name, lineIds: $lineIds)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Hr_rule && o.id == id && o.name == name && o.lineIds == lineIds;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ lineIds.hashCode;
}

/// name : "Basic Salary"
/// code : "BASIC"
/// total : 4600000.0

// class Line_ids {
//   String _name;
//   String _code;
//   double _total;
//
//   String get name => _name;
//   String get code => _code;
//   double get total => _total;
//
//   Line_ids({
//       String name,
//       String code,
//       double total}){
//     _name = name;
//     _code = code;
//     _total = total;
// }
//
//   Line_ids.fromJson(dynamic json) {
//     _name = json['name'];
//     _code = json['code'];
//     _total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['name'] = _name;
//     map['code'] = _code;
//     map['total'] = _total;
//     return map;
//   }
//
// }