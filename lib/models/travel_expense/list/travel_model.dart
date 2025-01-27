import 'dart:convert';

class TravelModel {
  int id;
  String name;
  TravelModel({
    this.id = 0,
    this.name = '',
  });

  TravelModel copyWith({
    int? id,
    String? name,
  }) {
    return TravelModel(
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

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelModel.fromJson(String source) =>
      TravelModel.fromMap(json.decode(source));

  @override
  String toString() => 'TravelModel(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
