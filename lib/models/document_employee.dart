// import 'dart:convert';

// class DocumentEmployee {
//   int id;
//   String name;
//   DocumentEmployee({
//     this.id,
//     this.name,
//   });

//   DocumentEmployee copyWith({
//     int id,
//     String name,
//   }) {
//     return DocumentEmployee(
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

//   factory DocumentEmployee.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return DocumentEmployee(
//       id: map['id'],
//       name: map['name'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DocumentEmployee.fromJson(String source) =>
//       DocumentEmployee.fromMap(json.decode(source));

//   @override
//   String toString() => 'DocumentEmployee(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is DocumentEmployee && o.id == id && o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }

import 'dart:convert';

class DocumentEmployee {
  final int id;
  final String name;
  DocumentEmployee({
    this.id = 0,
    this.name = '',
  });

  DocumentEmployee copyWith({
    int? id,
    String? name,
  }) {
    return DocumentEmployee(
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

  factory DocumentEmployee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DocumentEmployee(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentEmployee.fromJson(String source) =>
      DocumentEmployee.fromMap(json.decode(source));

  @override
  String toString() => 'DocumentEmployee(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DocumentEmployee && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
