import 'dart:convert';

class TravelExpenseProduct {
  int id;
  String name;
  TravelExpenseProduct({
    this.id = 0,
    this.name = '',
  });

  TravelExpenseProduct copyWith({
    int? id,
    String? name,
  }) {
    return TravelExpenseProduct(
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

  factory TravelExpenseProduct.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelExpenseProduct(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelExpenseProduct.fromJson(String source) =>
      TravelExpenseProduct.fromMap(json.decode(source));

  @override
  String toString() => 'TravelExpenseProduct(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelExpenseProduct && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
