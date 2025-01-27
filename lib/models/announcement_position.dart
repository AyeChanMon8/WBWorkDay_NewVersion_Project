import 'dart:convert';

class AnnouncementPosition {
  int id;
  String name;
  AnnouncementPosition({
    this.id = 0,
    this.name = '',
  });

  AnnouncementPosition copyWith({
    int? id,
    String? name,
  }) {
    return AnnouncementPosition(
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

  factory AnnouncementPosition.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return AnnouncementPosition(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementPosition.fromJson(String source) =>
      AnnouncementPosition.fromMap(json.decode(source));

  @override
  String toString() => 'AnnouncementPosition(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AnnouncementPosition && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
