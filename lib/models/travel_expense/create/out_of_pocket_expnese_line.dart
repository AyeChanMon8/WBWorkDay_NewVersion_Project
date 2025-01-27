import 'dart:convert';

class OutofPocketExpenseLine {
  int line_id;
  String date;
  int categ_id;
  int product_id;
  String description;
  double qty;
  double price_unit;
  double price_subtotal;
  OutofPocketExpenseLine({
    this.line_id = 0,
    this.date = '',
    this.categ_id = 0,
    this.product_id = 0,
    this.description = '',
    this.qty = 0.0,
    this.price_unit = 0.0,
    this.price_subtotal = 0.0,
  });

  OutofPocketExpenseLine copyWith({
    required int line_id,
    required String date,
    required int categ_id,
    required int product_id,
    required String description,
    required double qty,
    required double price_unit,
    required double price_subtotal,
  }) {
    return OutofPocketExpenseLine(
      line_id: line_id ?? this.line_id,
      date: date ?? this.date,
      categ_id: categ_id ?? this.categ_id,
      product_id: product_id ?? this.product_id,
      description: description ?? this.description,
      qty: qty ?? this.qty,
      price_unit: price_unit ?? this.price_unit,
      price_subtotal: price_subtotal ?? this.price_subtotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'line_id': line_id,
      'date': date,
      'categ_id': categ_id,
      'product_id': product_id,
      'description': description,
      'qty': qty,
      'price_unit': price_unit,
      'price_subtotal': price_subtotal,
    };
  }

  factory OutofPocketExpenseLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OutofPocketExpenseLine(
      line_id: map['line_id'],
      date: map['date'],
      categ_id: map['categ_id'],
      product_id: map['product_id'],
      description: map['description'],
      qty: map['qty'],
      price_unit: map['price_unit'],
      price_subtotal: map['price_subtotal'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OutofPocketExpenseLine.fromJson(String source) =>
      OutofPocketExpenseLine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OutofPocketExpenseLine(line_id: $line_id, date: $date, categ_id: $categ_id, product_id: $product_id, description: $description, qty: $qty, price_unit: $price_unit, price_subtotal: $price_subtotal)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OutofPocketExpenseLine &&
        o.line_id == line_id &&
        o.date == date &&
        o.categ_id == categ_id &&
        o.product_id == product_id &&
        o.description == description &&
        o.qty == qty &&
        o.price_unit == price_unit &&
        o.price_subtotal == price_subtotal;
  }

  @override
  int get hashCode {
    return line_id.hashCode ^
        date.hashCode ^
        categ_id.hashCode ^
        product_id.hashCode ^
        description.hashCode ^
        qty.hashCode ^
        price_unit.hashCode ^
        price_subtotal.hashCode;
  }
}
