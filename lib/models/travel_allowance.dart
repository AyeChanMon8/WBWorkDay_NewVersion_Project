import 'dart:convert';

class TravelAllowance {
  String name;
  int type_id;
  double standard_amount;
  String remark;
  TravelAllowance(
      {this.name = '',
      this.type_id = 0,
      this.standard_amount = 0.0,
      this.remark = ''});

  TravelAllowance copyWith({
    String? name,
    int? type_id,
    double? standard_amount,
    String? remark,
  }) {
    return TravelAllowance(
      name: name ?? this.name,
      type_id: type_id ?? this.type_id,
      standard_amount: standard_amount ?? this.standard_amount,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type_id': type_id,
      'standard_amount': standard_amount,
      'remark': remark,
    };
  }

  factory TravelAllowance.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelAllowance(
      name: map['name'],
      type_id: map['type_id'],
      standard_amount: map['standard_amount'],
      remark: map['remark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelAllowance.fromJson(String source) =>
      TravelAllowance.fromMap(json.decode(source));

  @override
  String toString() => 'TravelAllowance(name: $name, type_id: $type_id,standard_amount: $standard_amount, remark: $remark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelAllowance && o.name == name && o.type_id == type_id
    && o.standard_amount == standard_amount && o.remark == remark;
  }

  @override
  int get hashCode => name.hashCode ^ type_id.hashCode ^ standard_amount.hashCode ^ remark.hashCode;
}

// class TravelAllowance {
//   String name;
//   int type_id;
//   double standard_amount;
//   String remark;
//   TravelAllowance({
//     this.name,
//     this.type_id,
//     this.standard_amount,
//     this.remark,
//   });

//   TravelAllowance copyWith({
//     String name,
//     int type_id,
//     double standard_amount,
//     String remark,
//   }) {
//     return TravelAllowance(
//       name: name ?? this.name,
//       type_id: type_id ?? this.type_id,
//       standard_amount: standard_amount ?? this.standard_amount,
//       remark: remark ?? this.remark,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'type_id': type_id,
//       'standard_amount': standard_amount,
//       'remark': remark,
//     };
//   }

//   factory TravelAllowance.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return TravelAllowance(
//       name: map['name'],
//       type_id: map['type_id'],
//       standard_amount: map['standard_amount'],
//       remark: map['remark'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TravelAllowance.fromJson(String source) =>
//       TravelAllowance.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TravelAllowance(name: $name, type_id: $type_id, standard_amount: $standard_amount, remark: $remark)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is TravelAllowance &&
//         o.name == name &&
//         o.type_id == type_id &&
//         o.standard_amount == standard_amount &&
//         o.remark == remark;
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//         type_id.hashCode ^
//         standard_amount.hashCode ^
//         remark.hashCode;
//   }
// }
