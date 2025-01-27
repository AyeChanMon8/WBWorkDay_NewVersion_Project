

import 'dart:convert';

// class InsuranceType {
//   int id;
//   String name;
//   InsuranceType({
//     this.id,
//     this.name,
//   });

//   InsuranceType copyWith({
//     int id,
//     String name,
//   }) {
//     return InsuranceType(
//       id: id ?? this.id,
//       name: name ?? this.name,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }

//   factory InsuranceType.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return InsuranceType(
//       id: map['id'] ?? 0,
//       name: map['name'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory InsuranceType.fromJson(String source) =>
//       InsuranceType.fromMap(json.decode(source));

//   @override
//   String toString() => 'InsuranceType(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is InsuranceType && o.id == id && o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }

class InsuranceType {
  final int id;
  final String name;
  InsuranceType({
    this.id = 0,
    this.name = '',
  });

  InsuranceType copyWith({
    int? id,
    String? name,
  }) {
    return InsuranceType(
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

  factory InsuranceType.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return InsuranceType(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InsuranceType.fromJson(String source) =>
      InsuranceType.fromMap(json.decode(source));

  @override
  String toString() => 'InsuranceType(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is InsuranceType && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
