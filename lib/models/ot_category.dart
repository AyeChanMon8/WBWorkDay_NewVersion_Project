
import 'dart:convert';


class OTCategory {
  final int id;
  final String category;
  OTCategory({
    this.id = 0,
    this.category = '',
  });


  OTCategory copyWith({
    int? id,
    String? category,
  }) {
    return OTCategory(
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'name': name,
    };
  }

  factory OTCategory.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OTCategory(
      id: map['id'] ?? 0,
      category: map['category'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory OTCategory.fromJson(String source) => OTCategory.fromMap(json.decode(source));

  @override
  String toString() => 'Department(id: $id, category: $category)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OTCategory &&
      o.id == id &&
      o.category == category;
  }

  @override
  int get hashCode => id.hashCode ^ category.hashCode;
}
