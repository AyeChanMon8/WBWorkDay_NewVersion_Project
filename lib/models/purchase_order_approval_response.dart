import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'company.dart';

class PurchaseOrderApprovalResponse {
  int id;
  String name;
  String partner_name;
  double amount_total;
  Currency? currency_id;
  Company? company_id;
  Branch_id? branch_id;
  Department_id? department_id;
  bool state;
  List<OrderLine>? order_line;
  List<String>? reject_reasons_list;

  PurchaseOrderApprovalResponse(
      {this.id = 0,
      this.name = '',
      this.partner_name = '',
      this.amount_total = 0.0,
      this.currency_id,
      this.company_id,
      this.branch_id,
      this.department_id,
      this.state = false,
      this.order_line,
      this.reject_reasons_list});

  PurchaseOrderApprovalResponse copyWith({int? id, String? name}) {
    return PurchaseOrderApprovalResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        partner_name: partner_name ?? this.partner_name,
        amount_total: amount_total ?? this.amount_total,
        currency_id: currency_id ?? this.currency_id,
        company_id: company_id ?? this.company_id,
        branch_id: branch_id ?? this.branch_id,
        department_id: department_id ?? this.department_id,
        state: state ?? this.state,
        order_line: order_line ?? this.order_line,
        reject_reasons_list: reject_reasons_list ?? this.reject_reasons_list);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'partner_name': partner_name,
      'amount_total': amount_total,
      'currency_id': currency_id?.toMap(),
      'company_id': company_id?.toMap(),
      'branch_id': branch_id?.toMap(),
      'department_id': department_id?.toMap(),
      'state': state,
      'order_line': order_line?.map((x) => x?.toMap())?.toList(),
      'reject_reasons_list': reject_reasons_list?.map((x) => x)?.toList(),
    };
  }

  factory PurchaseOrderApprovalResponse.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PurchaseOrderApprovalResponse(
      id: map['id'],
      name: map['name'],
      partner_name: map['partner_name'],
      amount_total: map['amount_total'],
      currency_id: Currency.fromMap(map['currency_id']),
      company_id: Company.fromMap(map['company_id']),
      branch_id: Branch_id.fromMap(map['branch_id']),
      department_id: Department_id.fromMap(map['department_id']),
      state: map['state'],
      order_line: List<OrderLine>.from(
          map['order_line']?.map((x) => OrderLine.fromMap(x))),
      reject_reasons_list: List<String>.from(
          map['reject_reasons_list']?.map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseOrderApprovalResponse.fromJson(String source) =>
      PurchaseOrderApprovalResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'PurchaseOrderApprovalResponse(id: $id, name: $name,partner_name: $partner_name, amount_total: $amount_total, currency_id: $currency_id,company_id: $company_id, branch_id: $branch_id, department_id: $department_id,state: $state, order_line: $order_line, reject_reasons_list: $reject_reasons_list)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PurchaseOrderApprovalResponse &&
        o.id == id &&
        o.name == name &&
        o.partner_name == partner_name &&
        o.amount_total == amount_total &&
        o.currency_id == currency_id &&
        o.company_id == company_id &&
        o.branch_id == branch_id &&
        o.department_id == department_id &&
        o.state == state &&
        o.order_line == order_line &&
        o.reject_reasons_list == reject_reasons_list;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      partner_name.hashCode ^
      amount_total.hashCode ^
      currency_id.hashCode ^
      company_id.hashCode ^
      branch_id.hashCode ^
      department_id.hashCode ^
      state.hashCode ^
      order_line.hashCode ^
      reject_reasons_list.hashCode;
}

// class PurchaseOrderApprovalResponse {
//   int id;
//   String name;
//   String partner_name;
//   double amount_total;
//   Currency currency_id;
//   Company company_id;
//   Branch_id branch_id;
//   Department_id department_id;
//   bool state;
//   List<OrderLine> order_line;
//   List<String> reject_reasons_list;
//   PurchaseOrderApprovalResponse({
//     this.id,
//     this.name,
//     this.partner_name,
//     this.amount_total,
//     this.currency_id,
//     this.company_id,
//     this.branch_id,
//     this.department_id,
//     this.state,
//     this.order_line,
//     this.reject_reasons_list
//   });

//   PurchaseOrderApprovalResponse copyWith({
//     int id,
//     String name,
//     String partner_name,
//     double amount_total,
//     Currency currency_id,
//     Company company_id,
//     Branch_id branch_id,
//     Department_id department_id,
//     bool state,
//     List<OrderLine> order_line,
//     List<String> reject_reasons_list,
//   }) {
//     return PurchaseOrderApprovalResponse(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       partner_name: partner_name ?? this.partner_name,
//       amount_total: amount_total ?? this.amount_total,
//       currency_id: currency_id ?? this.currency_id,
//       company_id: company_id ?? this.company_id,
//       branch_id: branch_id ?? this.branch_id,
//       department_id: department_id ?? this.department_id,
//       state: state ?? this.state,
//       order_line: order_line ?? this.order_line,
//       reject_reasons_list: reject_reasons_list ?? this.reject_reasons_list,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'partner_name':partner_name,
//       'amount_total': amount_total,
//       'currency_id': currency_id?.toMap(),
//       'company_id':company_id?.toMap(),
//       'branch_id': branch_id?.toMap(),
//       'department_id': department_id?.toMap(),
//       'state': state,
//       'order_line': order_line?.map((x) => x?.toMap())?.toList(),
//       'reject_reasons_list': reject_reasons_list
//     };
//   }

//   factory PurchaseOrderApprovalResponse.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return PurchaseOrderApprovalResponse(
//       id: map['id'],
//       name: map['name'],
//       partner_name: map['partner_name'],
//       amount_total: map['amount_total'],
//       currency_id: Currency.fromMap(map['currency_id']),
//       company_id: Company.fromMap(map['company_id']),
//       branch_id: Branch_id.fromMap(map['branch_id']),
//       department_id: Department_id.fromMap(map['department_id']),
//       state: map['state'],
//       order_line: List<OrderLine>.from(map['order_line']?.map((x) => OrderLine.fromMap(x))),
//       reject_reasons_list: List<String>.from(map['reject_reasons_list']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PurchaseOrderApprovalResponse.fromJson(String source) => PurchaseOrderApprovalResponse.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'PurchaseOrderApprovalResponse(id: $id, name: $name, partner_name: $partner_name, amount_total: $amount_total, currency_id: $currency_id, company_id: $company_id, branch_id: $branch_id, department_id: $department_id, state: $state, order_line: $order_line, reject_reasons_list: $reject_reasons_list)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is PurchaseOrderApprovalResponse &&
//       o.id == id &&
//       o.name == name &&
//       o.partner_name == partner_name &&
//       o.amount_total == amount_total &&
//       o.currency_id == currency_id &&
//       o.company_id == company_id &&
//       o.branch_id == branch_id &&
//       o.department_id == department_id &&
//       o.state == state &&
//       listEquals(o.order_line, order_line) &&
//       o.reject_reasons_list == reject_reasons_list;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       name.hashCode ^
//       partner_name.hashCode ^
//       amount_total.hashCode ^
//       currency_id.hashCode ^
//       company_id.hashCode ^
//       branch_id.hashCode ^
//       department_id.hashCode ^
//       state.hashCode ^
//       order_line.hashCode ^
//       reject_reasons_list.hashCode;
//   }
// }

class Product_id {
  final dynamic id;
  final dynamic name;
  Product_id({
    this.id,
    this.name,
  });

  Product_id copyWith({
    dynamic id,
    dynamic name,
  }) {
    return Product_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Product_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Product_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product_id.fromJson(String source) =>
      Product_id.fromMap(json.decode(source));

  @override
  String toString() => 'Product_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Vehicle_id {
  final dynamic id;
  final dynamic name;
  Vehicle_id({
    this.id,
    this.name,
  });

  Vehicle_id copyWith({
    dynamic id,
    dynamic name,
  }) {
    return Vehicle_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Vehicle_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Vehicle_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle_id.fromJson(String source) =>
      Vehicle_id.fromMap(json.decode(source));

  @override
  String toString() => 'Vehicle_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vehicle_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class ProductUom {
  final dynamic id;
  final dynamic name;
  ProductUom({
    this.id,
    this.name,
  });

  ProductUom copyWith({
    dynamic id,
    dynamic name,
  }) {
    return ProductUom(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ProductUom.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ProductUom(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductUom.fromJson(String source) =>
      ProductUom.fromMap(json.decode(source));

  @override
  String toString() => 'ProductUom(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductUom && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class OrderLine {
  Category? categ_id;
  Product_id? product_id;
  Vehicle_id? vehicle_id;
  double product_qty;
  double qty_received;
  double qty_invoiced;
  ProductUom? product_uom;
  double price_unit;
  double price_subtotal;
  OrderLine(
      {this.categ_id,
      this.product_id,
      this.vehicle_id,
      this.product_qty = 0.0,
      this.qty_received = 0.0,
      this.qty_invoiced = 0.0,
      this.product_uom,
      this.price_unit = 0.0,
      this.price_subtotal = 0.0});

  OrderLine copyWith(
      {Category? categ_id,
      Product_id? product_id,
      Vehicle_id? vehicle_id,
      double? product_qty,
      double? qty_received,
      double? qty_invoiced,
      ProductUom? product_uom,
      double? price_unit,
      double? price_subtotal}) {
    return OrderLine(
      categ_id: categ_id ?? this.categ_id,
      product_id: product_id ?? this.product_id,
      vehicle_id: vehicle_id ?? this.vehicle_id,
      product_qty: product_qty ?? this.product_qty,
      qty_received: qty_received ?? this.qty_received,
      qty_invoiced: qty_invoiced ?? this.qty_invoiced,
      product_uom: product_uom ?? this.product_uom,
      price_unit: price_unit ?? this.price_unit,
      price_subtotal: price_subtotal ?? this.price_subtotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categ_id': categ_id?.toMap(),
      'product_id': product_id?.toMap(),
      'vehicle_id': vehicle_id?.toMap(),
      'product_qty': product_qty,
      'qty_received': qty_received,
      'qty_invoiced': qty_invoiced,
      'product_uom': product_uom?.toMap(),
      'price_unit': price_unit,
      'price_subtotal': price_subtotal,
    };
  }

  factory OrderLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return OrderLine(
      categ_id: Category.fromMap(map['categ_id']),
      product_id: Product_id.fromMap(map['product_id']),
      vehicle_id: Vehicle_id.fromMap(map['vehicle_id']),
      product_qty: map['product_qty'],
      qty_received: map['qty_received'],
      qty_invoiced: map['qty_invoiced'],
      product_uom: ProductUom.fromMap(map['product_uom']),
      price_unit: map['price_unit'],
      price_subtotal: map['price_subtotal'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderLine.fromJson(String source) =>
      OrderLine.fromMap(json.decode(source));

  @override
  String toString() => 'OrderLine(categ_id: $categ_id, product_id: $product_id,vehicle_id: $vehicle_id, product_qty: $product_qty,qty_received: $qty_received, qty_invoiced: $qty_invoiced,product_uom: $product_uom, price_unit: $price_unit, price_subtotal: $price_subtotal)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OrderLine && o.categ_id == categ_id && o.product_id == product_id &&
    o.vehicle_id == vehicle_id && o.product_qty == product_qty &&
    o.qty_received == qty_received && o.qty_invoiced == qty_invoiced &&
    o.product_uom == product_uom && o.price_unit == price_unit && o.price_subtotal == price_subtotal;
  }

  @override
  int get hashCode => categ_id.hashCode ^ product_id.hashCode ^ vehicle_id.hashCode ^ product_qty.hashCode
   ^ qty_received.hashCode ^ qty_invoiced.hashCode ^ product_uom.hashCode ^ price_unit.hashCode
   ^ price_subtotal.hashCode;
}

// class OrderLine {
//   Category categ_id;
//   Product_id product_id;
//   Vehicle_id vehicle_id;
//   double product_qty;
//   double qty_received;
//   double qty_invoiced;
//   ProductUom product_uom;
//   double price_unit;
//   double price_subtotal;
//   OrderLine({
//     this.categ_id,
//     this.product_id,
//     this.vehicle_id,
//     this.product_qty,
//     this.qty_received,
//     this.qty_invoiced,
//     this.product_uom,
//     this.price_unit,
//     this.price_subtotal,
//   });

//   OrderLine copyWith({
//     Category categ_id,
//     Product_id product_id,
//     Vehicle_id vehicle_id,
//     double product_qty,
//     double qty_received,
//     double qty_invoiced,
//     ProductUom product_uom,
//     double price_unit,
//     double price_subtotal,
//   }) {
//     return OrderLine(
//         categ_id: categ_id ?? this.categ_id,
//         product_id: product_id ?? this.product_id,
//         vehicle_id: vehicle_id ?? this.vehicle_id,
//         product_qty: product_qty ?? this.product_qty,
//         qty_received: qty_received ?? this.qty_received,
//         qty_invoiced: qty_invoiced ?? this.qty_invoiced,
//         product_uom: product_uom ?? this.product_uom,
//         price_unit: price_unit ?? this.price_unit,
//         price_subtotal: price_subtotal ?? this.price_subtotal);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'categ_id': categ_id?.toMap(),
//       'product_id': product_id?.toMap(),
//       'vehicle_id': vehicle_id?.toMap(),
//       'product_qty': product_qty,
//       'qty_received': qty_received,
//       'qty_invoiced': qty_invoiced,
//       'product_uom': product_uom?.toMap(),
//       'price_unit': price_unit,
//       'price_subtotal': price_subtotal,
//     };
//   }

//   factory OrderLine.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return OrderLine(
//       categ_id: Category.fromMap(map['categ_id']),
//       product_id: Product_id.fromMap(map['product_id']),
//       vehicle_id: Vehicle_id.fromMap(map['vehicle_id']),
//       product_qty: map['product_qty'],
//       qty_received: map['qty_received'],
//       qty_invoiced: map['qty_invoiced'],
//       product_uom: ProductUom.fromMap(map['product_uom']),
//       price_unit: map['price_unit'],
//       price_subtotal: map['price_subtotal'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory OrderLine.fromJson(String source) =>
//       OrderLine.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'OrderLine(categ_id: $categ_id, product_id: $product_id, vehicle_id: $vehicle_id, product_qty: $product_qty, qty_received: $qty_received, qty_invoiced: $qty_invoiced, product_uom: $product_uom, price_unit: $price_unit,price_subtotal: $price_subtotal)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is OrderLine &&
//         o.categ_id == categ_id &&
//         o.product_id == product_id &&
//         o.vehicle_id == vehicle_id &&
//         o.product_qty == product_qty &&
//         o.qty_received == qty_received &&
//         o.qty_invoiced == qty_invoiced &&
//         o.product_uom == product_uom &&
//         o.price_unit == price_unit &&
//         o.price_subtotal == price_subtotal;
//   }

//   @override
//   int get hashCode {
//     return categ_id.hashCode ^
//         product_id.hashCode ^
//         vehicle_id.hashCode ^
//         product_qty.hashCode ^
//         qty_received.hashCode ^
//         qty_invoiced.hashCode ^
//         product_uom.hashCode ^
//         price_unit.hashCode ^
//         price_subtotal.hashCode;
//   }
// }

class Currency {
  final dynamic id;
  final dynamic name;
  Currency({
    this.id,
    this.name,
  });

  Currency copyWith({
    dynamic id,
    dynamic name,
  }) {
    return Currency(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Currency(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  String toString() => 'Currency(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Currency && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Branch_id {
  final dynamic id;
  final dynamic name;
  Branch_id({
    this.id,
    this.name,
  });

  Branch_id copyWith({
    dynamic id,
    dynamic name,
  }) {
    return Branch_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Branch_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Branch_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch_id.fromJson(String source) =>
      Branch_id.fromMap(json.decode(source));

  @override
  String toString() => 'Branch_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Branch_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Category {
  final dynamic id;
  final dynamic name;
  Category({
    this.id,
    this.name,
  });

  Category copyWith({
    dynamic id,
    dynamic name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Category(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Category && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Department_id {
  final dynamic id;
  final dynamic name;
  Department_id({
    this.id,
    this.name,
  });

  Department_id copyWith({
    dynamic id,
    dynamic name,
  }) {
    return Department_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Department_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Department_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Department_id.fromJson(String source) =>
      Department_id.fromMap(json.decode(source));

  @override
  String toString() => 'Department_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Department_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
