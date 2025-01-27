

import 'dart:convert';

class ForceManagerRating {
  String? id;
  String? value ;
  ForceManagerRating({this.id,this.value});

  ForceManagerRating copyWith({
    String? id,
    String? value
  }) {
    return ForceManagerRating(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }

  factory ForceManagerRating.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return ForceManagerRating(
      id: map['id'] ?? '',
      value: map['value']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory ForceManagerRating.fromJson(String source) => ForceManagerRating.fromMap(json.decode(source));

  @override
  String toString() => 'ForceManagerRating(id: $id, value: $value)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ForceManagerRating &&
      o.id == id &&
      o.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
