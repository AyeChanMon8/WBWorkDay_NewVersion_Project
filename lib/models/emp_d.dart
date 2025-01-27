
import 'dart:convert';

/// id : 1
class Emp_ID {
  final int id;
  Emp_ID({
    this.id = 0,
  });

  Emp_ID copyWith({
    int? id,
    String? name,
  }) {
    return Emp_ID(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory Emp_ID.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Emp_ID(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Emp_ID.fromJson(String source) =>
      Emp_ID.fromMap(json.decode(source));

  @override
  String toString() => 'Emp_ID(id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Emp_ID && o.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}