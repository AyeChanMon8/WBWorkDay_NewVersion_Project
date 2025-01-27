import 'dart:convert';

class RewardEmployee {
  int id;
  String name;
  double reward_carried_forward;
  double reward_this_year;
  double reward_total;
  RewardEmployee(
      {this.id = 0,
      this.name = '',
      this.reward_carried_forward = 0.0,
      this.reward_this_year = 0.0,
      this.reward_total = 0.0});

  RewardEmployee copyWith({
    int? id,
    String? name,
    double? reward_carried_forward,
    double? reward_this_year,
    double? reward_total,
  }) {
    return RewardEmployee(
      id: id ?? this.id,
      name: name ?? this.name,
      reward_carried_forward: reward_carried_forward ?? this.reward_carried_forward,
      reward_this_year: reward_this_year ?? this.reward_this_year,
      reward_total: reward_total ?? this.reward_total
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'reward_carried_forward': reward_carried_forward,
      'reward_this_year': reward_this_year,
      'reward_total': reward_total
    };
  }

  factory RewardEmployee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return RewardEmployee(
      id: map['id'],
      name: map['name'],
      reward_carried_forward: map['reward_carried_forward'],
      reward_this_year: map['reward_this_year'],
      reward_total: map['reward_total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RewardEmployee.fromJson(String source) =>
      RewardEmployee.fromMap(json.decode(source));

  @override
  String toString() => 'RewardEmployee(id: $id, name: $name,reward_carried_forward: $reward_carried_forward, reward_this_year: $reward_this_year,reward_total: $reward_total)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RewardEmployee && o.id == id && o.name == name && o.reward_carried_forward == reward_carried_forward && o.reward_this_year == reward_this_year && o.reward_total == reward_total;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^
  reward_carried_forward.hashCode ^ reward_this_year.hashCode ^ reward_total.hashCode;
}

// class RewardEmployee {
//   int id;
//   String name;
//   double reward_carried_forward;
//   double reward_this_year;
//   double reward_total;
//   RewardEmployee({
//     this.id,
//     this.name,
//     this.reward_carried_forward,
//     this.reward_this_year,
//     this.reward_total,
//   });

//   RewardEmployee copyWith({
//     int id,
//     String name,
//     double reward_carried_forward,
//     double reward_this_year,
//     double reward_total,
//   }) {
//     return RewardEmployee(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       reward_carried_forward:
//           reward_carried_forward ?? this.reward_carried_forward,
//       reward_this_year: reward_this_year ?? this.reward_this_year,
//       reward_total: reward_total ?? this.reward_total,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'reward_carried_forward': reward_carried_forward,
//       'reward_this_year': reward_this_year,
//       'reward_total': reward_total,
//     };
//   }

//   factory RewardEmployee.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return RewardEmployee(
//       id: map['id'],
//       name: map['name'],
//       reward_carried_forward: map['reward_carried_forward'],
//       reward_this_year: map['reward_this_year'],
//       reward_total: map['reward_total'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory RewardEmployee.fromJson(String source) =>
//       RewardEmployee.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'RewardEmployee(id: $id, name: $name, reward_carried_forward: $reward_carried_forward, reward_this_year: $reward_this_year, reward_total: $reward_total)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is RewardEmployee &&
//         o.id == id &&
//         o.name == name &&
//         o.reward_carried_forward == reward_carried_forward &&
//         o.reward_this_year == reward_this_year &&
//         o.reward_total == reward_total;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         reward_carried_forward.hashCode ^
//         reward_this_year.hashCode ^
//         reward_total.hashCode;
//   }
// }
