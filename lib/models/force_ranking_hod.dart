

import 'dart:convert';

class ForceRankingHOD {
  dynamic id;
  dynamic name;
  int? percentage;
  dynamic managerRating;
  ForceRankingHOD({this.id,this.name, this.percentage, this.managerRating});

  ForceRankingHOD copyWith({
    dynamic id,
    dynamic name,
    int? percentage,
    dynamic managerRating
  }) {
    return ForceRankingHOD(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
      managerRating: managerRating ?? this.managerRating
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'percentage': percentage,
      'manager_rating': managerRating
    };
  }

  factory ForceRankingHOD.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return ForceRankingHOD(
      id: map['id'] ?? null,
      name: map['name']??null,
      percentage: map['percentage'] ?? 0,
      managerRating: map['manager_rating'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory ForceRankingHOD.fromJson(String source) => ForceRankingHOD.fromMap(json.decode(source));

  @override
  String toString() => 'ForceRankingHOD(id: $id, name: $name, percentage : $percentage, managerRating: $managerRating)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ForceRankingHOD &&
      o.id == id &&
      o.name == name &&
      o.percentage == percentage &&
      o.managerRating == managerRating;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ percentage.hashCode ^ managerRating.hashCode;
}
