

import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrganizationChart {
  String id;
  String email;
  List<String>? next;
  OrganizationChart({
    this.id = '',
    this.email = '',
    this.next,
  });

  OrganizationChart copyWith({
    String? id,
    String? email,
    List<String>? next,
  }) {
    return OrganizationChart(
      id: id ?? this.id,
      email: email ?? this.email,
      next: next ?? this.next,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'next': next,
    };
  }

  factory OrganizationChart.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return OrganizationChart(
      id: map['id'],
      email: map['email'],
      next: List<String>.from(map['next']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizationChart.fromJson(String source) => OrganizationChart.fromMap(json.decode(source));

  @override
  String toString() => 'OrganizationChart(id: $id, email: $email, next: $next)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is OrganizationChart &&
      o.id == id &&
      o.email == email &&
      listEquals(o.next, next);
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ next.hashCode;
}
