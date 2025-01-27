import 'dart:convert';

class TravelExpenseApproveModel {
  int id;
  String name;
  TravelExpenseApproveModel({
    this.id = 0,
    this.name = '',
  });

  TravelExpenseApproveModel copyWith({
    int? id,
    String? name,
  }) {
    return TravelExpenseApproveModel(
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

  factory TravelExpenseApproveModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelExpenseApproveModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelExpenseApproveModel.fromJson(String source) =>
      TravelExpenseApproveModel.fromMap(json.decode(source));

  @override
  String toString() => 'TravelExpenseApproveModel(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelExpenseApproveModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
