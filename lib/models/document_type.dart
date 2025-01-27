// import 'dart:convert';

// class DocumentType {
//   int id;
//   String name;
//   DocumentType({
//     this.id,
//     this.name,
//   });

//   DocumentType copyWith({
//     int id,
//     String name,
//   }) {
//     return DocumentType(
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

//   factory DocumentType.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return DocumentType(
//       id: map['id'],
//       name: map['name'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DocumentType.fromJson(String source) =>
//       DocumentType.fromMap(json.decode(source));

//   @override
//   String toString() => 'DocumentType(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is DocumentType && o.id == id && o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }


import 'dart:convert';

class DocumentType {
  final int id;
  final String name;
  DocumentType({
    this.id = 0,
    this.name = '',
  });

  DocumentType copyWith({
    int? id,
    String? name,
  }) {
    return DocumentType(
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

  factory DocumentType.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DocumentType(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentType.fromJson(String source) =>
      DocumentType.fromMap(json.decode(source));

  @override
  String toString() => 'DocumentType(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DocumentType && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}