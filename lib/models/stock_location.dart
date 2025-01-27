import 'dart:convert';

class Stock_location {
   int id;
  String name;
  String completeName;
  Stock_location({
    this.id = 0,
    this.name = '',
    this.completeName = '',
  });


  Stock_location copyWith({
    int? id,
    String? name,
    String? completeName
  }) {
    return Stock_location(
      id: id ?? this.id,
      name: name ?? this.name,
      completeName: completeName ?? this.completeName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'complete_name': completeName,
      // 'name': name,
    };
  }

  factory Stock_location.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Stock_location(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      completeName: map['complete_name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock_location.fromJson(String source) => Stock_location.fromMap(json.decode(source));

  @override
  String toString() => 'Stock_location(id: $id, name: $name,completeName: $completeName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Stock_location &&
      o.id == id &&
      o.name == name &&
      o.completeName == completeName;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ completeName.hashCode;
}

// class Stock_location {
//   int _id;
//   String _name;
//   String _completeName;

//   int get id => _id;
//   String get name => _name;
//   String get completeName => _completeName;

//   Stock_location({
//       int id, 
//       String name, 
//       String completeName}){
//     _id = id;
//     _name = name;
//     _completeName = completeName;
// }

//   Stock_location.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _completeName = json["complete_name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["complete_name"] = _completeName;
//     return map;
//   }

//   factory Stock_location.fromMap(Map<String, dynamic> map) {
//     return new Stock_location(
//       id: map['id'] as int,
//       name: map['name'] as String,
//       completeName: map['completeName'] as String,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       '_id': this._id,
//       '_name': this._name,
//       '_completeName': this._completeName,
//     } as Map<String, dynamic>;
//   }
// }