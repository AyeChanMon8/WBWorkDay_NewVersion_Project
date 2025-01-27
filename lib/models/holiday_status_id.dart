import 'dart:convert';

// class HolidayStatusId {
//   int id = 0;
//   String name = "";
//   HolidayStatusId({
//     this.id,
//     this.name,
//   });

//   HolidayStatusId copyWith({
//     int id,
//     String name,
//   }) {
//     return HolidayStatusId(
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

//   factory HolidayStatusId.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return HolidayStatusId(
//       id: map['id'],
//       name: map['name'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory HolidayStatusId.fromJson(String source) => HolidayStatusId.fromMap(json.decode(source));

//   @override
//   String toString() => 'HolidayStatusId(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is HolidayStatusId &&
//       o.id == id &&
//       o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }

class HolidayStatusId {

  int id;
  String name;
  HolidayStatusId({
    this.id = 0,
    this.name = ''
  });

  HolidayStatusId copyWith({
    int? id,
    String? name
  }) {
    return HolidayStatusId(
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

  factory HolidayStatusId.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return HolidayStatusId(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HolidayStatusId.fromJson(String source) =>
      HolidayStatusId.fromMap(json.decode(source));

  @override
  String toString() => 'HolidayStatusId(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HolidayStatusId && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
