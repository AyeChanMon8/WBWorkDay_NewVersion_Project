

import 'dart:convert';

class TravelExpense {
  int expense_categ_id;
  double total_amount;
  int quantity;
  int amount;
  String remark;
  String expense_name;
  TravelExpense(
      {this.expense_categ_id = 0,
      this.total_amount = 0.0,
      this.quantity = 0,
      this.amount = 0,
      this.remark = '',
      this.expense_name = ''});

  TravelExpense copyWith({
    int? expense_categ_id,
  double? total_amount,
  int? quantity,
  int? amount,
  String? remark,
  String? expense_name
  }) {
    return TravelExpense(
      expense_categ_id: expense_categ_id ?? this.expense_categ_id,
      total_amount: total_amount ?? this.total_amount,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      remark: remark ?? this.remark,
      expense_name: expense_name ?? this.expense_name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_categ_id': expense_categ_id,
      'total_amount': total_amount,
      'quantity': quantity,
      'amount': amount,
      'remark': remark,
      'expense_name': expense_name
    };
  }

  factory TravelExpense.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelExpense(
      expense_categ_id: map['expense_categ_id'],
      total_amount: map['total_amount'],
      quantity: map['quantity'],
      amount: map['amount'],
      remark: map['remark'],
      expense_name: map['expense_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelExpense.fromJson(String source) =>
      TravelExpense.fromMap(json.decode(source));

  @override
  String toString() =>
      'TravelExpense(expense_categ_id: $expense_categ_id, total_amount: $total_amount,quantity: $quantity, amount: $amount,remark: $remark, expense_name: $expense_name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelExpense &&
        o.expense_categ_id == expense_categ_id &&
        o.total_amount == total_amount &&
        o.quantity == quantity &&
        o.amount == amount &&
        o.remark == remark &&
        o.expense_name == expense_name;
  }

  @override
  int get hashCode =>
      expense_categ_id.hashCode ^
      total_amount.hashCode ^
      quantity.hashCode ^
      amount.hashCode ^
      remark.hashCode ^
      expense_name.hashCode;
}

// class TravelExpense {
//   int expense_categ_id;
//   double total_amount;
//   int quantity;
//   int amount;
//   String remark;
//   String expense_name;
//   TravelExpense({
//     this.expense_categ_id,
//     this.total_amount,
//     this.quantity,
//     this.amount,
//     this.remark,
//     this.expense_name,
//   });

//   TravelExpense copyWith({
//     int expense_categ_id,
//     double total_amount,
//     int quantity,
//     int amount,
//     String remark,
//     String expense_name,
//   }) {
//     return TravelExpense(
//       expense_categ_id: expense_categ_id ?? this.expense_categ_id,
//       total_amount: total_amount ?? this.total_amount,
//       quantity: quantity ?? this.quantity,
//       amount: amount ?? this.amount,
//       remark: remark ?? this.remark,
//       expense_name: expense_name ?? this.expense_name,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'expense_categ_id': expense_categ_id,
//       'total_amount': total_amount,
//       'quantity': quantity,
//       'amount': amount,
//       'remark': remark,
//     };
//   }

//   factory TravelExpense.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return TravelExpense(
//       expense_categ_id: map['expense_categ_id'],
//       total_amount: map['total_amount'],
//       quantity: map['quantity'],
//       amount: map['amount'],
//       remark: map['remark'],
//       expense_name: map['expense_name'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TravelExpense.fromJson(String source) =>
//       TravelExpense.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TravelExpense(expense_categ_id: $expense_categ_id, total_amount: $total_amount, quantity: $quantity, amount: $amount, remark: $remark, expense_name: $expense_name)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is TravelExpense &&
//         o.expense_categ_id == expense_categ_id &&
//         o.total_amount == total_amount &&
//         o.quantity == quantity &&
//         o.amount == amount &&
//         o.remark == remark &&
//         o.expense_name == expense_name;
//   }

//   @override
//   int get hashCode {
//     return expense_categ_id.hashCode ^
//         total_amount.hashCode ^
//         quantity.hashCode ^
//         amount.hashCode ^
//         remark.hashCode ^
//         expense_name.hashCode;
//   }
// }
