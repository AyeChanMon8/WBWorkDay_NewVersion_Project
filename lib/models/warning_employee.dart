

import 'dart:convert';

class WarningEmployee {
  int id;
  String name;
  double warning_carried_forward;
  double warning_this_year;
  double warning_total;
  WarningEmployee({
    this.id = 0,
    this.name = '',
    this.warning_carried_forward = 0.0,
    this.warning_this_year = 0.0,
    this.warning_total = 0.0
  });


  WarningEmployee copyWith({
    int? id,
  String? name,
  double? warning_carried_forward,
  double? warning_this_year,
  double? warning_total,
  }) {
    return WarningEmployee(
      id: id ?? this.id,
      name: name ?? this.name,
      warning_carried_forward: warning_carried_forward ?? this.warning_carried_forward,
      warning_this_year: warning_this_year ?? this.warning_this_year,
      warning_total: warning_total ?? this.warning_total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'warning_carried_forward': warning_carried_forward,
      'warning_this_year': warning_this_year,
      'warning_total': warning_total,
      // 'name': name,
    };
  }

  factory WarningEmployee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return WarningEmployee(
      id: map['id'],
      name: map['name'],
      warning_carried_forward: map['warning_carried_forward'],
      warning_this_year: map['warning_this_year'],
      warning_total: map['warning_total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WarningEmployee.fromJson(String source) => WarningEmployee.fromMap(json.decode(source));

  @override
  String toString() => 'WarningEmployee(id: $id, name: $name, warning_carried_forward: $warning_carried_forward,warning_this_year: $warning_this_year, warning_total: $warning_total)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WarningEmployee &&
      o.id == id &&
      o.name == name &&
      o.warning_carried_forward == warning_carried_forward &&
      o.warning_this_year == warning_this_year &&
      o.warning_total == warning_total;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ warning_carried_forward.hashCode ^ warning_this_year.hashCode ^ warning_total.hashCode;
}

// class WarningEmployee {
//   int id;
//   String name;
//   double warning_carried_forward;
//   double warning_this_year;
//   double warning_total;
//   WarningEmployee({
//     this.id,
//     this.name,
//     this.warning_carried_forward,
//     this.warning_this_year,
//     this.warning_total,
//   });

//   WarningEmployee copyWith({
//     int id,
//     String name,
//     double warning_carried_forward,
//     double warning_this_year,
//     double warning_total,
//   }) {
//     return WarningEmployee(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       warning_carried_forward:
//           warning_carried_forward ?? this.warning_carried_forward,
//       warning_this_year: warning_this_year ?? this.warning_this_year,
//       warning_total: warning_total ?? this.warning_total,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'warning_carried_forward': warning_carried_forward,
//       'warning_this_year': warning_this_year,
//       'warning_total': warning_total,
//     };
//   }

//   factory WarningEmployee.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return WarningEmployee(
//       id: map['id'],
//       name: map['name'],
//       warning_carried_forward: map['warning_carried_forward'],
//       warning_this_year: map['warning_this_year'],
//       warning_total: map['warning_total'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory WarningEmployee.fromJson(String source) =>
//       WarningEmployee.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'WarningEmployee(id: $id, name: $name, warning_carried_forward: $warning_carried_forward, warning_this_year: $warning_this_year, warning_total: $warning_total)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is WarningEmployee &&
//         o.id == id &&
//         o.name == name &&
//         o.warning_carried_forward == warning_carried_forward &&
//         o.warning_this_year == warning_this_year &&
//         o.warning_total == warning_total;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         warning_carried_forward.hashCode ^
//         warning_this_year.hashCode ^
//         warning_total.hashCode;
//   }
// }
