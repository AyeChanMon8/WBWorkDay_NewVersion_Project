import 'dart:convert';

class CategoryID {
  int id;
  String name;
  String code;
  CategoryID({
    this.id = 0,
    this.name = '',
    this.code = '',
  });

  CategoryID copyWith({
    int? id,
    String? name,
    String? code,
  }) {
    return CategoryID(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory CategoryID.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return CategoryID(
      id: map['id'],
      name: map['name'],
      code: map['code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryID.fromJson(String source) =>
      CategoryID.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryID(id: $id, name: $name, code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoryID && o.id == id && o.name == name && o.code == code;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode;
}
