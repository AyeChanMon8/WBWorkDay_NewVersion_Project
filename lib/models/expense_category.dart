

import 'dart:convert';

// class ExpenseCategory {
//   int id;
//   String name;
//   ExpenseCategory({
//     this.id,
//     this.name,
//   });

//   ExpenseCategory copyWith({
//     int id,
//     String name,
//   }) {
//     return ExpenseCategory(
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

//   factory ExpenseCategory.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return ExpenseCategory(
//       id: map['id']??0,
//       name: map['name']??'',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ExpenseCategory.fromJson(String source) =>
//       ExpenseCategory.fromMap(json.decode(source));

//   @override
//   String toString() => 'ExpenseCategory(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is ExpenseCategory && o.id == id && o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }

class ExpenseCategory {

  int id;
  String name;
  ExpenseCategory({
    this.id = 0,
    this.name = ''
  });

  ExpenseCategory copyWith({
    int? id,
    String? name
  }) {
    return ExpenseCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }

  factory ExpenseCategory.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ExpenseCategory(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseCategory.fromJson(String source) =>
      ExpenseCategory.fromMap(json.decode(source));

  @override
  String toString() => 'ExpenseCategory(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExpenseCategory && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
