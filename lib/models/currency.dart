import 'dart:convert';

import 'package:flutter/material.dart';

class Currency {
  final int id;
  final String name;
  Currency({
    this.id = 0,
    this.name = '',
  });

  Currency copyWith({
    int? id,
    String? name,
  }) {
    return Currency(
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

  factory Currency.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Currency(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  String toString() => 'Currency(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Currency && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
