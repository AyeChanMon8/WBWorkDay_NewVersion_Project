import 'dart:convert';

// class Advance_line {
//   int _dayTripId;
//   int _expenseCategId;
//   int _quantity;
//   int _amount;
//   int _total_amount;
//   String _remark;

//   int get dayTripId => _dayTripId;
//   int get expenseCategId => _expenseCategId;
//   int get quantity => _quantity;
//   int get amount => _amount;
//   int get total_amount => _total_amount;
//   String get remark => _remark;

//   Advance_line(
//       {
//int dayTripId,
//       int expenseCategId,
//       int quantity,
//       int amount,
//       int total_amount,
//       String remark}) {
//     _dayTripId = dayTripId;
//     _expenseCategId = expenseCategId;
//     _quantity = quantity;
//     _amount = amount;
//     _total_amount = total_amount;
//     _remark = remark;
//   }

//   Advance_line.fromJson(dynamic json) {
//     _dayTripId = json["day_trip_id"];
//     _expenseCategId = json["expense_categ_id"];
//     _quantity = json["quantity"];
//     _amount = json["amount"];
//     _total_amount = json['total_amount'];
//     _remark = json["remark"];
//   }
//   String toJson() => json.encode(toMap());

//   Map<String, dynamic> toMap() {
//     return {
//       'day_trip_id': _dayTripId,
//       'expense_categ_id': _expenseCategId,
//       'quantity': _quantity,
//       'amount': _amount,
//       'total_amount': _total_amount,
//       'remark': _remark,
//     };
//   }
// }

class Advance_line {
  int dayTripId;
  int expenseCategId;
  int quantity;
  int amount;
  int total_amount;
  String remark;
  Advance_line(
      {this.dayTripId = 0,
      this.expenseCategId = 0,
      this.quantity = 0,
      this.amount = 0,
      this.total_amount = 0,
      this.remark = ''});

  Advance_line copyWith({
    int? dayTripId,
    int? expenseCategId,
    int? quantity,
    int? amount,
    int? total_amount,
    String? remark,
  }) {
    return Advance_line(
      dayTripId: dayTripId ?? this.dayTripId,
      expenseCategId: expenseCategId ?? this.expenseCategId,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      total_amount: total_amount ?? this.total_amount,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayTripId': dayTripId,
      'expenseCategId': expenseCategId,
      'quantity': quantity,
      'amount': amount,
      'total_amount': total_amount,
      'remark': remark,
    };
  }

  factory Advance_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Advance_line(
      dayTripId: map['dayTripId'],
      expenseCategId: map['expenseCategId'],
      quantity: map['quantity'],
      amount: map['amount'],
      total_amount: map['total_amount'],
      remark: map['remark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Advance_line.fromJson(String source) =>
      Advance_line.fromMap(json.decode(source));

  @override
  String toString() =>
      'Advance_line(dayTripId: $dayTripId, expenseCategId: $expenseCategId,quantity: $quantity, amount: $amount,total_amount: $total_amount, remark: $remark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Advance_line &&
        o.dayTripId == dayTripId &&
        o.expenseCategId == expenseCategId &&
        o.quantity == quantity &&
        o.amount == amount &&
        o.total_amount == total_amount &&
        o.remark == remark;
  }

  @override
  int get hashCode =>
      dayTripId.hashCode ^
      expenseCategId.hashCode ^
      quantity.hashCode ^
      amount.hashCode ^
      total_amount.hashCode ^
      remark.hashCode;
}
