

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/category_id.dart';

class LineIDs {
  String name;
  String code;
  CategoryID? category_id;
  double total;
  LineIDs({
    required this.name,
    required this.code,
    this.category_id,
    required this.total,
  });

  LineIDs copyWith({
    String? name,
  String? code,
  CategoryID? category_id,
  double? total
  }) {
    return LineIDs(
      name: name ?? this.name,
      code: code ?? this.code,
      category_id: category_id ?? this.category_id,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'category_id': category_id?.toMap(),
      'total': total,
    };
  }

  factory LineIDs.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LineIDs(
      name: map['name'],
      code: map['code'],
      category_id:map['category_id'] == null ? null: CategoryID.fromMap(map['category_id']),
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LineIDs.fromJson(String source) =>
      LineIDs.fromMap(json.decode(source));

  @override
  String toString() => 'LineIDs(name: $name,code: $code,category_id: $category_id,total: $total)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LineIDs && o.name == name && o.code == code && o.category_id == category_id && o.total == total;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ category_id.hashCode ^ total.hashCode;
}


// class LineIDs {
//   String name;
//   String code;
//   CategoryID category_id;
//   double total;
//   LineIDs({
//     this.name,
//     this.code,
//     this.category_id,
//     this.total,
//   });

//   LineIDs copyWith({
//     String name,
//     String code,
//     CategoryID category_id,
//     double total,
//   }) {
//     return LineIDs(
//       name: name ?? this.name,
//       code: code ?? this.code,
//       category_id: category_id ?? this.category_id,
//       total: total ?? this.total,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'code': code,
//       'category_id': category_id?.toMap(),
//       'total': total,
//     };
//   }

//   factory LineIDs.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return LineIDs(
//       name: map['name'],
//       code: map['code'],
//      // category_id: CategoryID.fromMap(map['category_id']),
//       total: map['total'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LineIDs.fromJson(String source) =>
//       LineIDs.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'LineIDs(name: $name, code: $code, category_id: $category_id, total: $total)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is LineIDs &&
//         o.name == name &&
//         o.code == code &&
//         o.category_id == category_id &&
//         o.total == total;
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//         code.hashCode ^
//         category_id.hashCode ^
//         total.hashCode;
//   }
// }
