import 'dart:convert';

class AnnouncementDepartment {
  int id;
  String name;
  AnnouncementDepartment({
    this.id = 0,
    this.name = '',
  });

  AnnouncementDepartment copyWith({
    int? id,
    String? name,
  }) {
    return AnnouncementDepartment(
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

  factory AnnouncementDepartment.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return AnnouncementDepartment(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementDepartment.fromJson(String source) =>
      AnnouncementDepartment.fromMap(json.decode(source));

  @override
  String toString() => 'AnnouncementDepartment(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AnnouncementDepartment && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
