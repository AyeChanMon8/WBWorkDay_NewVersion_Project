import 'dart:convert';

class AnnouncementEmployee {
  int id;
  String name;
  AnnouncementEmployee({
    this.id = 0,
    this.name = '',
  });

  AnnouncementEmployee copyWith({
    int? id,
    String? name,
  }) {
    return AnnouncementEmployee(
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

  factory AnnouncementEmployee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return AnnouncementEmployee(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementEmployee.fromJson(String source) =>
      AnnouncementEmployee.fromMap(json.decode(source));

  @override
  String toString() => 'AnnouncementEmployee(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AnnouncementEmployee && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
