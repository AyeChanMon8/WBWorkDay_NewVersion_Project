

import 'dart:convert';

class Plantrip_waybilll_advance_line {
 int tripWaybillId;
  int expenseCategId;
  int quantity;
  int amount;
  int total_amount;
  String remark;


  Plantrip_waybilll_advance_line({
    this.tripWaybillId = 0,
    this.expenseCategId = 0,
    this.quantity = 0,
    this.amount = 0,
    this.total_amount = 0,
    this.remark = ''});

  Plantrip_waybilll_advance_line copyWith({int? tripWaybillId,
  int? expenseCategId,
  int? quantity,
  int? amount,
  int? total_amount,
  String? remark,}) {
    return Plantrip_waybilll_advance_line(
      tripWaybillId: tripWaybillId ?? this.tripWaybillId,
      expenseCategId: expenseCategId ?? this.expenseCategId,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      total_amount: total_amount ?? this.total_amount,
      remark: remark ?? this.remark
    );
  }

  Map<String, dynamic> toMap() {
    return {'trip_waybill_id': tripWaybillId, 
    'expense_categ_id': expenseCategId,
    'quantity': quantity, 
    'amount': amount,
    'total_amount': total_amount,
    'remark': remark,
    };
  }

  factory Plantrip_waybilll_advance_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plantrip_waybilll_advance_line(
      tripWaybillId: map['trip_waybill_id'],
      expenseCategId: map['expense_categ_id'],
      quantity: map['quantity'],
      amount: map['amount'],
      total_amount: map['total_amount'],
      remark: map['remark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip_waybilll_advance_line.fromJson(String source) =>
      Plantrip_waybilll_advance_line.fromMap(json.decode(source));

  @override
  String toString() => 'Plantrip_waybilll_advance_line(tripWaybillId: $tripWaybillId, expenseCategId: $expenseCategId,quantity: $quantity, amount: $amount, total_amount: $total_amount,remark: $remark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plantrip_waybilll_advance_line && o.tripWaybillId == tripWaybillId && o.expenseCategId == expenseCategId && o.quantity == quantity && o.amount == amount
    && o.total_amount == total_amount && o.remark == remark;
  }

  @override
  int get hashCode => tripWaybillId.hashCode ^ expenseCategId.hashCode ^ quantity.hashCode ^ amount.hashCode ^ total_amount.hashCode ^ remark.hashCode;
}



// class Plantrip_waybilll_advance_line {
//   int _tripWaybillId;
//   int _expenseCategId;
//   int _quantity;
//   int _amount;
//   int _total_amount;
//   String _remark;

//   int get tripWaybillId => _tripWaybillId;
//   int get expenseCategId => _expenseCategId;
//   int get quantity => _quantity;
//   int get amount => _amount;
//   int get totalAmount => _total_amount;
//   String get remark => _remark;

//   Plantrip_waybilll_advance_line({
//       int tripWaybillId, 
//       int expenseCategId, 
//       int quantity, 
//       int amount,
//       int totalAmount,
//       String remark}){
//     _tripWaybillId = tripWaybillId;
//     _expenseCategId = expenseCategId;
//     _quantity = quantity;
//     _amount = amount;
//     _total_amount = totalAmount;
//     _remark = remark;
// }

//   Plantrip_waybilll_advance_line.fromJson(dynamic json) {
//     _tripWaybillId = json["trip_waybill_id"];
//     _expenseCategId = json["expense_categ_id"];
//     _quantity = json["quantity"];
//     _amount = json["amount"];
//     _total_amount = json["total_amount"];
//     _remark = json["remark"];
//   }

//   String toJson() => json.encode(toMap());

//   Map<String, dynamic> toMap() {
//     return {
//       'trip_waybill_id': _tripWaybillId,
//       'expense_categ_id': _expenseCategId,
//       'quantity': _quantity,
//       'amount': _amount,
//       'total_amount' : _total_amount,
//       'remark': _remark,
//     };
//   }

// }