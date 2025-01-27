import 'dart:convert';

import 'package:flutter/material.dart';

class Daytrip_expense {
  final int id;
  final String name;
  Daytrip_expense({
    this.id = 0,
    this.name = '',
  });

  Daytrip_expense copyWith({
    int? id,
    String? name,
  }) {
    return Daytrip_expense(
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

  factory Daytrip_expense.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Daytrip_expense(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Daytrip_expense.fromJson(String source) =>
      Daytrip_expense.fromMap(json.decode(source));

  @override
  String toString() => 'Daytrip_expense(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Daytrip_expense && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

