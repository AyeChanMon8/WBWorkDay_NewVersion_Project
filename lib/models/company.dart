import 'dart:convert';

import 'package:flutter/material.dart';

class Company {
  final int id;
  final String name;
  Company({
    this.id = 0,
    this.name = '',
  });

  Company copyWith({
    int? id,
    String? name,
  }) {
    return Company(
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

  factory Company.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Company(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));

  @override
  String toString() => 'Company(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Company && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
