

import 'dart:convert';

class RequestedEmployee {
  final int id;
  final String name;
  RequestedEmployee({
    this.id = 0,
    this.name = '',
  });

  RequestedEmployee copyWith({
    int? id,
    String? name,
  }) {
    return RequestedEmployee(
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

  factory RequestedEmployee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return RequestedEmployee(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestedEmployee.fromJson(String source) =>
      RequestedEmployee.fromMap(json.decode(source));

  @override
  String toString() => 'RequestedEmployee(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestedEmployee && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class RequestedEmployee {
//   int id = 0;
//   String name = "";
//   RequestedEmployee({
//     this.id,
//     this.name,
//   });
 

//   RequestedEmployee copyWith({
//     int id,
//     String name,
//   }) {
//     return RequestedEmployee(
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

//   factory RequestedEmployee.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return RequestedEmployee(
//       id: map['id'],
//       name: map['name'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory RequestedEmployee.fromJson(String source) => RequestedEmployee.fromMap(json.decode(source));

//   @override
//   String toString() => 'RequestedEmployee(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is RequestedEmployee &&
//       o.id == id &&
//       o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }
