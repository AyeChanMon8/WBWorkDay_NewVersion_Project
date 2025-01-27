import 'dart:convert';

import '../../models/travel_expense/category_model.dart';
import '../../models/travel_expense/product_model.dart';

class PocketLine {
  String date;
  CategoryModel categ_id;
  ProductModel product_id;
  String description;
  double qty;
  double price_unit;
  double price_subtotal;
  String attached_file;
  Vehicle_id vehicle_id;
  bool attachment_include;
  int id;
  PocketLine(
      {this.date = '',
      required this.categ_id,
      required this.product_id,
      this.description = '',
      this.qty = 0.0,
      this.price_unit = 0.0,
      this.price_subtotal = 0.0,
      this.attached_file = '',
      required this.vehicle_id,
      this.id = 0,
      this.attachment_include = false});

  PocketLine copyWith(
      {String? date,
      required CategoryModel categ_id,
      required ProductModel product_id,
      String? description,
      double? qty,
      double? price_unit,
      double? price_subtotal,
      String? attached_file,
      required Vehicle_id vehicle_id}) {
    return PocketLine(
        date: date ?? this.date,
        categ_id: categ_id ?? this.categ_id,
        product_id: product_id ?? this.product_id,
        description: description ?? this.description,
        qty: qty ?? this.qty,
        price_unit: price_unit ?? this.price_unit,
        price_subtotal: price_subtotal ?? this.price_subtotal,
        attached_file: attached_file ?? this.attached_file,
        vehicle_id: vehicle_id ?? this.vehicle_id);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'categ_id': categ_id?.toMap(),
      'product_id': product_id?.toMap(),
      'description': description,
      'qty': qty,
      'price_unit': price_unit,
      'price_subtotal': price_subtotal,
      'attached_file': attached_file,
      'vehicle_id': vehicle_id
    };
  }

  factory PocketLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PocketLine(
        id: map['id'],
        date: map['date'],
        categ_id: CategoryModel.fromMap(map['categ_id']),
        product_id: ProductModel.fromMap(map['product_id']),
        description: map['description']?? "",
        qty: map['qty'],
        price_unit: map['price_unit'],
        price_subtotal: map['price_subtotal'],
        attached_file: map['attached_file']?? "",
        // vehicle_id: map['vehicle_id'] != null
        //     ? Vehicle_id.fromJson(map['vehicle_id'])
        // : null,
        vehicle_id: Vehicle_id.fromMap(map['vehicle_id']),
        attachment_include: map['attachment_include'] != null
            ? map['attachment_include']
            : false);
  }

  String toJson() => json.encode(toMap());

  factory PocketLine.fromJson(String source) =>
      PocketLine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PocketLine(date: $date, categ_id: $categ_id, product_id: $product_id, description: $description, qty: $qty, price_unit: $price_unit, price_subtotal: $price_subtotal, attached_file: $attached_file,vehicle_id: $vehicle_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PocketLine &&
        o.date == date &&
        o.categ_id == categ_id &&
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
        product_id.hashCode ^
        description.hashCode ^
        qty.hashCode ^
        price_unit.hashCode ^
        price_subtotal.hashCode ^
        attached_file.hashCode;
  }
}

// class Vehicle_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Vehicle_id({int id = 0, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Vehicle_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }
class Vehicle_id {
  int id;
  String name;

  Vehicle_id({this.id = 0, this.name = ''});

  Vehicle_id copyWith({int? id, String? name}) {
    return Vehicle_id(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Vehicle_id.fromMap(Map<String, dynamic> map) {
    return Vehicle_id(id: map['id']?? 0, name: map['name']?? "");
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
