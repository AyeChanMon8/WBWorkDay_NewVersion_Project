

import 'package:flutter/material.dart';

class Partner{
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Partner({
     this.id= 0,
     this.name = '',
  });

  Partner copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Partner(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Partner{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Partner &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Partner.fromMap(Map<String, dynamic> map) {
    return new Partner(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}