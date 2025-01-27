

import 'dart:convert';

class LeaveType {

  int id ;
  String name;
  bool show_in_mobile_app;
  LeaveType({
    this.id = 0,
    this.name = '',
    this.show_in_mobile_app = false,
  });

  LeaveType copyWith({
    int? id,
    String? name,
    bool? show_in_mobile_app
  }) {
    return LeaveType(
      id: id ?? this.id,
      name: name ?? this.name,
      show_in_mobile_app: show_in_mobile_app ?? this.show_in_mobile_app
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'show_in_mobile_app': show_in_mobile_app
    };
  }

  factory LeaveType.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LeaveType(
      id: map['id'],
      name: map['name'],
      show_in_mobile_app: map['show_in_mobile_app']
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveType.fromJson(String source) =>
      LeaveType.fromMap(json.decode(source));

  @override
  String toString() => 'LeaveType(id: $id, name: $name,show_in_mobile_app: $show_in_mobile_app)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LeaveType && o.id == id && o.name == name && o.show_in_mobile_app == show_in_mobile_app;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ show_in_mobile_app.hashCode;
}

// class LeaveType {
//   int id ;
//   String name;
//   bool show_in_mobile_app;
//   LeaveType({
//     this.id = 1,
//     this.name = "Casual Leave",
//     this.show_in_mobile_app = false,
//   });

//   LeaveType copyWith({
//     int id,
//     String name,
//     bool show_in_mobile_app,
//   }) {
//     return LeaveType(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       show_in_mobile_app: show_in_mobile_app ?? this.show_in_mobile_app,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'show_in_mobile_app': show_in_mobile_app,
//     };
//   }

//   factory LeaveType.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return LeaveType(
//       id: map['id']??0,
//       name: map['name']??'',
//       show_in_mobile_app: false,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LeaveType.fromJson(String source) => LeaveType.fromMap(json.decode(source));

//   @override
//   String toString() => 'LeaveType(id: $id, name: $name, show_in_mobile_app: $show_in_mobile_app)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is LeaveType &&
//       o.id == id &&
//       o.name == name && o.show_in_mobile_app == show_in_mobile_app;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }
