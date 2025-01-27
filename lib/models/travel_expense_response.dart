

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/expense_category.dart';

class TravelExpenseResponse {
  ExpenseCategory? expense_categ_id;
  double quantity;
  double amount;
  double total_amount;
  String remark;
  TravelExpenseResponse(
      {this.expense_categ_id,
      this.quantity = 0.0,
      this.amount = 0.0,
      this.total_amount = 0.0,
      this.remark = ''});

  TravelExpenseResponse copyWith({
    ExpenseCategory? expense_categ_id,
  double? quantity,
  double? amount,
  double? total_amount,
  String? remark
  }) {
    return TravelExpenseResponse(
      expense_categ_id: expense_categ_id ?? this.expense_categ_id,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      total_amount: total_amount ?? this.total_amount,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_categ_id': expense_categ_id?.toMap(),
      'quantity': quantity,
      'amount': amount,
      'total_amount': total_amount,
      'remark': remark,
      // 'name': name,
    };
  }

  factory TravelExpenseResponse.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelExpenseResponse(
      expense_categ_id: ExpenseCategory.fromMap(map['expense_categ_id']),
      quantity: map['quantity'],
      amount: map['amount'],
      total_amount: map['total_amount'],
      remark: map['remark']??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelExpenseResponse.fromJson(String source) =>
      TravelExpenseResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'TravelExpenseResponse(expense_categ_id: $expense_categ_id, quantity: $quantity,amount: $amount, total_amount: $total_amount,remark: $remark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelExpenseResponse &&
        o.expense_categ_id == expense_categ_id &&
        o.quantity == quantity &&
        o.amount == amount &&
        o.total_amount == total_amount &&
        o.remark == remark;
  }

  @override
  int get hashCode => expense_categ_id.hashCode ^ quantity.hashCode ^ amount.hashCode ^ total_amount.hashCode ^ remark.hashCode;
}


// class TravelExpenseResponse {
//   ExpenseCategory expense_categ_id;
//   double quantity;
//   double amount;
//   double total_amount;
//   String remark;
  
//   TravelExpenseResponse({
//     this.expense_categ_id,
//     this.quantity,
//     this.amount,
//     this.total_amount,
//     this.remark,
//   });

//   TravelExpenseResponse copyWith({
//     ExpenseCategory expense_categ_id,
//     double quantity,
//     double amount,
//     double total_amount,
//     String remark,
//   }) {
//     return TravelExpenseResponse(
//       expense_categ_id: expense_categ_id ?? this.expense_categ_id,
//       quantity: quantity ?? this.quantity,
//       amount: amount ?? this.amount,
//       total_amount: total_amount ?? this.total_amount,
//       remark: remark ?? this.remark,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'expense_categ_id': expense_categ_id?.toMap(),
//       'quantity': quantity,
//       'amount': amount,
//       'total_amount': total_amount,
//       'remark': remark,
//     };
//   }

//   factory TravelExpenseResponse.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return TravelExpenseResponse(
//       expense_categ_id: ExpenseCategory.fromMap(map['expense_categ_id']),
//       quantity: map['quantity']??0.0,
//       amount: map['amount']??0.0,
//       total_amount: map['total_amount']??0.0,
//       remark: map['remark']??'',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TravelExpenseResponse.fromJson(String source) =>
//       TravelExpenseResponse.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'TravelExpenseResponse(expense_categ_id: $expense_categ_id, quantity: $quantity, amount: $amount, total_amount: $total_amount, remark: $remark)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is TravelExpenseResponse &&
//         o.expense_categ_id == expense_categ_id &&
//         o.quantity == quantity &&
//         o.amount == amount &&
//         o.total_amount == total_amount &&
//         o.remark == remark;
//   }

//   @override
//   int get hashCode {
//     return expense_categ_id.hashCode ^
//         quantity.hashCode ^
//         amount.hashCode ^
//         total_amount.hashCode ^
//         remark.hashCode;
//   }
// }
