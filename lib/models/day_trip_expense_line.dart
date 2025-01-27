import 'dart:convert';

import 'package:flutter/foundation.dart';

class DayTripExpenseLine {
  List<Expense> expenseIds;
  DayTripExpenseLine({
    required this.expenseIds,
  });

  DayTripExpenseLine copyWith({
    required List<Expense> expenseIds,
  }) {
    return DayTripExpenseLine(
      expenseIds: expenseIds ?? this.expenseIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_ids': expenseIds?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory DayTripExpenseLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DayTripExpenseLine(
      expenseIds: List<Expense>.from(
          map['expense_ids']?.map((x) => Expense.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DayTripExpenseLine.fromJson(String source) =>
      DayTripExpenseLine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DayTripExpenseLine(expenseIds: $expenseIds)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DayTripExpenseLine && listEquals(o.expenseIds, expenseIds);
  }

  @override
  int get hashCode {
    return expenseIds.hashCode;
  }
}

class Expense {
  int productId;
  String name;
  double amount;
  int day_trip_id;
  String image;

  Expense(
      {this.productId = 0,
      this.name = '',
      this.amount = 0.0,
      this.day_trip_id = 0,
      this.image = ''});

  Expense copyWith(
      {int? productId,
      String? name,
      double? amount,
      int? day_trip_id,
      String? image}) {
    return Expense(
        productId: productId ?? this.productId,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        day_trip_id: day_trip_id ?? this.day_trip_id,
        image: image ?? this.image);
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'name': name,
      'amount': amount,
      'day_trip_id': day_trip_id,
      'attached_file': image
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Expense(
        productId: map['product_id'],
        name: map['name'],
        amount: map['amount'],
        day_trip_id: map['day_trip_id'],
        image: map['attached_file']);
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Expense(productId: $productId, name: $name, amount: $amount, day_trip_id: $day_trip_id, image: $image)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Expense &&
        o.productId == productId &&
        o.name == name &&
        o.amount == amount &&
        o.day_trip_id == day_trip_id &&
        o.image == image;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        name.hashCode ^
        amount.hashCode ^
        day_trip_id.hashCode ^
        image.hashCode;
  }
}
