
import 'dart:convert';

class Plantrip_product_adavance_line {
  int tripProductId;
  int expenseCategId;
  int quantity;
  int amount;
  int total_amount;
  String remark;
  Plantrip_product_adavance_line({this.tripProductId = 0, this.expenseCategId = 0,
  this.quantity = 0, this.amount = 0, this.total_amount = 0,
  this.remark = ''});

  Plantrip_product_adavance_line copyWith({int? id, String? name}) {
    return Plantrip_product_adavance_line(
      tripProductId: tripProductId ?? this.tripProductId,
      expenseCategId: expenseCategId ?? this.expenseCategId,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      total_amount: total_amount ?? this.total_amount,
      remark: remark ?? this.remark
    );
  }

  Map<String, dynamic> toMap() {
    return {'trip_product_id': tripProductId, 
    'expense_categ_id': expenseCategId,
    'quantity': quantity, 
    'amount': amount,
    'total_amount': total_amount,
    'remark': remark,
    };
  }

  factory Plantrip_product_adavance_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plantrip_product_adavance_line(
      tripProductId: map['trip_product_id'],
      expenseCategId: map['expense_categ_id'],
      quantity: map['quantity'],
      amount: map['amount'],
      total_amount: map['total_amount'],
      remark: map['remark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip_product_adavance_line.fromJson(String source) =>
      Plantrip_product_adavance_line.fromMap(json.decode(source));

  @override
  String toString() => 'Plantrip_product_adavance_line(tripProductId: $tripProductId, expenseCategId: $expenseCategId,quantity: $quantity, amount: $amount,total_amount: $total_amount, remark: $remark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plantrip_product_adavance_line && o.tripProductId == tripProductId && o.expenseCategId == expenseCategId && o.quantity == quantity && o.amount == amount
    && o.total_amount == total_amount && o.remark == remark;
  }

  @override
  int get hashCode => tripProductId.hashCode ^ expenseCategId.hashCode ^ quantity.hashCode ^ amount.hashCode ^ total_amount.hashCode ^ remark.hashCode;
}

// class Plantrip_product_adavance_line {
//   int _tripProductId;
//   int _expenseCategId;
//   int _quantity;
//   int _amount;
//   int _total_amount;
//   String _remark;

//   int get tripProductId => _tripProductId;
//   int get expenseCategId => _expenseCategId;
//   int get quantity => _quantity;
//   int get amount => _amount;
//   int get totalAmount => _total_amount;
//   String get remark => _remark;

//   Plantrip_product_adavance_line({
//       int tripProductId, 
//       int expenseCategId, 
//       int quantity, 
//       int amount,
//       int totalAmount,
//       String remark}){
//     _tripProductId = tripProductId;
//     _expenseCategId = expenseCategId;
//     _quantity = quantity;
//     _amount = amount;
//     _total_amount = totalAmount;
//     _remark = remark;
// }

//   Plantrip_product_adavance_line.fromJson(dynamic json) {
//     _tripProductId = json["trip_product_id"];
//     _expenseCategId = json["expense_categ_id"];
//     _quantity = json["quantity"];
//     _amount = json["amount"];
//     _total_amount = json["total_amount"];
//     _remark = json["remark"];
//   }

//   String toJson() => json.encode(toMap());

//   Map<String, dynamic> toMap() {
//     return {
//       'trip_product_id': _tripProductId,
//       'expense_categ_id': _expenseCategId,
//       'quantity': _quantity,
//       'amount': _amount,
//       'total_amount' : _total_amount,
//       'remark': _remark,
//     };
//   }

// }