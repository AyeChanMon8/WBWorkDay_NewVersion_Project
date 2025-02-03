import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../day_trip_model.dart';
import '../category_model.dart';
import '../product_model.dart';

class TravelLineListModel {
  int id;
  String date;
  CategoryModel categ_id;
  ProductModel product_id;
  String description;
  double qty;
  double price_unit;
  double price_subtotal;
  String attachment_filename;
  String attached_file;
  Vehicle_id vehicle_id;
  bool attachment_include;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String image7;
  String image8;
  String image9;
  TravelLineListModel(
      {this.id = 0,
      this.date = "",
      required this.categ_id,
      required this.product_id,
      this.description = "",
      this.qty = 0.0,
      this.price_unit = 0.0,
      this.price_subtotal = 0.0,
      this.attachment_filename = '',
      this.attached_file = '',
      required this.vehicle_id,
      this.image1 = '',
      this.image2 = '',
      this.image3 = '',
      this.image4 = '',
      this.image5 = '',
      this.image6 = '',
      this.image7 = '',
      this.image8 = '',
      this.image9 = '',
      this.attachment_include = false});

  TravelLineListModel copyWith(
      {int? id,
      String? date,
      required CategoryModel categ_id,
      required ProductModel product_id,
      String? description,
      double? qty,
      double? price_unit,
      double? price_subtotal,
      String? attachment_filename,
      String? attached_file,
      required Vehicle_id vehicle_id,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String? image5,
      String? image6,
      String? image7,
      String? image8,
      String? image9}) {
    return TravelLineListModel(
      id: id ?? this.id,
      date: date ?? this.date,
      categ_id: categ_id ?? this.categ_id,
      product_id: product_id ?? this.product_id,
      description: description ?? this.description,
      qty: qty ?? this.qty,
      price_unit: price_unit ?? this.price_unit,
      price_subtotal: price_subtotal ?? this.price_subtotal,
      attachment_filename: attachment_filename ?? this.attachment_filename,
      attached_file: attached_file ?? this.attached_file,
      vehicle_id: vehicle_id ?? this.vehicle_id,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      image3: image3 ?? this.image3,
      image4: image4 ?? this.image4,
      image5: image5 ?? this.image5,
      image6: image6 ?? this.image6,
      image7: image7 ?? this.image7,
      image8: image8 ?? this.image8,
      image9: image9 ?? this.image9,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'categ_id': categ_id?.toMap(),
      'product_id': product_id?.toMap(),
      'description': description,
      'qty': qty,
      'price_unit': price_unit,
      'price_subtotal': price_subtotal,
      'attached_filename': attachment_filename,
      'attached_file': attached_file,
      'vehicle_id': vehicle_id
    };
  }

  factory TravelLineListModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TravelLineListModel(
        id: map['id'],
        date: map['date']?? '',
        categ_id: CategoryModel.fromMap(map['categ_id']),
        product_id: ProductModel.fromMap(map['product_id']),
        description: map['description']?? '',
        qty: map['qty'] ?? 0.0,
        price_unit: map['price_unit'] ?? 0.0,
        price_subtotal: map['price_subtotal'] ?? 0.0,
        attachment_filename: map['attached_filename'] ?? "",
        attached_file: map['attached_file'] ?? "",
        vehicle_id: Vehicle_id.fromMap(map['vehicle_id']),
        image1: map['image1'] ?? '',
        image2: map['image2'] ?? '',
        image3: map['image3'] ?? '',
        image4: map['image4'] ?? '',
        image5: map['image5'] ?? '',
        image6: map['image6'] ?? '',
        image7: map['image7'] ?? '',
        image8: map['image8'] ?? '',
        image9: map['image9'] ?? '',
        attachment_include: map['attachment_include'] != null
            ? map['attachment_include']
            : false);
  }

  String toJson() => json.encode(toMap());

  factory TravelLineListModel.fromJson(String source) =>
      TravelLineListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TravelLineListModel(id:$id, date: $date, categ_id: $categ_id, product_id: $product_id, description: $description, qty: $qty, price_unit: $price_unit, price_subtotal: $price_subtotal, attachment_filename: $attachment_filename, attached_file:$attached_file,vehicle_id: $vehicle_id,image1: $image1, image2: $image2, image3: $image3, image4: $image4, image5: $image5, image6: $image6, image7: $image7, image8: $image8, image9: $image9)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TravelLineListModel &&
        o.date == date &&
        o.categ_id == categ_id &&
        o.product_id == product_id &&
        o.description == description &&
        o.qty == qty &&
        o.price_unit == price_unit &&
        o.price_subtotal == price_subtotal &&
        o.attachment_filename == attachment_filename &&
        o.image1 == image1 &&
        o.image2 == image2 &&
        o.image3 == image3 &&
        o.image4 == image4 &&
        o.image5 == image5 &&
        o.image6 == image6 &&
        o.image7 == image7 &&
        o.image8 == image8 &&
        o.image9 == image9 &&
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
        attachment_filename.hashCode ^
        image1.hashCode ^
        image2.hashCode ^
        image3.hashCode ^
        image4.hashCode ^
        image5.hashCode ^
        image6.hashCode ^
        image7.hashCode ^
        image8.hashCode ^
        image9.hashCode ^
        attached_file.hashCode;
  }
}
