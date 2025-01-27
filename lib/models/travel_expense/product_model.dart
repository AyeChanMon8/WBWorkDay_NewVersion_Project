import 'dart:convert';

class ProductModel {
  int id;
  String name;
  ProductModel({
    this.id = 0,
    this.name = '',
  });

  ProductModel copyWith({
    int? id,
    String? name,
  }) {
    return ProductModel(
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

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ProductModel(
      id: map['id']?? 0,
      name: map['name']?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductModel(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
