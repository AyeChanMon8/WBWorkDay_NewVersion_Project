import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/travel_expense/category_model.dart';

class PockectModel {
  String date;
  int categ_id;
  String expense_category;
  int product_id;
  String description;
  double qty;
  double price_unit;
  double price_subtotal;
  String attached_file;
  int vehicle_id;
  int line_id;
  int id;
  bool attachment_include = false;

  PockectModel(
      {this.date = '',
      this.categ_id = 0,
      this.expense_category = '',
      this.product_id = 0,
      this.description = '',
      this.qty = 0.0,
      this.price_unit = 0.0,
      this.price_subtotal = 0.0,
      this.attached_file = '',
      this.vehicle_id = 0,
      this.line_id = 0,
      this.id = 0,
      this.attachment_include = false});

  PockectModel copyWith(
      {String? date,
      int? categ_id,
      String? expense_category,
      int? product_id,
      String? description,
      double? qty,
      double? price_unit,
      double? price_subtotal,
      String? attached_file,
      int? vehicle_id,
      int? line_id}) {
    return PockectModel(
        date: date ?? this.date,
        categ_id: categ_id ?? this.categ_id,
        expense_category: expense_category ?? this.expense_category,
        product_id: product_id ?? this.product_id,
        description: description ?? this.description,
        qty: qty ?? this.qty,
        price_unit: price_unit ?? this.price_unit,
        price_subtotal: price_subtotal ?? this.price_subtotal,
        attached_file: attached_file ?? this.attached_file,
        vehicle_id: vehicle_id ?? this.vehicle_id,
        line_id: line_id ?? this.line_id,
        id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'categ_id': categ_id,
      'product_id': product_id,
      'description': description,
      'qty': qty,
      'price_unit': price_unit,
      'price_subtotal': price_subtotal,
      'attached_file': attached_file,
      'vehicle_id': vehicle_id,
      'line_id': line_id,
      'id': id,
      'attachment_include': attachment_include
    };
  }

  factory PockectModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PockectModel(
      date: map['date'],
      categ_id: map['categ_id'],
      expense_category: map['expense_category'],
      product_id: map['product_id'],
      description: map['description'],
      qty: map['qty'],
      price_unit: map['price_unit'],
      price_subtotal: map['price_subtotal'],
      attached_file: map['attached_file'],
      vehicle_id: map['vehicle_id'],
      line_id: map['line_id'],
      attachment_include: map['attachment_include'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PockectModel.fromJson(String source) =>
      PockectModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PockectModel(date: $date, categ_id: $categ_id, expense_category: $expense_category, product_id: $product_id, description: $description, qty: $qty, price_unit: $price_unit, price_subtotal: $price_subtotal, attached_file: $attached_file,vehicle_id: $vehicle_id,line_id: $line_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PockectModel &&
        o.date == date &&
        o.categ_id == categ_id &&
        o.expense_category == expense_category &&
        o.product_id == product_id &&
        o.description == description &&
        o.qty == qty &&
        o.price_unit == price_unit &&
        o.price_subtotal == price_subtotal &&
        o.attached_file == attached_file;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        categ_id.hashCode ^
        expense_category.hashCode ^
        product_id.hashCode ^
        description.hashCode ^
        qty.hashCode ^
        price_unit.hashCode ^
        price_subtotal.hashCode ^
        attached_file.hashCode;
  }
}
