

import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/travel_allowance.dart';

class TravelType {
  int id;
  String name;
  List<TravelAllowance>? allowance_ids;
  TravelType({
    this.id = 0,
    this.name = '',
    this.allowance_ids,
  });


  TravelType copyWith({
    int? id,
  String? name,
  List<TravelAllowance>? allowance_ids
  }) {
    return TravelType(
      id: id ?? this.id,
      name: name ?? this.name,
      allowance_ids: allowance_ids ?? this.allowance_ids
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'allowance_ids': allowance_ids?.map((x) => x?.toMap())?.toList(),
      // 'name': name,
    };
  }

  factory TravelType.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelType(
      id: map['id'],
      name: map['name'],
      allowance_ids: List<TravelAllowance>.from(
          map['allowance_ids']?.map((x) => TravelAllowance.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelType.fromJson(String source) => TravelType.fromMap(json.decode(source));

  @override
  String toString() => 'TravelType(id: $id, name: $name, allowance_ids: $allowance_ids)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelType &&
      o.id == id &&
      o.name == name &&
      o.allowance_ids == allowance_ids;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ allowance_ids.hashCode;
}

// class TravelType {
//   int id;
//   String name;
//   List<TravelAllowance> allowance_ids;
//   TravelType({
//     this.id,
//     this.name,
//     this.allowance_ids,
//   });

//   TravelType copyWith({
//     int id,
//     String name,
//     List<TravelAllowance> allowance_ids,
//   }) {
//     return TravelType(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       allowance_ids: allowance_ids ?? this.allowance_ids,
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'allowance_ids': allowance_ids?.map((x) => x?.toMap())?.toList(),
//     };
//   }
//   factory TravelType.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return TravelType(
//       id: map['id'],
//       name: map['name'],
//       allowance_ids: List<TravelAllowance>.from(map['allowance_ids']?.map((x) => TravelAllowance.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TravelType.fromJson(String source) => TravelType.fromMap(json.decode(source));

//   @override
//   String toString() => 'TravelType(id: $id, name: $name, allowance_ids: $allowance_ids)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is TravelType &&
//       o.id == id &&
//       o.name == name &&
//       listEquals(o.allowance_ids, allowance_ids);
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ allowance_ids.hashCode;
//    }
