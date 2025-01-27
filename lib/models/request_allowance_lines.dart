

import 'dart:convert';


class RequestedAllowanceLines {
  int id;
  int travel_allowance_id;
  double standard_amount;
  double actual_amount;
  String remark;
  RequestedAllowanceLines({
    this.id = 0,
    this.travel_allowance_id = 0,
    this.standard_amount = 0.0,
    this.actual_amount = 0.0,
    this.remark = ''
  });


  RequestedAllowanceLines copyWith({
    int? id,
  int? travel_allowance_id,
  double? standard_amount,
  double? actual_amount,
  String? remark,
  }) {
    return RequestedAllowanceLines(
      id: id ?? this.id,
      travel_allowance_id: travel_allowance_id ?? this.travel_allowance_id,
      standard_amount: standard_amount ?? this.standard_amount,
      actual_amount: actual_amount ?? this.actual_amount,
      remark: remark ?? this.remark
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'travel_allowance_id': travel_allowance_id,
      'standard_amount': standard_amount,
      'actual_amount': actual_amount,
      'remark': remark,
      // 'name': name,
    };
  }

  factory RequestedAllowanceLines.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return RequestedAllowanceLines(
      id: map['id'],
      travel_allowance_id: map['travel_allowance_id'],
      standard_amount: map['standard_amount'],
      actual_amount: map['actual_amount'],
      remark: map['remark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestedAllowanceLines.fromJson(String source) => RequestedAllowanceLines.fromMap(json.decode(source));

  @override
  String toString() => 'RequestedAllowanceLines(id: $id, travel_allowance_id: $travel_allowance_id,standard_amount: $standard_amount,actual_amount: $actual_amount,remark: $remark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestedAllowanceLines &&
      o.id == id &&
      o.travel_allowance_id == travel_allowance_id &&
      o.standard_amount == standard_amount &&
      o.actual_amount == actual_amount &&
      o.remark == remark;
  }

  @override
  int get hashCode => id.hashCode ^ travel_allowance_id.hashCode ^ standard_amount.hashCode ^ actual_amount.hashCode ^  remark.hashCode;
}


// class RequestedAllowanceLines {
//   int id;
//   int travel_allowance_id;
//   double standard_amount;
//   double actual_amount;
//   String remark;
//   RequestedAllowanceLines({
//     this.id,
//     this.travel_allowance_id,
//     this.standard_amount,
//     this.actual_amount,
//     this.remark,
//   });

//   RequestedAllowanceLines copyWith({
//     int id,
//     int travel_allowance_id,
//     double standard_amount,
//     double actual_amount,
//     String remark,
//   }) {
//     return RequestedAllowanceLines(
//       id: id ?? this.id,
//       travel_allowance_id: travel_allowance_id ?? this.travel_allowance_id,
//       standard_amount: standard_amount ?? this.standard_amount,
//       actual_amount: actual_amount ?? this.actual_amount,
//       remark: remark ?? this.remark,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'travel_allowance_id': travel_allowance_id,
//       'standard_amount': standard_amount,
//       'actual_amount': actual_amount,
//       'remark': remark,
//     };
//   }

//   factory RequestedAllowanceLines.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return RequestedAllowanceLines(
//       id: map['id'],
//       travel_allowance_id: map['travel_allowance_id'],
//       standard_amount: map['standard_amount'],
//       actual_amount: map['actual_amount'],
//       remark: map['remark'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory RequestedAllowanceLines.fromJson(String source) => RequestedAllowanceLines.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'RequestedAllowanceLines(id: $id, travel_allowance_id: $travel_allowance_id, standard_amount: $standard_amount, actual_amount: $actual_amount, remark: $remark)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is RequestedAllowanceLines &&
//       o.id == id &&
//       o.travel_allowance_id == travel_allowance_id &&
//       o.standard_amount == standard_amount &&
//       o.actual_amount == actual_amount &&
//       o.remark == remark;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       travel_allowance_id.hashCode ^
//       standard_amount.hashCode ^
//       actual_amount.hashCode ^
//       remark.hashCode;
//   }
// }
